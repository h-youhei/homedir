import XMonad
import qualified XMonad.StackSet as StackSet
import XMonad.StackSet(StackSet(..), Workspace(..), Screen(..), allWindows, view, currentTag, findTag, shiftWin, focusWindow, focusMaster, shiftMaster, focusUp, focusDown, swapDown, swapUp, sink, shift)

import XMonad.Actions.CycleWS(nextScreen, shiftNextScreen, swapNextScreen, toggleWS, toggleOrDoSkip, skipTags)
import XMonad.Actions.Navigation2D(windowGo, windowSwap)
import XMonad.Actions.OnScreen(viewOnScreen)
import XMonad.Actions.PerWorkspaceKeys(bindOn)
import XMonad.Actions.Search(SearchEngine(..), search, selectSearch, searchEngine, google, amazon, hoogle, hackage, images, wikipedia, youtube)
--import XMonad.Actions.Submap(submap)
import XMonad.Actions.SpawnOn(manageSpawn, spawnOn, spawnHere)
import XMonad.Actions.UpdatePointer(updatePointer)
import XMonad.Actions.WithAll(killAll)

import XMonad.Hooks.DynamicLog(dynamicLogWithPP, PP(..), xmobarPP, xmobarColor, wrap, pad)
import XMonad.Hooks.EwmhDesktops(ewmh, fullscreenEventHook)
import XMonad.Hooks.ManageDocks(docks, avoidStruts)
import XMonad.Hooks.ManageHelpers(currentWs, isDialog)
import XMonad.Hooks.SetWMName(setWMName)
import XMonad.Hooks.WorkspaceHistory(workspaceHistory)

import XMonad.Layout.Grid(Grid(..))
import XMonad.Layout.PerWorkspace(onWorkspace, onWorkspaces)
import XMonad.Layout.Tabbed(simpleTabbed)

import XMonad.Prompt.Shell(getBrowser)

import XMonad.Util.Dmenu(menuArgs)
import XMonad.Util.Run(runInTerm, safeSpawn, spawnPipe, hPutStrLn)
import XMonad.Util.Types(Direction2D(..))


import Control.Monad.Fix(fix)

import Data.Bits((.&.), shiftL)
import qualified Data.Map.Lazy as Map
import Data.Map.Lazy(Map)
import Data.List(find, any, init, concat)
import Data.Maybe(isJust, catMaybes)

import Graphics.X11.ExtraTypes.XF86(xF86XK_AudioLowerVolume, xF86XK_AudioRaiseVolume, xF86XK_AudioMute, xF86XK_AudioPlay)

import System.Environment(getEnv)
import System.Exit(exitSuccess)


main :: IO ()
main = do
    myStatusBar1 <- spawnPipe "xmobar -x 1"
    myStatusBar2 <- spawnPipe "xmobar -x 2"
    xmonad $ (ewmh . docks) def
        { workspaces = myWorkspaces
        , layoutHook = avoidStruts myLayout
        , modMask = mod4Mask
        , terminal = "xterm"
        , keys = myKeys
        , logHook = myPP myStatusBar1 >> myPP myStatusBar2 >> updatePointer (0.5, 0.2) (0, 0)
        , startupHook = myStartup
        --,mouseBindings = myMouseBindings
        , manageHook = manageApps <+> manageSpawn
        , handleEventHook = fullscreenEventHook
        , focusFollowsMouse = True
        , clickJustFocuses = False
        }

myWorkspaces :: [WorkspaceId]
myWorkspaces = ["1:Main", "2:Sub", "3:Ref", "4:Web", "5:Mail", "6:Media"] ++ map (: ":Any") ['7' .. '9'] ++ ["0:Tray"]

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

myPP bar = dynamicLogWithPP $ xmobarPP
    { ppCurrent = xmobarColor "hotpink" "" . pad . wrap "[" "]"
    , ppVisible = xmobarColor "lime" "" . pad . wrap "<" ">"
    , ppHidden = xmobarColor "white" "" . pad . wrap "(" ")"
    , ppHiddenNoWindows = xmobarColor "white" "" . pad
    --, ppSep = "  |  "
    , ppOrder = \(ws:_) -> [ws]
    --, ppSort = fmap (. filterOutWorkspaces ["NSP"]) $ ppSort def
    , ppOutput = hPutStrLn bar
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
        setScreenWith "1:Main" "4:Web"

isExistAnyWindow :: WindowSet -> Bool
isExistAnyWindow ws = any (isJust . stack) (StackSet.workspaces ws)

manageApps = composeAll
    [ isDialog --> doFloat
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

    , ((guiMask, xK_Down),  windowGo D False)
    , ((guiMask, xK_Up),    windowGo U False)
    , ((guiMask, xK_Left),  windowGo L False)
    , ((guiMask, xK_Right), windowGo R False)
    , ((guiMask .|. shiftMask, xK_Down),  windowSwap D False)
    , ((guiMask .|. shiftMask, xK_Up),    windowSwap U False)
    , ((guiMask .|. shiftMask, xK_Left),  windowSwap L False)
    , ((guiMask .|. shiftMask, xK_Right), windowSwap R False)

    , ((guiMask, xK_Home), windows focusMaster)
    , ((guiMask .|. shiftMask, xK_Home), windows shiftMaster)

    , ((guiMask, xK_q), kill)
    , ((guiMask .|. shiftMask, xK_q), killAll)

    , ((guiMask, xK_l), sendMessage NextLayout)

    , ((guiMask, xK_e), sendMessage Expand)
    , ((guiMask .|. shiftMask, xK_e), sendMessage Shrink)

    , ((guiMask, xK_f), withFocused float)
    , ((guiMask .|. shiftMask, xK_f), withFocused (windows . sink))

    , ((guiMask, xK_space), toggleWS)
    , ((guiMask .|. shiftMask, xK_space), swapNextScreen)

    , ((guiMask, xK_Tab), nextScreen)
    , ((guiMask .|. shiftMask, xK_Tab), shiftNextScreen)

    , ((guiMask, xK_0), onTray fromTray toTray)
    , ((guiMask .|. shiftMask, xK_0), toggleTray)

    , ((guiMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((guiMask .|. shiftMask, xK_Return), io $ terminalWithMark $ XMonad.terminal conf)

    , ((0, xK_Print), screenshot)
    , ((shiftMask, xK_Print), selectingScreenshot)

    , ((0, xF86XK_AudioMute), mute)
    , ((0, xF86XK_AudioPlay), musicToggle)
    , ((0, xF86XK_AudioLowerVolume), volumeDown)
    , ((0, xF86XK_AudioRaiseVolume), volumeUp)

    , ((guiMask, xK_slash), dmenuSearch google)
    , ((guiMask .|. shiftMask, xK_slash), submap submapDmenuSearch)
    , ((guiMask, xK_s), selectSearch google)
    , ((guiMask .|. shiftMask, xK_s), submap submapSelectSearch)

    , ((guiMask, xK_o), dmenuRun)
    , ((guiMask .|. shiftMask, xK_o), submap submapOpenApp)

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
    ++ [((guiMask, k), windows $ viewOnScreen 0 ws) | (ws, k) <- zip workspacesExceptTray [xK_1 .. xK_9]]
    ++ [((guiMask, k), windows $ viewOnScreen 1 ws) | (ws, k) <- zip workspacesExceptTray [xK_F1 .. xK_F9]]
    ++ [((guiMask .|. shiftMask, k), windows $ shift ws) | (ws, k) <- zip workspacesExceptTray [xK_1 .. xK_9]]
    where
        workspacesExceptTray = init myWorkspaces
        toggleTray = toggleOrDoSkip [] view "0:Tray"
        toTray = windows $ shift "0:Tray"
        fromTray = shiftToLastViewed
        onTray actionInTray defaultAction = bindOn [("0:Tray", actionInTray), ("", defaultAction)]
        dmenuSearch = dmenuSearchWithConf myDmenuConfig
        dmenuRun = dmenuRunWithConf myDmenuConfig

        screenshot = spawn "maim $HOME/Pictures/$(date +%F-%T).png"
        selectingScreenshot = spawn "maim -s --nokeyboard $HOME/Pictures/$(date +%F-%T).png"
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

        submapOpenApp = Map.fromList $ [(k, f) | (k, f) <- apps]
        apps =
            [ ((0, xK_w), web)
            , ((0, xK_m), mail)
            , ((0, xK_c), chat)
            , ((0, xK_n), news)
            ]
            where
                web = spawn "firefox -new-window"
                mail = return ()
                chat = return ()
                news = return ()

        submapDmenuSearch = Map.fromList $ [(k, dmenuSearch q) | (k, q) <- searchQuery]
        submapSelectSearch = Map.fromList $ [(k, selectSearch q) | (k, q) <- searchQuery]
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

--myMouseBindings = Map.fromlist

myDmenuConfig :: DmenuConfig
myDmenuConfig = def
    { bottom = True
    , font = "sans-serif 11"
    }


terminalWithMark :: String -> IO ()
terminalWithMark term = do
    confdir <- getXMonadDir
    markfile <- readFile $ confdir ++ "/mark"
    let mark = filter (/= '\n') markfile
    sh <- getEnv "SHELL"
    -- xterm -title xterm -e "cd ~/.xmonad/mark && zsh"
    safeSpawn term ["-title", term, "-e", "cd " ++ mark ++ " && " ++ sh]

--After here. I'd like to add to Contrib
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

dmenuRunWithConf :: DmenuConfig -> X ()
dmenuRunWithConf conf = do
    (S currentScreen) <- getCurrentScreen
    let args = mkDmenuArgs $ conf { monitor = Just currentScreen }
    safeSpawn "dmenu_run" args

--Util.?
getCurrentScreen :: X (ScreenId)
getCurrentScreen = do
    ws <- gets windowset
    return $ screen $ current ws

getLastViewed :: X (Maybe WorkspaceId)
getLastViewed = do
    history <- workspaceHistory
    ws <- gets windowset
    let hdnWs = map tag . hidden $ ws
    let lastViewed = find (`elem` hdnWs) history
    return $ case (hdnWs, lastViewed) of
        ([], _) -> Nothing
        (empty:_, Nothing) -> Just empty
        (_, Just lv) -> Just lv


--Hooks.DynamicLog
filterOutWorkspaces :: [String] -> [WindowSpace] -> [WindowSpace]
filterOutWorkspaces out = filter (\(Workspace tag _ _) -> not (tag `elem` out))

setScreenWith :: WorkspaceId -> WorkspaceId -> X ()
setScreenWith s1 s2 = do
    windows $ viewOnScreen 1 s2
    windows $ viewOnScreen 0 s1

shiftToLastViewed :: X ()
shiftToLastViewed = do
    lastViewed <- getLastViewed
    whenJust lastViewed (windows . shift)

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
