import XMonad
import qualified XMonad.StackSet as StackSet
import XMonad.StackSet(StackSet(..), Workspace(..), Screen(..), view, currentTag, focusMaster, shiftMaster, focusUp, focusDown, swapDown, swapUp, sink, shift)

import XMonad.Actions.CycleWS(nextScreen, shiftNextScreen, toggleWS', toggleOrDoSkip, skipTags)
import XMonad.Actions.Navigation2D(windowGo)
import XMonad.Actions.OnScreen(viewOnScreen)
import XMonad.Actions.PerWorkspaceKeys(bindOn)
import XMonad.Actions.Search(SearchEngine(..), search, selectSearch, searchEngine, google, amazon, hoogle, hackage, images, wikipedia, youtube)
--import XMonad.Actions.Submap(submap)
import XMonad.Actions.SpawnOn(spawnOn)
import XMonad.Actions.UpdatePointer(updatePointer)
import XMonad.Actions.WithAll(killAll)
import XMonad.Actions.WindowGo(raiseBrowser)

import XMonad.Hooks.DynamicLog(dynamicLogWithPP, PP(..), xmobarPP, xmobarColor, wrap, pad)
import XMonad.Hooks.EwmhDesktops(fullscreenEventHook)
import XMonad.Hooks.ManageDocks(manageDocks, avoidStruts)
import XMonad.Hooks.ManageHelpers(currentWs, isFullscreen, isDialog, doFullFloat, doCenterFloat)
import XMonad.Hooks.WorkspaceHistory(workspaceHistory)

import XMonad.Layout.Grid(Grid(..))
import XMonad.Layout.PerWorkspace(onWorkspace, onWorkspaces)
import XMonad.Layout.Tabbed(simpleTabbed)

import XMonad.Prompt(XPPosition(..), XPConfig(..), quit, killBefore, startOfLine, endOfLine, pasteString, moveCursor, moveWord', killWord', deleteString, setSuccess, setDone)
import XMonad.Prompt.Man(manPrompt)
import XMonad.Prompt.Shell(shellPrompt, getBrowser)

import XMonad.Util.Dmenu(menuArgs)
import XMonad.Util.NamedScratchpad(NamedScratchpad(NS), customFloating, namedScratchpadAction, namedScratchpadManageHook)
import XMonad.Util.Run(runInTerm, spawnPipe, hPutStrLn)
import XMonad.Util.Types(Direction1D(..), Direction2D(..))


import Control.Monad.Fix(fix)

import Data.Bits((.&.), shiftL)
import qualified Data.Map.Lazy as Map
import Data.Map.Lazy(Map)
import Data.Char(isSpace)
import Data.List(find, any)
import Data.Maybe(isJust)

import Graphics.X11.ExtraTypes.XF86(xF86XK_AudioMute, xF86XK_AudioPlay)

import System.Environment(getEnv)
import System.Exit(exitSuccess)


main = do
	myStatusBar <- spawnPipe "xmobar"
	xmonad def
		{ workspaces = myWorkspaces
		, layoutHook = avoidStruts myLayout
		, modMask = mod4Mask
		, terminal = "xterm"
		, keys = myKeys
		, logHook = myLogger myStatusBar >> updatePointer (0.5, 0.2) (0, 0)
		, startupHook = myStartup
		--,mouseBindings = myMouseBindings
		, manageHook = manageApps <+> manageDocks <+> namedScratchpadManageHook myScratchpads
		, handleEventHook = fullscreenEventHook
		, focusFollowsMouse = True
		, clickJustFocuses = False
		}


--["1:P", "2:P", ... "1:S", "2:S", ... "Tray"]
myWorkspaces, primaryScreenWorkspaces, secondaryScreenWorkspaces :: [WorkspaceId]
myWorkspaces = primaryScreenWorkspaces ++ secondaryScreenWorkspaces ++ ["Tray"]
primaryScreenWorkspaces = map (: ":P") ['1' .. '4']
secondaryScreenWorkspaces = map (: ":S") ['1' .. '4']

myLayout =
	onWorkspace "Tray" trayLayout
	defaultLayout
	where
		defaultLayout = horizontalLayout
		horizontalLayout = horizontal ||| simpleTabbed
		horizontal = Tall nmaster delta ratio
		--uncomment when I rotate a display again
		--verticalLayout = vertical ||| simpleTabbed
		--vertical = Mirror horizontal
		trayLayout = Grid
		nmaster = 1
		ratio = 1/2 --master pain to another
		delta = 3/100 --be used when to resize window

myLogger bar = dynamicLogWithPP $ xmobarPP
	{ ppCurrent = xmobarColor "yellow" "" . pad
	, ppVisible = xmobarColor "cyan" "" . pad
	, ppSep = "  |  "
	, ppOrder = \(ws:_:t:_) -> [ws,t]
	, ppSort = fmap (. filterOutWorkspaces ["NSP"]) $ ppSort def
	, ppOutput = hPutStrLn bar
	}

myStartup :: X ()
myStartup = do
	--Are there better solution to detect is restart?
	ws <- gets windowset
	if isExistAnyWindow ws then return ()
	else do
		windows $ viewOnScreen 1 $ head secondaryScreenWorkspaces
		windows $ viewOnScreen 0 $ head primaryScreenWorkspaces

isExistAnyWindow :: WindowSet -> Bool
isExistAnyWindow ws = any (isJust . stack) (StackSet.workspaces ws)

manageApps = composeAll
	[ isFullscreen --> doFloat
	, isDialog --> doFloat
	]

guiMask, altMask :: KeyMask
-- win, super, command
guiMask = mod4Mask
altMask = mod1Mask

myKeys :: XConfig Layout -> Map (KeyMask, KeySym) (X ())
myKeys conf = Map.fromList $
	[ ((guiMask, xK_n), onTray (windowGo D True) (windows focusDown))
	, ((guiMask .|. shiftMask, xK_n), windows swapDown)
	, ((guiMask, xK_t), onTray (windowGo U True) (windows focusUp))
	, ((guiMask .|. shiftMask, xK_t), windows swapUp)
	, ((guiMask, xK_r), onTray (windowGo L True) (windows focusMaster))
	, ((guiMask .|. shiftMask, xK_r), onTray (return()) (windows shiftMaster))
	, ((guiMask, xK_l), onTray (windowGo R True) (sendMessage Expand))
	, ((guiMask .|. shiftMask, xK_l), onTray (return()) (sendMessage Shrink))
	, ((guiMask, xK_space), toggleWsOnScreen)
	, ((guiMask .|. shiftMask, xK_space), sendMessage NextLayout)
	, ((guiMask, xK_p), onTray fromTray toTray)
	, ((guiMask .|. shiftMask, xK_p), toggleTray)
	, ((guiMask, xK_Tab), nextScreen)
	, ((guiMask .|. shiftMask, xK_Tab), shiftNextScreen >> nextScreen)
	, ((guiMask, xK_q), kill)
	, ((guiMask .|. shiftMask, xK_q), killAll)
	, ((guiMask, xK_f), floatFocused)
	, ((guiMask .|. shiftMask, xK_f), sinkFocused)
	, ((guiMask, xK_m), scratchpadToggle "memo")
	, ((guiMask, xK_Return), spawn $ XMonad.terminal conf)
	, ((guiMask .|. shiftMask, xK_Return), io $ terminalWithMark $ XMonad.terminal conf)
	, ((0, xK_Print), screenshot)
	, ((shiftMask, xK_Print), selectScreenshot)
	, ((0, xF86XK_AudioMute), mute)
	, ((0, xF86XK_AudioPlay), musicToggle)
	, ((shiftMask, xF86XK_AudioMute), volumeDown)
	, ((shiftMask, xF86XK_AudioPlay), volumeUp)
	, ((guiMask, xK_slash), dmenuSearch google)
	, ((guiMask .|. shiftMask, xK_slash), submap submapDmenuSearch)
	, ((guiMask, xK_s), selectSearch google >> raiseBrowserThere)
	, ((guiMask .|. shiftMask, xK_s), submap submapSelectSearch)
	, ((guiMask, xK_o), submap $ Map.fromList appLauncher)
	, ((guiMask .|. shiftMask, xK_o), shellPrompt myPromptConfig)
	, ((guiMask, xK_Escape), lock)
	, ((guiMask .|. shiftMask, xK_Escape), submap $ Map.fromList $
		[ ((0, xK_c), spawn "xmonad --recompile && xmonad --restart")
		, ((0, xK_e), io exitSuccess)
		, ((0, xK_p), poweroff)
		, ((0, xK_r), reboot)
		, ((0, xK_s), suspend)
		, ((0, xK_h), hibernate)
		, ((0, xK_l), logout)
		])
	]
	++ [((guiMask, k), focusOnScreen n) | (n, k) <- zip [1 .. 4] [xK_1 ..]]
	++ [((guiMask .|. shiftMask, k), shiftOnScreen n >> focusOnScreen n) | (n, k) <- zip [1 .. 4] [xK_1 ..]]
	where
		toggleWsOnScreen = toggleWsOnScreen' ["NSP", "Tray"] primaryScreenWorkspaces secondaryScreenWorkspaces
		focusOnScreen n = focusOnScreen' primaryScreenWorkspaces secondaryScreenWorkspaces n
		shiftOnScreen n = shiftOnScreen' primaryScreenWorkspaces secondaryScreenWorkspaces n
		toggleTray = toggleOrDoSkip ["NSP"] view "Tray"
		toTray = windows $ shift "Tray"
		fromTray = fromTray' ["NSP"] primaryScreenWorkspaces secondaryScreenWorkspaces
		onTray actionInTray defaultAction = bindOn [("Tray", actionInTray), ("", defaultAction)]
		floatFocused = withFocused float
		sinkFocused = withFocused $ windows . sink
		scratchpadToggle name = namedScratchpadAction myScratchpads name
		screenshot = spawn "maim $HOME/Pictures/$(date +%F-%T).png"
		selectScreenshot = spawn "maim -s --nokeyboard $HOME/Pictures/$(date +%F-%T).png"
		mute = spawn "pactl set-sink-mute 0 toggle"
		musicToggle = spawn "cmus-remote -u"
		volumeDown = spawn "sh -c 'pactl set-sink-mute 0 false ; pactl set-sink-volume 0 +5%'"
		volumeUp = spawn "sh -c 'pactl set-sink-mute 0 false ; pactl -- set-sink-volume 0 -5%'"
		suspend = spawn "systemctl suspend"
		hibernate = spawn "systemctl hibernate"
		poweroff = spawn "systemctl poweroff"
		reboot = spawn "systemctl reboot"
		lock = spawn "xtrlock -b"
		logout = spawn "pkill -KILL -u $USERNAME"
		submapDmenuSearch = Map.fromList $
			[ (k, dmenuSearch q) | (k, q) <- searchQuery]
		submapSelectSearch = Map.fromList $
			[ (k, selectSearch q >> raiseBrowserThere) | (k, q) <- searchQuery]
		searchQuery =
			[ ((0, xK_h), hoogle)
			, ((shiftMask, xK_h), hackage)
			, ((0, xK_i), images)
			, ((0, xK_y), youtube)
			, ((0, xK_e), english)
			, ((0, xK_t), translation)
			, ((0, xK_l), archLinux)
			, ((0, xK_a), amazon)
			, ((0, xK_j), japanese)
			, ((0, xK_w), wikipedia)
			]
			where
				english = searchEngine "english" "http://www.oxfordlearnersdictionaries.com/search/english/?=english&q="
				translation = searchEngine "translation" "http://eowpf.alc.co.jp/?q="
				archLinux = searchEngine "arch linux" "https://wiki.archlinux.org/index.php?title=Special%3ASearch&search="
				japanese = searchEngine "japanese" "http://dictionary.goo.ne.jp/freewordsearcher.html?mode=6&kind=jn&MT="
		appLauncher =
			[ ((0, xK_f), firefox)
			, ((0, xK_v), vim)
			]
			where
				firefox = spawn "firefox -new-window"
				vim = runInTerm "" "nvim"

myPromptConfig = def
	{ position = Bottom
	, historySize = 0
	, promptKeymap = myPromptKeymap
	--,font = myFont
	}

--myFont = "xft: "

myPromptKeymap = Map.fromList $
	[ ((0, xK_Return), setSuccess True >> setDone True)
	, ((0, xK_BackSpace), deleteString Prev)
	, ((0, xK_Delete), deleteString Next)
	, ((0, xK_Left), moveCursor Prev)
	, ((0, xK_Right), moveCursor Next)
	, ((0, xK_Home), startOfLine)
	, ((0, xK_End), endOfLine)
	, ((0, xK_Escape), quit)
	, ((altMask, xK_w), moveWord Next)
	, ((altMask, xK_b), moveWord Prev)
	, ((altMask, xK_d), killWord Prev)
	, ((altMask .|. shiftMask, xK_d), killBefore)
	, ((altMask, xK_p), pasteString)
	]
	where
		moveWord dir = moveWord' wfilter dir
		killWord dir = killWord' wfilter dir
		wfilter c = isSpace c || c == '/'

--myMouseBindings = Map.fromlist

--TODO: use getXMonadDir
myScratchpads =
	[ NS "memo" (runInTermString "-name memo" "nvim ~/.xmonad/memo") (appName =? "memo") doFloat
	]


--TODO: get terminal name from config
runInTermString :: String -> String -> String
runInTermString options command = "xterm" ++ " " ++ options ++ " -e " ++ command


terminalWithMark :: String -> IO ()
terminalWithMark term = do
	confdir <- getXMonadDir
	markfile <- readFile $ confdir ++ "/mark"
	let mark = filter (/= '\n') markfile
	sh <- getEnv "SHELL"
	-- xterm -title xterm -e "cd ~/.xmonad/mark && zsh"
	spawn $ term ++ " -title " ++ term ++ " -e \"cd " ++ mark ++ " && " ++ sh ++ "\""


fromTray' :: [WorkspaceId] -> [WorkspaceId] -> [WorkspaceId] -> X ()
fromTray' skips primary secondary = do
	currentScreen <- getCurrentScreen
	lastViewed <- case currentScreen of
		S 0 -> getLastViewedSkip $ skips ++ secondary
		_ -> getLastViewedSkip  $ skips ++ primary
	whenJust lastViewed (windows . shift)


--After here. I'd like to add to Contrib
--Actions.Search
dmenuSearch :: SearchEngine -> X ()
dmenuSearch (SearchEngine name url) = do
	currentScreen <- getCurrentScreen
	let n = case currentScreen of S n -> show n
	input <- menuArgs "dmenu" ["-b", "-m", n , "-p", name ++ ":"] []
	if input == "" then return()
	else do
		browser <- io getBrowser
		search browser url input
		raiseBrowserThere

--This is makeshift
--自分の能力が追い着いたら、書き直し。
--I wanna raise the browser in ブラウザが開いてるスクリーン
--自分がブラウザを開くスクリーンを固定する。
raiseBrowserThere :: X ()
raiseBrowserThere = do
	mws <-screenWorkspace 1
	case mws of
		Nothing -> raiseBrowser
		Just ws -> do
			windows $ view ws
			raiseBrowser


--Util.?
getCurrentScreen :: X (ScreenId)
getCurrentScreen = do
	ws <- gets windowset
	return $ screen $ current ws

getLastViewedSkip :: [WorkspaceId] -> X (Maybe WorkspaceId)
getLastViewedSkip skips = do
	history <- workspaceHistory
	ws <- gets windowset
	let skipped' = skipTags (hidden ws) skips
	let skipped = map tag skipped'
	let lastViewed = find (`elem` skipped) history
	return $ delegate history lastViewed
	where
		delegate []     _       = Nothing
		delegate (h:_)  Nothing = Just h
		delegate _      lv      = lv



--Hooks.DynamicLog
filterOutWorkspaces :: [String] -> [WindowSpace] -> [WindowSpace]
filterOutWorkspaces out = filter (\(Workspace tag _ _) -> not (tag `elem` out))


--Actions.DualScreen
--toggleWsOnScreen :: [WorkspaceId] -> [WorkspaceId] -> X ()
--toggleWsOnScreen primary secondary =
--	toggleWsOnScreen' []

toggleWsOnScreen' :: [WorkspaceId] -> [WorkspaceId] -> [WorkspaceId] -> X ()
toggleWsOnScreen' skip primary secondary =
	bindOn $ zip secondary (repeat delegateSecondary) ++ zip primary (repeat delegatePrimary) ++ [("", return ())]
	where
		delegatePrimary = toggleWS' $ skip ++ secondary
		delegateSecondary = toggleWS' $ skip ++ primary

focusOnScreen', shiftOnScreen' :: [WorkspaceId] -> [WorkspaceId] -> Int -> X ()
focusOnScreen' primary secondary n =
	bindOn $ zip secondary (repeat delegateSecondary) ++ zip primary (repeat delegatePrimary) ++ [("", return ())]
	where
		delegatePrimary = doIfExist (windows . viewOnScreen 0) primary i
		delegateSecondary = doIfExist (windows . viewOnScreen 1) secondary i
		i = n - 1

shiftOnScreen' primary secondary n =
	bindOn $ zip secondary (repeat delegateSecondary) ++ zip primary (repeat delegatePrimary) ++ [("", return ())]
	where
		delegatePrimary = doIfExist shift' primary i
		delegateSecondary = doIfExist shift' secondary i
		i = n - 1
		shift' = windows . shift

doIfExist :: (a -> X ()) -> [a] -> Int -> X ()
doIfExist f xs i = do
	let x = getFromList xs i
	case x of
		Just x -> f x
		Nothing -> return()

getFromList :: [a] -> Int -> Maybe a
getFromList xs i
	| 0 <= i && i < length xs = Just $ xs !! i
	| otherwise = Nothing

--Actions.Submap
--add io $ sync d False
submap :: Map (KeyMask, KeySym) (X ()) -> X ()
submap keys = do
	XConf {theRoot = root, display = d} <- ask

	io $ grabKeyboard d root False grabModeAsync grabModeAsync currentTime
	(m, s) <- io $ allocaXEvent $ \p -> fix $ \nextkey -> do
		maskEvent d keyPressMask p
		KeyEvent { ev_keycode = code, ev_state = m } <- getEvent p
		keysym <- keycodeToKeysym d code 0
		if isModifierKey keysym
		then nextkey
		else return (m, keysym)
		-- Remove num lock mask and Xkb group state bits
	m' <- cleanMask $ m .&. ((1 `shiftL` 12) - 1)
	io $ ungrabKeyboard d currentTime
	io $ sync d False
	maybe (return ()) id (Map.lookup (m', s) keys)
