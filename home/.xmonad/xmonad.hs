import XMonad
import qualified XMonad.StackSet as StackSet
import XMonad.StackSet(StackSet(..), Workspace(..), Screen(..), allWindows, view, currentTag, findTag, shiftWin, focusWindow, focusMaster, shiftMaster, focusUp, focusDown, swapDown, swapUp, sink, shift)

import XMonad.Actions.CycleWS(nextScreen, shiftNextScreen, toggleWS', toggleOrDoSkip, skipTags)
import XMonad.Actions.Navigation2D(windowGo)
import XMonad.Actions.OnScreen(viewOnScreen)
import XMonad.Actions.PerWorkspaceKeys(bindOn)
import XMonad.Actions.Search(SearchEngine(..), search, selectSearch, searchEngine, google, amazon, hoogle, hackage, images, wikipedia, youtube)
--import XMonad.Actions.Submap(submap)
import XMonad.Actions.SpawnOn(manageSpawn, spawnOn, spawnHere)
import XMonad.Actions.UpdatePointer(updatePointer)
import XMonad.Actions.WithAll(killAll)
import XMonad.Actions.WindowBringer(bringWindow)

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


import Control.Monad(filterM)
import Control.Monad.Fix(fix)

import Data.Bits((.&.), shiftL)
import qualified Data.Map.Lazy as Map
import Data.Map.Lazy(Map)
import Data.Char(isSpace, toLower)
import Data.List(find, any)
import Data.Maybe(isJust)

import Graphics.X11.ExtraTypes.XF86(xF86XK_AudioMute, xF86XK_AudioPlay)

import System.Environment(getEnv)
import System.Exit(exitSuccess)


main :: IO ()
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
        , manageHook = manageApps <+> manageDocks <+> manageSpawn
        -- <+> namedScratchpadManageHook myScratchpads
        , handleEventHook = fullscreenEventHook
        , focusFollowsMouse = True
        , clickJustFocuses = False
        }


--["1:P", "2:P", ... "1:S", "2:S", ... "Tray"]
myWorkspaces, primaryScreenWorkspaces, secondaryScreenWorkspaces :: [WorkspaceId]
myWorkspaces = primaryScreenWorkspaces ++ secondaryScreenWorkspaces ++ ["Tray"]
primaryScreenWorkspaces = map (: ":P") ['1' .. '5']
secondaryScreenWorkspaces = map (: ":S") ['1' .. '5']

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
    --, ppSort = fmap (. filterOutWorkspaces ["NSP"]) $ ppSort def
    , ppOutput = hPutStrLn bar
    }

myStartup :: X ()
myStartup = do
    --Are there any better solution to detect is restart?
    ws <- gets windowset
    if isExistAnyWindow ws then return ()
    else do
        windows $ viewOnScreen 1 $ head secondaryScreenWorkspaces
        spawnHere =<< io getBrowser
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
    [ ((guiMask, xK_Page_Up),   windows focusUp)
    , ((guiMask, xK_Page_Down), windows focusDown)
    , ((guiMask .|. shiftMask, xK_Page_Up),   windows swapUp)
    , ((guiMask .|. shiftMask, xK_Page_Down), windows swapDown)

    , ((guiMask, xK_Down),  windowGo D True)
    , ((guiMask, xK_Up),    windowGo U True)
    , ((guiMask, xK_Left),  windowGo L True)
    , ((guiMask, xK_Right), windowGo R True)

    , ((guiMask, xK_Home), windows focusMaster)
    , ((guiMask .|. shiftMask, xK_Home), windows shiftMaster)

    , ((guiMask, xK_q), kill)
    , ((guiMask .|. shiftMask, xK_q), killAll)

    , ((guiMask, xK_l), sendMessage NextLayout)

    , ((guiMask, xK_e), sendMessage Expand)
    , ((guiMask .|. shiftMask, xK_e), sendMessage Shrink)

    , ((guiMask, xK_f), withFocused float)
    , ((guiMask .|. shiftMask, xK_f), withFocused (windows . sink))

    , ((guiMask, xK_space), toggleWsOnScreen)
    , ((guiMask .|. shiftMask, xK_space), shiftToLastViewedOnScreen)

    , ((guiMask, xK_Tab), nextScreen)
    , ((guiMask .|. shiftMask, xK_Tab), shiftNextScreen >> nextScreen)

    , ((guiMask, xK_t), onTray fromTray toTray)
    , ((guiMask .|. shiftMask, xK_t), toggleTray)

    --, ((guiMask, xK_m), scratchpadToggle "memo")

    , ((guiMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((guiMask .|. shiftMask, xK_Return), io $ terminalWithMark $ XMonad.terminal conf)
    , ((guiMask .|. shiftMask, xK_w), web)
    , ((guiMask .|. shiftMask, xK_m), mail)
    , ((guiMask .|. shiftMask, xK_c), chat)
    , ((guiMask .|. shiftMask, xK_n), news)

    , ((0, xK_Print), screenshot)
    , ((shiftMask, xK_Print), selectScreenshot)

    , ((0, xF86XK_AudioMute), mute)
    , ((0, xF86XK_AudioPlay), musicToggle)
    , ((shiftMask, xF86XK_AudioMute), volumeDown)
    , ((shiftMask, xF86XK_AudioPlay), volumeUp)

    , ((guiMask, xK_slash), dmenuSearch google)
    , ((guiMask .|. shiftMask, xK_slash), submap submapDmenuSearch)
    , ((guiMask, xK_s), raiseBrowserThere >> selectSearch google)
    , ((guiMask .|. shiftMask, xK_s), submap submapSelectSearch)

    , ((guiMask, xK_o), shellPrompt myPromptConfig)

    , ((guiMask, xK_Escape), lock)
    , ((guiMask .|. shiftMask, xK_Escape), submap $ Map.fromList $
        [ ((0, xK_c), spawn "xmonad --recompile && xmonad --restart")
        --[ ((0, xK_c), whenX recompile $ restart "xmonad")
        , ((0, xK_e), io exitSuccess)
        , ((0, xK_p), poweroff)
        , ((0, xK_r), reboot)
        , ((0, xK_s), suspend)
        , ((0, xK_h), hibernate)
        , ((0, xK_l), logout)
        ])
    ]
    ++ [((guiMask, k), focusOnScreen 0 n) | (n, k) <- zip [1 .. 5] [xK_0 .. ]]
    ++ [((guiMask, k), focusOnScreen 1 n) | (n, k) <- zip [1 .. 5] [xK_5 .. ]]
    ++ [((guiMask .|. shiftMask, k), shiftOnScreen 0 n >> focusOnScreen 0 n) | (n, k) <- zip [1 .. 5] [xK_0 .. ]]
    ++ [((guiMask .|. shiftMask, k), shiftOnScreen 1 n >> focusOnScreen 1 n) | (n, k) <- zip [1 .. 5] [xK_5 .. ]]
    where
        toggleWsOnScreen = focusLastViewedOnScreen' ["NSP", "Tray"]
        toggleTray = toggleOrDoSkip ["NSP"] view "Tray"
        toTray = windows $ shift "Tray"
        fromTray = shiftToLastViewedOnScreen' ["NSP"]
        shiftToLastViewedOnScreen = shiftToLastViewedOnScreen' ["NSP", "Tray"]
        onTray actionInTray defaultAction = bindOn [("Tray", actionInTray), ("", defaultAction)]
        scratchpadToggle name = namedScratchpadAction myScratchpads name

        screenshot = spawn "maim $HOME/Pictures/$(date +%F-%T).png"
        selectScreenshot = spawn "maim -s --nokeyboard $HOME/Pictures/$(date +%F-%T).png"

        mute = spawn "pactl set-sink-mute 0 toggle"
        musicToggle = spawn "cmus-remote -u"
        volumeDown = spawn "sh -c 'pactl set-sink-mute 0 false ; pactl set-sink-volume 0 +5%'"
        volumeUp = spawn "sh -c 'pactl set-sink-mute 0 false ; pactl -- set-sink-volume 0 -5%'"

        lock = spawn "xtrlock -b"
        suspend = spawn "systemctl suspend"
        hibernate = spawn "systemctl hibernate"
        poweroff = spawn "systemctl poweroff"
        reboot = spawn "systemctl reboot"
        logout = spawn "pkill -KILL -u $USERNAME"

        web = spawn "firefox -new-window"
        mail = return ()
        chat = return ()
        news = return ()

        submapDmenuSearch = Map.fromList $
            [ (k, dmenuSearch q) | (k, q) <- searchQuery]
        submapSelectSearch = Map.fromList $
            [ (k, raiseBrowserThere >> selectSearch q) | (k, q) <- searchQuery]
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

myPromptConfig :: XPConfig
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
--fix size
myScratchpads :: [NamedScratchpad]
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


--After here. I'd like to add to Contrib
--Actions.Search
--Bug when not exist: open then popup window saying firefox already exists
dmenuSearch :: SearchEngine -> X ()
dmenuSearch (SearchEngine name url) = do
    currentScreen <- getCurrentScreen
    let n = case currentScreen of S n -> show n
    input <- menuArgs "dmenu" ["-b", "-m", n , "-p", name ++ ":"] []
    if input == "" then return()
    else do
        browser <- io getBrowser
        raiseBrowserThere
        search browser url input

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
    return $ delegate skipped lastViewed
    where
        delegate [] _ = Nothing
        delegate (h:_) Nothing = Just h
        delegate _ lv@(Just _) = lv


--Hooks.DynamicLog
filterOutWorkspaces :: [String] -> [WindowSpace] -> [WindowSpace]
filterOutWorkspaces out = filter (\(Workspace tag _ _) -> not (tag `elem` out))


--Actions.DualScreen
focusLastViewedOnScreen' :: [WorkspaceId] -> X ()
focusLastViewedOnScreen' skips = do
    lastViewed <- lastViewedOnScreen skips
    whenJust lastViewed (windows . view)

shiftToLastViewedOnScreen' :: [WorkspaceId] -> X ()
shiftToLastViewedOnScreen' skips = do
    lastViewed <- lastViewedOnScreen skips
    whenJust lastViewed (windows . shift)

lastViewedOnScreen :: [WorkspaceId] -> X (Maybe WorkspaceId)
lastViewedOnScreen skips = do
    currentScreen <- getCurrentScreen
    case currentScreen of
        0 -> getLastViewedSkip $ skips ++ secondaryScreenWorkspaces
        _ -> getLastViewedSkip $ skips ++ primaryScreenWorkspaces

focusOnScreen :: ScreenId -> Int -> X ()
focusOnScreen screen n =
    doIfExist (windows . viewOnScreen screen) workspaces i
    where
        i = n - 1
        workspaces = screenWorkspaces screen

shiftOnScreen :: ScreenId -> Int -> X ()
shiftOnScreen screen n =
    doIfExist (windows . shift)  workspaces i
    where
        i = n - 1
        workspaces = screenWorkspaces screen

screenWorkspaces :: ScreenId -> [WorkspaceId]
screenWorkspaces screen =
    case screen of
        0 -> primaryScreenWorkspaces
        _ -> secondaryScreenWorkspaces

doIfExist :: (WorkspaceId -> X ()) -> [WorkspaceId] -> Int -> X ()
doIfExist f xs i = do
    let x = getFromList xs i
    case x of
        Just x -> f x
        Nothing -> return()

getFromList :: [a] -> Int -> Maybe a
getFromList xs i
    | 0 <= i && i < length xs = Just $ xs !! i
    | otherwise = Nothing


raiseBrowserThere :: X ()
raiseBrowserThere = do
    ws <- gets windowset
    matches <- filterM (runQuery isExistBrowser) $ allWindows ws
    w <- return $ case matches of
        [] -> Nothing
        (firstMatch:_) -> case findTag firstMatch ws of
            Nothing -> Nothing
            Just wid -> Just (wid, firstMatch)
    case w of
        --not exist browser
        Nothing -> do
            toggleScreenIf 1
        Just (wid, win) -> case whichScreenIs wid of
            --Tray
            Nothing -> bringWindowOnScreen 1 win
            --primary or secondary screenWorkspaces
            Just sid -> raiseWindowOnScreen sid win

raiseWindowOnScreen :: ScreenId -> Window -> X ()
raiseWindowOnScreen sid w = do
    toggleScreenIf sid
    windows $ focusWindow w

bringWindowOnScreen :: ScreenId -> Window -> X ()
bringWindowOnScreen sid w = do
    toggleScreenIf sid
    windows $ bringWindow w

toggleScreenIf :: ScreenId -> X ()
toggleScreenIf sid = do
    currentSid <- getCurrentScreen
    if sid /= currentSid then nextScreen else return ()

isExistBrowser :: Query Bool
isExistBrowser = do
    browser <- io getBrowser
    fmap (map toLower) className =? browser

whichScreenIs :: WorkspaceId -> Maybe ScreenId
whichScreenIs tag
    | tag `elem` secondaryScreenWorkspaces = Just 1
    | tag `elem` primaryScreenWorkspaces = Just 0
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
