{-
 - -- windows --
 - M-Arrow   Move focus to the direction
 - M-S-Arrow Swap the focused window to tho direction
 - M-n/N     Move focus to the next/previous window
 - M-m       Move focus to the master window
 - M-S-m    Set the focused window to the master window
 -
 - -- workspaces & screens --
 - M-[1..0]    Switch to workspace N on primary screen
 - M-[F1..F10]  Switch to workspace N on the other screen
 - M-S-[1..0]  Move the focused window to workspace N
 - M-Tab       Move focus to the other screen
 - M-S-Tab     Move the focused window to the other screen
 - M-Space     Toggle workspaces on the screen
 - M-S-Space   Swap the screen to the other
 -
 - -- launch and close --
 - M-Enter   Launch terminal
 - M-S-Enter Launch terminal in focused window's cwd
 - M-l       Launch launcher
 - M-S-l     Launch oneshot shell
 - M-q       Close the focused window
 - M-S-q     Close all windows in current workspace
 -
 - -- layout --
 - M-f    Toggle fullscreen
 - M-S-f  Sink the focused window
 -
 - -- Resize
 - M-A-Up/Down    change the number of clients in the master pane.
 - M-A-Left/Right change the size of the master pane
 - M-=            reset window size
 - -- search --
 - M-o              Open selected url
 - M-/              Search on google
 - M-s              Search on google with X11 selection
 - M-S-/ [Initial]  Search on selected search engine
 - M-S-s [Initial]  Search on selected search engine with X11 selection
 - -- list of search engine --
 - Amazon, English, Github, Hoogle, Image
 - Japanese, Translate, arch Linux, Youtube, Wikipedia
 -
 - -- Exit --
 - M-Esc      Lock screens
 - M-S-Esc c  Recompile and restart xmonad
 - M-S-Esc e  Exit xmonad
 - M-S-Esc l  Logout
 - M-S-Esc p  Poweroff
 - M-S-Esc s  Suspend
 - M-S-Esc r  Reboot
 -
 - -- misc --
 - M-x    Change cwd to marked directory
-}

import XMonad
import qualified XMonad.StackSet as W
import XMonad.StackSet(StackSet(..), Workspace(..), Screen(..), RationalRect(..), allWindows, view, currentTag, findTag, shiftWin, focusWindow, focusMaster, shiftMaster, focusUp, focusDown, swapDown, swapUp, sink, shift, floating)

import XMonad.Actions.CycleWS(nextScreen, shiftNextScreen, swapNextScreen, toggleOrDoSkip)
import XMonad.Actions.Navigation2D(windowGo, windowSwap)
import XMonad.Actions.OnScreen(viewOnScreen)
import XMonad.Actions.PerWorkspaceKeys(bindOn)
import XMonad.Actions.Search(SearchEngine(..), search, selectSearch, searchEngine, google, hackage, images, wikipedia, youtube)
--import XMonad.Actions.Submap(submap)
import XMonad.Actions.SpawnOn(manageSpawn, spawnOn)
import XMonad.Actions.UpdatePointer(updatePointer)
import XMonad.Actions.WithAll(killAll)

import XMonad.Hooks.DynamicLog(shorten, dynamicLogWithPP, PP(..), xmobarPP, xmobarColor, wrap, pad)
import XMonad.Hooks.EwmhDesktops(ewmh)
import XMonad.Hooks.ManageDocks(docks, avoidStruts)
import XMonad.Hooks.ManageHelpers(isDialog, doRectFloat, doCenterFloat,doFullFloat)
import XMonad.Hooks.SetWMName(setWMName)
import XMonad.Hooks.WorkspaceHistory(workspaceHistory)

import XMonad.Layout.Fullscreen(fullscreenSupport)
import XMonad.Layout.Grid(Grid(..))
import XMonad.Layout.PerWorkspace(onWorkspace)
import XMonad.Layout.Simplest(Simplest(..))
import XMonad.Layout.Tabbed(simpleTabbed)

--import qualified XMonad.Prompt as P
--import XMonad.Prompt(XPConfig, XP)
import XMonad.Prompt.Shell(getBrowser)

import XMonad.Util.Dmenu(menuArgs)
import XMonad.Util.Loggers(Logger, onLogger)
import XMonad.Util.Run(safeSpawn, spawnPipe, hPutStrLn)
import XMonad.Util.Types(Direction1D(..), Direction2D(..))
--import XMonad.Util.WindowProperties(Property(..), hasProperty, getProp32s)
import XMonad.Util.XSelection(promptSelection)

import qualified Control.Exception as E
import Control.Exception(IOException)
import Control.Monad(liftM2)
import Control.Monad.Fix(fix)

import Data.Bits((.&.), shiftL)
import Data.Char(isSpace, isNumber)
import Data.Foldable(traverse_)
import Data.List(find, any, init, concat, intersperse)
import qualified Data.Map as M
import Data.Map(Map)
import Data.Maybe(isJust, catMaybes)

import GHC.IO.Handle.Types(Handle)
import Graphics.X11.ExtraTypes.XF86(xF86XK_AudioLowerVolume, xF86XK_AudioRaiseVolume, xF86XK_AudioMute, xF86XK_AudioPlay)

--import System.Posix(readSymbolicLink, ProcessID)
import System.Directory(setCurrentDirectory, getCurrentDirectory)
import System.Environment(getEnv)
import System.Exit(exitSuccess)

--require package: haskell-regex-compat
import Text.Regex(mkRegex, subRegex)


main :: IO ()
main = do
    bar <- spawnPipe "xmobar"
    xmonad $ (ewmh . fullscreenSupport . docks) def
        { workspaces = myWorkspaces
        , layoutHook = avoidStruts myLayout
        , modMask = mod4Mask
        , terminal = "urxvtc"
        , keys = myKeys
        , logHook = dynamicLogWithPP (mkPP bar) >> updatePointer (0.1, 0.2) (0, 0)
        , startupHook = myStartup
        --, mouseBindings = myMouseBindings
        , manageHook = myManageHook
        --, handleEventHook = fullscreenEventHook
        , focusFollowsMouse = True
        , clickJustFocuses = False
        }

myWorkspaces :: [WorkspaceId]
myWorkspaces = ["1:Edit", "2:Term", "3:Ref", "4:Web", "5:Mail", "6:Message", "7:Media"] ++ map (: ":Any") ['8' .. '9'] ++ ["0:Tray"]

myLayout =
    onWorkspace "0:Tray" Grid
    $ onWorkspace "4:Web" Simplest
    $ defaultLayout
    where
        defaultLayout = horizontal ||| simpleTabbed
        horizontal = Tall nmaster delta ratio
        vertical = Mirror horizontal
        nmaster = 1
        ratio = 1/2 --master pain to others
        delta = 3/100 --be used when to resize window

mkPP :: Handle -> PP
mkPP bar = xmobarPP
    { ppCurrent = xmobarColor "lime" "" . wrap "<" ">"
    , ppVisible = xmobarColor "yellow" "" . wrap "<" ">"
    , ppHidden = xmobarColor "white" "" . wrap "(" ")"
    , ppHiddenNoWindows = xmobarColor "white" ""
    , ppTitle = xmobarColor "lime" "" . shorten 80
    , ppUrgent = xmobarColor "red" ""
    , ppSep = "     "
    , ppWsSep = "  "
    , ppOrder = \(ws:_:t:_) -> [ws, t]
    --, ppSort = fmap (. filterOutWorkspaces ["NSP"]) $ ppSort def
    , ppOutput = hPutStrLn bar
    {-
    , ppExtras =
        [ onLogger (wrap "[" "]" . dirShorten 80 6 . homeToTilde) logCwd
        ]
    -}
    }

myStartup :: X ()
myStartup = do
    --for making Java programs work
    setWMName "LG3D"
    --Are there better solution to detect it is restart?
    ws <- gets windowset
    if isExistAnyWindow ws then return ()
    else do
        spawnOn "4:Web" =<< io getBrowser
        launchTerminalOn "1:Edit"
        setScreenWith "1:Edit" "4:Web"

isExistAnyWindow :: WindowSet -> Bool
isExistAnyWindow ws = any (isJust . stack) (W.workspaces ws)

-- appName: first entry of WM_CLASS
-- className: second entry of WM_CLASS
myManageHook :: ManageHook
myManageHook = composeAll
    [ manageSpawn
    , isDialog --> doFloat
    , title =? "mutt" --> doShiftAndGo "5:Mail"
    , title =? "weechat" --> doShiftAndGo "6:Message"
    -- firefox bookmark window
    , appName =? "Places" --> doRectFloat (RationalRect 0.4 0.3 0.58 0.68)
    , className =? "Fcitx-config-gtk3" --> doCenterFloat
    ]

doShiftAndGo :: WorkspaceId -> ManageHook
doShiftAndGo = doF . liftM2 (.) view shift

guiMask, altMask :: KeyMask
-- win, super, command
guiMask = mod4Mask
altMask = mod1Mask


myKeys :: XConfig Layout -> Map (KeyMask, KeySym) (X ())
myKeys conf = M.fromList $
    [ ((guiMask, xK_Up),   windowGo U False)
    , ((guiMask, xK_Down), windowGo D False)
    , ((guiMask, xK_Left),  windowGo L False)
    , ((guiMask, xK_Right), windowGo R False)

    , ((guiMask .|. shiftMask, xK_Up),   windowSwap U False)
    , ((guiMask .|. shiftMask, xK_Down), windowSwap D False)
    , ((guiMask .|. shiftMask, xK_Left),  windowSwap L False)
    , ((guiMask .|. shiftMask, xK_Right), windowSwap R False)

    , ((guiMask .|. altMask, xK_Up), sendMessage $ IncMasterN 1)
    , ((guiMask .|. altMask, xK_Down), sendMessage $ IncMasterN (-1))
    , ((guiMask .|. altMask, xK_Left), sendMessage Shrink)
    , ((guiMask .|. altMask, xK_Right), sendMessage Expand)
    -- it doesn't work
    , ((guiMask, xK_equal), refresh)

    , ((guiMask, xK_n), windows focusDown)
    , ((guiMask .|. shiftMask, xK_n), windows focusUp)
    , ((guiMask, xK_m), windows focusMaster)
    , ((guiMask .|. shiftMask, xK_m), windows shiftMaster)

    , ((guiMask, xK_l), dmenuRun)

    , ((guiMask, xK_o), promptSelection =<< io getBrowser)

    , ((guiMask, xK_q), kill)
    , ((guiMask .|. shiftMask, xK_q), killAll)

    , ((guiMask, xK_f), sendMessage NextLayout)
    , ((guiMask .|. shiftMask, xK_f), withFocused $ windows . sink)

    , ((guiMask, xK_space), myWsSwitch)
    , ((guiMask .|. shiftMask, xK_space), swapNextScreen)

    , ((guiMask, xK_Tab), nextScreen)
    , ((guiMask .|. shiftMask, xK_Tab), shiftNextScreen)

    , ((guiMask, xK_Return), launchTerminal)
    --, ((guiMask .|. shiftMask, xK_Return), launchTermInFocusedCwd)

    , ((0, xK_Print), screenshot)
    , ((shiftMask, xK_Print), selectingScreenshot)

    , ((0, xF86XK_AudioMute), mute)
    , ((0, xF86XK_AudioPlay), mediaToggle)
    , ((0, xF86XK_AudioLowerVolume), unmute >> volumeDown)
    , ((0, xF86XK_AudioRaiseVolume), unmute >> volumeUp)

    , ((guiMask, xK_slash), dmenuSearch google)
    , ((guiMask .|. shiftMask, xK_slash), submap submapDmenuSearch)
    , ((guiMask, xK_s), raiseOnWeb >> selectSearch google)
    , ((guiMask .|. shiftMask, xK_s), submap submapSelectSearch)

    , ((guiMask, xK_Escape), lock)
    , ((guiMask .|. shiftMask, xK_Escape), submap $ M.fromList $
        [ ((0, xK_c), spawn "xmonad --recompile && xmonad --restart")
        , ((0, xK_e), io exitSuccess)
        , ((0, xK_p), poweroff)
        , ((0, xK_r), reboot)
        , ((0, xK_s), suspend)
        , ((0, xK_h), hibernate)
        ])
    ]
    ++ [((guiMask, k), toggleOrView ws) | (ws, k) <- zip myWorkspaces ([xK_1 .. xK_9] ++ [xK_0])]
    ++ [((guiMask .|. shiftMask, k), windows $ shift ws) | (ws, k) <- zip myWorkspaces ([xK_1 .. xK_9] ++ [xK_0])]
    ++ [((guiMask .|. altMask .|. m, k), app) | (m, k, app) <- myApps]
    where
        myWsSwitch = perScreen (toggleBetween "1:Edit" "2:Term") (toggleBetween "4:Web" "3:Ref")

        raiseOnWeb = windows $ viewOnScreen 1 "4:Web"
        dmenuSearch = dmenuSearchWithConf' raiseOnWeb myDmenuConfig
        dmenuRun = dmenuRunWithConf myDmenuConfig
        --dmenuLaunch = dmenuLaunchWithConf myDmenuConfig myApps

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

        submapDmenuSearch = M.fromList $ [(k, dmenuSearch q) | (k, q) <- searchQuery]
        submapSelectSearch = M.fromList $ [(k, raiseOnWeb >> selectSearch q) | (k, q) <- searchQuery]
        searchQuery =
            [ ((0, xK_a), amazon)
            , ((0, xK_e), english)
            , ((0, xK_g), github)
            , ((0, xK_h), hackage)
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
        myApps =
            [ (0, xK_w, web)
            , (0, xK_m, mail)
            , (0, xK_c, chat)
            , (0, xK_v, vim)
            ]
            where
                web = spawn =<< io getBrowser
                vim = runInTerm "nvim"
                mail = runInTerm "mutt"
                chat = runInTerm "weechat"


--myMouseBindings = M.fromlist

toggleOrView :: WorkspaceId -> X ()
toggleOrView = toggleOrDoSkip [] view

toggleOrViewOnScreen :: ScreenId -> WorkspaceId -> X ()
toggleOrViewOnScreen sid = toggleOrDoSkip [] (viewOnScreen sid)

{-
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
-}

myDmenuConfig :: DmenuConfig
myDmenuConfig = def
    { bottom = True
    , font = "sans-serif 11"
    }

dmenuRunWithConf :: DmenuConfig -> X ()
dmenuRunWithConf conf = do
    (S currentScreen) <- getCurrentScreen
    let args = mkDmenuArgs $ conf
            { monitor = Just currentScreen
            , prompt = "command:"
            }
    safeSpawn "dmenu_run" args

homeToTilde :: String -> String
homeToTilde p =
    let homeRegex = mkRegex "^/home/[^/]+"
    in subRegex homeRegex p "~"

getTerminal :: X String
getTerminal = asks $ terminal . config

getFocusedWindow :: X (Maybe Window)
getFocusedWindow = gets $ W.peek . windowset

{-
getPID :: Window -> X (Maybe ProcessID)
getPID w = do
    pid <- getProp32s "_NET_WM_PID" w
    return $ case pid of
        Just [p] -> Just $ fromIntegral p
        _ -> Nothing

getfocusedPID :: X (Maybe ProcessID)
getfocusedPID = do
    win <- getFocusedWindow
    case win of
        Nothing -> return Nothing
        Just w -> getPID w

focusedHasClassName :: String -> X Bool
focusedHasClassName s = do
    win <- getFocusedWindow
    case win of
        Nothing -> return False
        Just w -> hasProperty (ClassName s) w

iread :: String -> Integer
iread = read

termToShellPID :: Maybe ProcessID -> X (Maybe ProcessID)
termToShellPID term = do
    sh <- case term of
        Nothing -> return Nothing
        Just p -> do
            sh <- io $ readFile ("/proc/" ++ show p ++ "/task/" ++ show p ++ "/children") `E.catch` econst (return "")
            let sh' = takeWhile isNumber sh
            return $ case sh of
                "" -> Nothing
                sh -> Just $ iread sh
    return $ case sh of
        Just p -> Just $ fromIntegral p
        _ -> Nothing

--it doesn't match to focused pid; probably to new window's pid
--that's because its pid is always different but its cwd is always home dir
launchTermInFocusedCwd :: X ()
launchTermInFocusedCwd = do
    cwd_saved <- io $ getCurrentDirectory
    pid_focused <- getfocusedPID
    term <- getTerminal
    is_term <- focusedHasClassName term
    pid_focused' <-
        if is_term
        then termToShellPID pid_focused
        else return pid_focused
    cwd_focused <- case pid_focused' of
        Nothing -> io $ getEnv "HOME"
        Just p -> io $ readSymbolicLink ("/proc/" ++ show p ++ "/cwd") `E.catch` econst (getEnv "HOME")
    io $ setCurrentDirectory cwd_focused
    launchTerminal
    io $ setCurrentDirectory cwd_saved
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
--example
--cd = promptChangeDir $ mkPromptConfig (== '/')
{-
promptChangeDir :: XPConfig -> X ()
promptChangeDir conf = directoryPrompt conf "cd: " (io . changeDir)

emptyIsHome :: FilePath -> IO FilePath
emptyIsHome "" = getEnv "HOME"
emptyIsHome s = return s

changeDir :: FilePath -> IO ()
changeDir s = do
    dest <- emptyIsHome s
    catchIO $ setCurrentDirectory dest
-}

--Hooks.DinamicLog
{-
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

filterOutWorkspaces :: [String] -> [WindowSpace] -> [WindowSpace]
filterOutWorkspaces out = filter (\(Workspace tag _ _) -> not (tag `elem` out))
-}

-- In order to read zshenv, "-e sh -c cmd" is required
--Util.Run
runInTerm' :: (String -> X ()) -> String -> X ()
runInTerm' f cmd = do
    t <- getTerminal
    sh <- getShell
    f $ t ++ " -title " ++ cmd  ++ " -e " ++ sh ++ " -c " ++ cmd

runInTerm :: String -> X ()
runInTerm = runInTerm' spawn

runInTermOn :: WorkspaceId -> String -> X ()
runInTermOn ws = runInTerm' (spawnOn ws)

launchTerminal :: X ()
launchTerminal = spawn =<< getTerminal

launchTerminalOn :: WorkspaceId -> X ()
launchTerminalOn ws = spawnOn ws =<< getTerminal

commandInTerm' :: (String -> X ()) -> String -> X ()
commandInTerm' f cmd = do
    t <- getTerminal
    sh <- getShell
    --terminal -title shell -e shell -c "command && shell"
    f $ t ++ " -title " ++ sh ++ " -e " ++ sh ++ " -c \"" ++ cmd ++ " && " ++ sh ++ "\""

commandInTerm :: String -> X ()
commandInTerm = commandInTerm' spawn

--Util.Loggers
{-
logCwd :: Logger
logCwd = io getCurrentDirectory >>= \cwd -> return $ Just cwd
-}

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

--Util.Environment
econst :: a -> IOException -> a
econst = const

getShell :: X String
getShell = io $ getEnv "SHELL" `E.catch` (econst . return) "bash"

--Actions.Search
dmenuSearchWithConf' :: X () -> DmenuConfig -> SearchEngine -> X ()
dmenuSearchWithConf' f conf (SearchEngine name url) = do
    (S currentScreen) <- getCurrentScreen
    let args = mkDmenuArgs $ conf
            { monitor = Just currentScreen
            , prompt = name ++ ":"
            }
    input <- menuArgs "dmenu" args []
    if input == "" then return ()
    else do
        f
        browser <- io getBrowser
        search browser url input

dmenuSearchWithConf :: DmenuConfig -> SearchEngine -> X ()
dmenuSearchWithConf = dmenuSearchWithConf' (return ())

--Actions.cycleWs
doBetween :: (WorkspaceId -> WindowSet -> WindowSet) -> WorkspaceId -> WorkspaceId -> X ()
doBetween f def another = do
    cur <- getCurrentWorkspace
    if def == cur
    then (windows . f) another
    else (windows . f) def

toggleBetween :: WorkspaceId -> WorkspaceId -> X ()
toggleBetween = doBetween view

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
