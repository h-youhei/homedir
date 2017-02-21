import XMonad
import qualified XMonad.StackSet as W
import XMonad.StackSet(StackSet(..), Workspace(..), Screen(..), allWindows, view, greedyView, currentTag, findTag, shiftWin, focusWindow, focusMaster, shiftMaster, focusUp, focusDown, swapDown, swapUp, sink, shift, floating)

import XMonad.Actions.CycleWS(nextScreen, shiftNextScreen, swapNextScreen, toggleOrDoSkip)
import XMonad.Actions.Navigation2D(windowGo, windowSwap)
import XMonad.Actions.OnScreen(greedyViewOnScreen, viewOnScreen)
import XMonad.Actions.PerWorkspaceKeys(bindOn)
import XMonad.Actions.Search(SearchEngine(..), search, selectSearch, searchEngine, google, hoogle, images, wikipedia, youtube)
--import XMonad.Actions.Submap(submap)
import XMonad.Actions.SpawnOn(manageSpawn, spawnOn)
import XMonad.Actions.UpdatePointer(updatePointer)
import XMonad.Actions.WithAll(killAll)

import XMonad.Hooks.DynamicLog(dynamicLogWithPP, PP(..), xmobarPP, xmobarColor, wrap, pad)
import XMonad.Hooks.EwmhDesktops(ewmh, fullscreenEventHook)
import XMonad.Hooks.ManageDocks(docks, avoidStruts)
import XMonad.Hooks.ManageHelpers(currentWs, isDialog)
import XMonad.Hooks.SetWMName(setWMName)
import XMonad.Hooks.WorkspaceHistory(workspaceHistory)

import XMonad.Layout.Grid(Grid(..))
import XMonad.Layout.PerWorkspace(onWorkspace)
import XMonad.Layout.Tabbed(simpleTabbed)

import qualified XMonad.Prompt as P
import XMonad.Prompt(XPConfig, XP)
import XMonad.Prompt.Directory(directoryPrompt)
import XMonad.Prompt.Shell(shellPrompt, getBrowser)

import XMonad.Util.Dmenu(menuArgs)
import XMonad.Util.Loggers(Logger, onLogger, wrapL)
import XMonad.Util.Run(spawnPipe, hPutStrLn)
import XMonad.Util.Types(Direction1D(..), Direction2D(..))
--import XMonad.Util.WindowProperties(getProp32s)


import Control.Monad.Fix(fix)

import Data.Bits((.&.), shiftL)
import Data.Char(isSpace)
import Data.List(find, any, init, concat, intersperse)
import qualified Data.Map as M
import Data.Map(Map)
import Data.Maybe(isJust, catMaybes)

import GHC.IO.Handle.Types(Handle)
--jmport Foreign.C.Types(CLong)
import Graphics.X11.ExtraTypes.XF86(xF86XK_AudioLowerVolume, xF86XK_AudioRaiseVolume, xF86XK_AudioMute, xF86XK_AudioPlay)

import System.Directory(setCurrentDirectory, getCurrentDirectory)
import System.Environment(getEnv)
import System.Exit(exitSuccess)

--require package: regex-compat
import Text.Regex(mkRegex, subRegex)


main :: IO ()
main = do
    myStatusBar1 <- spawnPipe "xmobar -x 1"
    myStatusBar2 <- spawnPipe "xmobar -x 2"
    xmonad $ (ewmh . docks) def
        { workspaces = myWorkspaces
        , layoutHook = avoidStruts myLayout
        , modMask = mod4Mask
        , terminal = "mlterm"
        , keys = myKeys
        , logHook = myPP myStatusBar1 >> myPP myStatusBar2 >> updatePointer (0.1, 0.2) (0, 0)
        , startupHook = myStartup
        --,mouseBindings = myMouseBindings
        , manageHook = myManageHook
        , handleEventHook = fullscreenEventHook
        , focusFollowsMouse = True
        , clickJustFocuses = False
        }

myWorkspaces :: [WorkspaceId]
myWorkspaces = ["1:Edit", "2:Term", "3:Ref", "4:Web", "5:Mail", "6:Media"] ++ map (: ":Any") ['7' .. '9'] ++ ["0:Tray"]

myLayout =
    onWorkspace "0:Tray" trayLayout
    defaultLayout
    where
        defaultLayout = horizontal ||| simpleTabbed
        trayLayout = Grid
        horizontal = Tall nmaster delta ratio
        vertical = Mirror horizontal
        nmaster = 1
        ratio = 1/2 --master pain to others
        delta = 3/100 --be used when to resize window

myPP :: Handle -> X ()
myPP bar = dynamicLogWithPP $ xmobarPP
    { ppCurrent = xmobarColor "lime" "" . wrap "<" ">"
    , ppVisible = xmobarColor "yellow" "" . wrap "<" ">"
    , ppHidden = xmobarColor "white" "" . wrap "(" ")"
    , ppHiddenNoWindows = xmobarColor "white" ""
    , ppSep = "   "
    , ppWsSep = "  "
    , ppOrder = \(ws:_:_:cwd:_) -> [ws, cwd]
    --, ppSort = fmap (. filterOutWorkspaces ["NSP"]) $ ppSort def
    , ppOutput = hPutStrLn bar
    , ppExtras = [wrapL "[" "]" . dirShortenL 90 6 $ logCwd]
    }


myStartup :: X ()
myStartup = do
    --for making Java programs work
    setWMName "LG3D"
    --Are there better solution to detect it is restart?
    ws <- gets windowset
    if isExistAnyWindow ws then return ()
    else do
        setScreenWith "1:Edit" "4:Web"
        spawnOn "4:Web" =<< io getBrowser
        runInTermOn "1:Edit" "nvim"

isExistAnyWindow :: WindowSet -> Bool
isExistAnyWindow ws = any (isJust . stack) (W.workspaces ws)

myManageHook :: ManageHook
myManageHook = composeAll
    [ manageSpawn
    , isDialog --> doFloat
    , className =? "Xmessage" --> doFloat
    ]

guiMask, altMask :: KeyMask
-- win, super, command
guiMask = mod4Mask
altMask = mod1Mask

help :: String
help = unlines
    [ "-- change window focus --"
    , "M-Up     Move focus to the previous window"
    , "M-Down   Move focus to the next window"
    , "M-Left   Move focus toward left"
    , "M-Right  Move focus toward right"
    , "M-m      Move focus to the master window"
    , ""
    , "-- modifying the window order --"
    , "M-S-Up     Swap the focused window to the previous window"
    , "M-S-Down   Swap the focused window to the next window"
    , "M-S-Left   Swap the focused window toward left"
    , "M-S-Right  Swap the focused window toward right"
    , "M-S-m      Set the focused window to the master window"
    , ""
    , "-- workspaces & screens --"
    , "M-[1..9]    Switch to workspace N on primary screen"
    , "M-[F1..F9]  Switch to workspace N on the other screen"
    , "M-S-[1..9]  Move the focused window to woekspace N"
    , "M-Tab       Move focus to the other screen"
    , "M-S-Tab     Move the focused window to the other screen"
    , "M-Space     Toggle workspaces on the screen"
    , "M-S-Space   Swap the screen to the other"
    , ""
    , "-- launch and close --"
    , "M-Enter  Launch terminal"
    , "M-l      Launch launcher"
    , "M-q      Close the focused window"
    , "M-S-q    Close all windows in current workspace"
    , ""
    , "-- layout --"
    , "M-f    Toggle fullscreen"
    , "M-S-f  Sink the focused window"
    , ""
    , "-- search --"
    , "M-/              Search on google"
    , "M-s              Search on google with X11 selection"
    , "M-S-/ [Initial]  Search on selected search engine"
    , "M-S-s [Initial]  Search on selected search engine with X11 selection"
    , "-- list of search engine --"
    , "Amazon, English, Github, Hoogle, Image"
    , "Japanese, Translate, arch Linux, Youtube, Wikipedia"
    , ""
    , "-- Exit --"
    , "M-Esc      Lock screens"
    , "M-S-Esc c  Recompile and restart xmonad"
    , "M-S-Esc e  Exit xmonad"
    , "M-S-Esc l  Logout"
    , "M-S-Esc p  Poweroff"
    , "M-S-Esc s  Suspend"
    , "M-S-Esc r  Reboot"
    , ""
    , "-- misc --"
    , "M-0    Move the focused window to or from tray"
    , "M-S-0  Switch to or from tray"
    , "M-c    Change working directory"
    , "M-h    Show this help"
    ]

myKeys :: XConfig Layout -> Map (KeyMask, KeySym) (X ())
myKeys conf = M.fromList $
    [ ((guiMask, xK_Up),   windows focusUp)
    , ((guiMask, xK_Down), windows focusDown)
    , ((guiMask, xK_Left),  windowGo L False)
    , ((guiMask, xK_Right), windowGo R False)

    , ((guiMask .|. shiftMask, xK_Up),   windows swapUp)
    , ((guiMask .|. shiftMask, xK_Down), windows swapDown)
    , ((guiMask .|. shiftMask, xK_Left),  windowSwap L False)
    , ((guiMask .|. shiftMask, xK_Right), windowSwap R False)

    , ((guiMask, xK_m), windows focusMaster)
    , ((guiMask .|. shiftMask, xK_m), windows shiftMaster)

    , ((guiMask, xK_q), kill)
    , ((guiMask .|. shiftMask, xK_q), killAll)

    , ((guiMask, xK_f), sendMessage NextLayout)
    , ((guiMask .|. shiftMask, xK_f), withFocused $ windows . sink)

    , ((guiMask, xK_h), spawn ("echo \"" ++ help ++ "\" | xmessage -default okay -file -"))

    , ((guiMask, xK_space), myWsSwitch)
    , ((guiMask .|. shiftMask, xK_space), swapNextScreen)

    , ((guiMask, xK_Tab), nextScreen)
    , ((guiMask .|. shiftMask, xK_Tab), shiftNextScreen)

    , ((guiMask, xK_0), onTray fromTray toTray)
    , ((guiMask .|. shiftMask, xK_0), toggleTray)

    , ((guiMask, xK_Return), launchTerminal)
    --, ((guiMask .|. shiftMask, xK_Return), terminalWithMark)

    , ((guiMask, xK_l), launcher)
    , ((guiMask .|. shiftMask, xK_l), submap submapLaunchApp)

    , ((guiMask, xK_c), cd)

    , ((0, xK_Print), screenshot)
    , ((shiftMask, xK_Print), selectingScreenshot)

    , ((0, xF86XK_AudioMute), mute)
    , ((0, xF86XK_AudioPlay), mediaToggle)
    , ((0, xF86XK_AudioLowerVolume), unmute >> volumeDown)
    , ((0, xF86XK_AudioRaiseVolume), unmute >> volumeUp)

    , ((guiMask, xK_slash), dmenuSearch google)
    , ((guiMask .|. shiftMask, xK_slash), submap submapDmenuSearch)
    , ((guiMask, xK_s), selectSearch google)
    , ((guiMask .|. shiftMask, xK_s), submap submapSelectSearch)

    , ((guiMask, xK_Escape), lock)
    , ((guiMask .|. shiftMask, xK_Escape), submap $ M.fromList $
        [ ((0, xK_c), spawn "xmonad --recompile && xmonad --restart")
        , ((0, xK_e), io exitSuccess)
        , ((0, xK_p), poweroff)
        , ((0, xK_r), reboot)
        , ((0, xK_s), suspend)
        , ((0, xK_h), hibernate)
        , ((0, xK_l), logout)
        ])
    ]
    ++ [((guiMask, k), windows $ greedyViewOnScreen 0 ws) | (ws, k) <- zip workspacesExceptTray [xK_1 .. xK_9]]
    ++ [((guiMask, k), windows $ greedyViewOnScreen 1 ws) | (ws, k) <- zip workspacesExceptTray [xK_F1 .. xK_F9]]
    ++ [((guiMask .|. shiftMask, k), windows $ shift ws) | (ws, k) <- zip workspacesExceptTray [xK_1 .. xK_9]]
    where
        workspacesExceptTray = init myWorkspaces
        toggleTray = toggleOrDoSkip [] view "0:Tray"
        toTray = windows $ shift "0:Tray"
        fromTray = shiftToLastViewed
        onTray actionInTray defaultAction = bindOn [("0:Tray", actionInTray), ("", defaultAction)]

        myWsSwitch = perScreen (toggleBetween "1:Edit" "2:Term") (toggleBetween "4:Web" "3:Ref")

        dmenuSearch = dmenuSearchWithConf myDmenuConfig

        launcher = shellPrompt $ mkPromptConfig (\c -> isSpace c || c == '/')

        cd = promptChangeDir $ mkPromptConfig (== '/')

        screenshot = spawn "maim $HOME/Pictures/$(date +%F-%T).png"
        selectingScreenshot = spawn "maim -s --nokeyboard $HOME/Pictures/$(date +%F-%T).png"
        mute = spawn "pactl set-sink-mute 0 toggle"
        unmute = spawn "pactl set sink mute 0 false"
        volumeUp = spawn "pactl set-sink-volume 0 +5%"
        volumeDown = spawn "pactl set-sink-volume 0 -5%"

        mediaToggle = spawn "cmus-remote -u"

        lock = spawn "xtrlock -b"
        suspend = spawn "systemctl suspend"
        hibernate = return ()
        --hibernate = spawn "systemctl hibernate"
        poweroff = spawn "systemctl poweroff"
        reboot = spawn "systemctl reboot"
        logout = spawn "pkill -KILL -u $USERNAME"

        submapLaunchApp = M.fromList $ [(k, f) | (k, f) <- apps]
        apps =
            [ ((0, xK_w), web)
            , ((0, xK_m), mail)
            , ((0, xK_c), chat)
            , ((0, xK_n), news)
            , ((0, xK_v), vim)
            ]
            where
                web = spawn "firefox -new-window"
                vim = spawn "gvim"
                mail = return ()
                chat = return ()
                news = return ()

        submapDmenuSearch = M.fromList $ [(k, dmenuSearch q) | (k, q) <- searchQuery]
        submapSelectSearch = M.fromList $ [(k, selectSearch q) | (k, q) <- searchQuery]
        searchQuery =
            [ ((0, xK_a), amazon)
            , ((0, xK_e), english)
            , ((0, xK_g), github)
            , ((0, xK_h), hoogle)
            , ((0, xK_i), images)
            , ((0, xK_j), japanese)
            , ((0, xK_l), archLinux)
            , ((0, xK_t), translation)
            , ((0, xK_y), youtube)
            , ((0, xK_w), wikipedia)
            ]
            where
                amazon = searchEngine "amazon" "https://www.amazon.co.jp/s/ref=nb_sb_noss?__mk_ja_JP=%u30AB%u30BF%u30AB%u30CA&url=search-alias%3Daps&field-keywords="
                archLinux = searchEngine "arch linux" "https://wiki.archlinux.org/index.php?title=Special%3ASearch&search="
                github = searchEngine "github" "https://github.com/search?q="
                english = searchEngine "english" "http://www.oxfordlearnersdictionaries.com/search/english/?=english&q="
                translation = searchEngine "translation" "http://eowpf.alc.co.jp/search?q="
                japanese = searchEngine "japanese" "http://dictionary.goo.ne.jp/freewordsearcher.html?mode=1&kind=jn&MT="

--myMouseBindings = M.fromlist

mkPromptConfig :: (Char -> Bool) -> XPConfig
mkPromptConfig f = def
    { P.font = "xft:sans-serif:size=11"
    , P.fgColor = "white"
    , P.historySize = 0
    , P.height = 22
    , P.promptKeymap = mkPromptKeymap f
    }

mkPromptKeymap :: (Char -> Bool) -> Map (KeyMask, KeySym) (XP ())
mkPromptKeymap f = M.fromList $
    [ ((0, xK_Return), P.setSuccess True >> P.setDone True)
    , ((0, xK_BackSpace), P.deleteString Prev)
    , ((0, xK_Delete), P.deleteString Next)
    , ((0, xK_Left), P.moveCursor Prev)
    , ((0, xK_Right), P.moveCursor Next)
    , ((0, xK_Home), P.startOfLine)
    , ((0, xK_End), P.endOfLine)
    , ((0, xK_Escape), P.quit)
    , ((altMask, xK_w), moveWord Next)
    , ((altMask, xK_b), moveWord Prev)
    , ((altMask, xK_d), killWord Prev)
    , ((altMask .|. shiftMask, xK_d), P.killBefore)
    , ((altMask, xK_p), P.pasteString)
    ]
    where
        moveWord dir = P.moveWord' f dir
        killWord dir = P.killWord' f dir

myDmenuConfig :: DmenuConfig
myDmenuConfig = def
    { bottom = True
    , font = "sans-serif 11"
    }

getTerminal :: X String
getTerminal = asks $ terminal . config

runInTerm' :: (String -> X ()) -> String -> X ()
runInTerm' f cmd = getTerminal >>= \t -> f $  t ++ " -title " ++ t ++ " -e " ++ cmd

runInTerm :: String -> X ()
runInTerm = runInTerm' spawn

runInTermOn :: WorkspaceId -> String -> X ()
runInTermOn ws = runInTerm' (spawnOn ws)

launchTerminal :: X ()
launchTerminal = spawn =<< getTerminal

{-
--this isn't work on mlterm
terminalWithMark :: X ()
terminalWithMark = do
    confdir <- getXMonadDir
    markfile <- io $ readFile $ confdir ++ "/mark"
    let mark = filter (/= '\n') markfile
    sh <- io $ getEnv "SHELL"
    --terminal -e "cd ~/.xmonad/mark && zsh"
    runInTerm $ "\"cd " ++ mark ++ " && " ++ sh ++ "\""
-}

{-
getPID :: Window -> X (Maybe [CLong])
getPID = getProp32s "_NET_WM_PID"

--it isn't match focused pid; probably is new window's pid
--that's because its pid is always different but its cwd is always home dir
runTermInFocusedCwd :: String -> X ()
runTermInFocusedCwd term = do
    focused <- gets $ W.peek . windowset
    pid <- case focused of
        Nothing -> return Nothing
        Just f -> getPID f
    case pid of
        Nothing -> return ()
        Just (p:_) -> do
            sh <- io $ getEnv "SHELL"
            safeSpawn term ["-title", term, "-e", "cd `readlink -e /proc/" ++ show p ++ "/cwd` && " ++ sh]
-}

--After here. I'd like to add to Contrib
{-
--how to know it is floating?
toggleFloating :: X ()
toggleFloating = do
    before <- numberOfFloating
    withFocused $ windows . sink
    after <- numberOfFloating
    if before == after
    then withFocused float
    else return ()

numberOfFloating :: X (Int)
numberOfFloating = gets $ length . M.keys . floating . windowset
-}

--Prompt.Directory
promptChangeDir :: XPConfig -> X ()
promptChangeDir conf = directoryPrompt conf "cd: " changeDir

changeDir :: FilePath -> X ()
changeDir s = do
    dest <- case s of
        "" -> io $ getEnv "HOME"
        s -> return s
    catchIO $ setCurrentDirectory dest
    --to update statusbar message
    --is there better way?
    rescreen

--Hooks.DinamicLog
dirShorten :: Int -> Int -> String -> String
dirShorten nWhole nDir s
    | length s < nWhole = s
    | otherwise = rid nWhole . go $ s
    where
        go = concat . intersperse "/" . map (take nDir) . split '/'

rid :: Int -> String -> String
rid n s
    | l < n = s
    | otherwise = end ++ drop (l + length end - n) s
    where
        l = length s
        end = "..."

split :: Char -> String -> [String]
split _ "" = []
split c s = takeWhile (/= c) s : split c (dropWhile (== c) . dropWhile (/= c) $ s)

{-
filterOutWorkspaces :: [String] -> [WindowSpace] -> [WindowSpace]
filterOutWorkspaces out = filter (\(Workspace tag _ _) -> not (tag `elem` out))
-}

--Util.Loggers
logCwd :: Logger
logCwd = do
    cwd <- io getCurrentDirectory
    let homeRegex = mkRegex "^/home/[^/]+"
    return $ Just $ subRegex homeRegex cwd "~"

dirShortenL :: Int -> Int ->  Logger -> Logger
dirShortenL nWhole nDir = onLogger $ dirShorten nWhole nDir

--Util.Dmenu
data DmenuConfig = DmenuConfig
    { bottom :: !Bool
    , ignorecase :: !Bool
    , line :: Maybe Int
    , monitor :: Maybe Int
    , prompt :: String
    , font :: String
    , bgColor :: String
    , fgColor :: String
    , selectedBgColor :: String
    , selectedFgColor :: String
    }

instance Default DmenuConfig where
    def = DmenuConfig
        { bottom = False
        , ignorecase = False
        , line = Nothing
        , monitor = Nothing
        , prompt = ""
        , font = ""
        , bgColor = ""
        , fgColor = ""
        , selectedBgColor = ""
        , selectedFgColor = ""
        }

mkDmenuArgs :: DmenuConfig -> [String]
mkDmenuArgs conf = concat . catMaybes $ args
    where
        mkArgFromBool _ False = Nothing
        mkArgFromBool arg True = Just ['-' : arg]
        mkArgFromMaybe _ Nothing = Nothing
        mkArgFromMaybe arg (Just v) = Just ['-' : arg, show v]
        mkArgFromString _ "" = Nothing
        mkArgFromString arg str = Just ['-' : arg, str]
        args =
            [ mkArgFromBool "b" (bottom conf)
            , mkArgFromBool "i" (ignorecase conf)
            , mkArgFromMaybe "l" (line conf)
            , mkArgFromMaybe "m" (monitor conf)
            , mkArgFromString "p" (prompt conf)
            , mkArgFromString "fn" (font conf)
            , mkArgFromString "nb" (bgColor conf)
            , mkArgFromString "nf" (fgColor conf)
            , mkArgFromString "sb" (selectedBgColor conf)
            , mkArgFromString "sf" (selectedFgColor conf)
            ]

--Actions.Search
dmenuSearchWithConf :: DmenuConfig -> SearchEngine -> X ()
dmenuSearchWithConf conf (SearchEngine name url) = do
    (S currentScreen) <- getCurrentScreen
    let args = mkDmenuArgs $ conf
            { monitor = Just currentScreen
            , prompt = name ++ ":"
            }
    input <- menuArgs "dmenu" args []
    if input == "" then return()
    else do
        browser <- io getBrowser
        search browser url input

--Actions.cycleWs
doBetween :: (WorkspaceId -> WindowSet -> WindowSet) -> WorkspaceId -> WorkspaceId -> X ()
doBetween f def another = do
    cur <- getCurrentWorkspace
    if def == cur
    then (windows . f) another
    else (windows . f) def

toggleBetween :: WorkspaceId -> WorkspaceId -> X ()
toggleBetween = doBetween greedyView

--Util.?
getCurrentScreen :: X (ScreenId)
getCurrentScreen = gets (screen . current . windowset)

getCurrentWorkspace :: X (WorkspaceId)
getCurrentWorkspace = gets (currentTag . windowset)

--Actions.WorkspaceHistory
getLastViewed' :: ([WorkspaceId] -> [WorkspaceId]) -> X (Maybe WorkspaceId)
getLastViewed' f = do
    history <- workspaceHistory
    accept <- gets $ f . map tag . W.hidden . windowset
    let lastViewed = find (`elem` accept) history
    return $ case (accept, lastViewed) of
        ([], _) -> Nothing
        (h:_, Nothing) -> Just h
        (_, lv@(Just _)) -> lv

getLastViewed :: X (Maybe WorkspaceId)
getLastViewed = getLastViewed' id

getLastViewedWith :: [WorkspaceId] -> X (Maybe WorkspaceId)
getLastViewedWith wss = getLastViewed' $ filter (`elem` wss)

shiftToLastViewed :: X ()
shiftToLastViewed = do
    lastViewed <- getLastViewed
    whenJust lastViewed (windows . shift)

--Actions.Dualhead
setScreenWith :: WorkspaceId -> WorkspaceId -> X ()
setScreenWith s1 s2 = do
    windows $ viewOnScreen 1 s2
    windows $ viewOnScreen 0 s1

perScreen :: X () -> X () -> X ()
perScreen actInMain actInSub = do
    (S currentScreen) <- getCurrentScreen
    case currentScreen of
        0 -> actInMain
        _ -> actInSub

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
    maybe (return ()) id (M.lookup (m', s) keys)
