--
-- xmonad example config file.

-- inspiration http://www.haskell.org/haskellwiki/Xmonad/Config_archive/k6b_%28kyle%27s%29_xmonad.hs
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import XMonad
import Data.Monoid
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- by me 02-09-2012
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import XMonad.Layout.NoBorders

-- by me 06-09-2012 to add multimedia keys
import Graphics.X11.ExtraTypes.XF86

-- by me 29-09-2012 to add clickable dzen2 areas
import Data.List

-- by me 01-11-2012
-- qimport XMonad.Config.Xfce

-- by me 15-06-2013
import XMonad.Actions.NoBorders

-- by me 28-06-2013
import XMonad.Layout.Grid

-- by me 25-07-2013
import XMonad.Hooks.UrgencyHook

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "urxvt -lsp 2"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Width of the window border in pixels.
--
myBorderWidth   = 3

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod1Mask
-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--

-- uncommented 29-09-2012
-- myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- added 29-09-2012
myWorkspaces            :: [String]
myWorkspaces            = clickable . (map dzenEscape) $ ["1","2","3","4","5","6","7","8","9"]
 
  where clickable l     = [ "^ca(1,xdotool key alt+" ++ show (n) ++ ")" ++ ws ++ "^ca()" |
                            (i,ws) <- zip [1..] l,
                            let n = i ]
-- end added 29-09-2012

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#303030"
myFocusedBorderColor = "#afd700"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_p     ), spawn "gmrun")

    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "dmenu_run")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Added 15-06-2013
    , ((modm              , xK_z ), withFocused toggleBorder)

-- added by me 06-09-2012 start
-- added module too
-- multimedia keys for ncmpcpp
-- pulseaudio_ctl package needed

--    , ((0                 , 0x1008ff12     ), spawn "ncmpcpp toggle")

--         , ((0, xF86XK_AudioMute), spawn "/usr/bin/mute_toggle")
--         , ((0, xF86XK_AudioLowerVolume), spawn "/usr/bin/vol_down")
--         , ((0, xF86XK_AudioRaiseVolume ), spawn "/usr/bin/vol_up")
--         , ((0, xF86XK_AudioMute), spawn "pamixer --toggle-mute")
--         , ((0, xF86XK_AudioLowerVolume), spawn "pamixer --decrease 5")
--         , ((0, xF86XK_AudioRaiseVolume), spawn "pamixer --increase 5")
         , ((0, xF86XK_AudioMute), spawn "amixer -D pulse sset Master toggle")
         , ((0, xF86XK_AudioLowerVolume), spawn "amixer -D pulse sset Master 5%-")
         , ((0, xF86XK_AudioRaiseVolume ), spawn "amixer -D pulse sset Master 5%+")
         , ((0, xF86XK_AudioStop), spawn "mpc stop")
         , ((0, xF86XK_AudioPrev), spawn "mpc prev")
         , ((0, xF86XK_AudioNext), spawn "mpc next")
         , ((0, xF86XK_AudioPlay), spawn "mpc toggle")

-- added by me end


    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Shutdown session added by me 19-11-2012
    , ((modm .|. shiftMask, xK_q     ),  spawn "~/.xmonad/Scripts/endsession.sh")

    -- Quit xmonad
    -- , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "killall conky dzen2 && xmonad --recompile && xmonad --restart && conky -c ~/.xmonad/.conkyrc-todo")
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = tiled ||| Grid ||| Mirror tiled ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "Gimp"        --> doFloat
--    , className =? "Vlc"           --> doFloat
    , className =? "Gxmessage"           --> doFloat
    , (className =? "Firefox" <&&> resource =? "Dialog") --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
--myLogHook = return ()
-- stopped by me

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = return ()

-- added by me start
--myStartupHook = do
--            spawn "~/.xmonad/xmonad-status.sh"
--added by me end

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
main = do
    dzen <- spawnPipe myStatusBar
    conkytop <- spawnPipe myTopBar
    conkytop2 <- spawnPipe myTopBar2

-- added by me 01-08-2013

    conkyondesktop <- spawnPipe bgconky
    
--    xmonad $ xfceConfig {
-- by me 25-06-2013
--    xmonad $ withUrgencyHook NoUrgencyHook xfceConfig {
    xmonad $ defaultConfig {
      -- simple stuff

        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook=avoidStruts $ smartBorders $ myLayout,
        manageHook         = myManageHook  <+> manageDocks,
        handleEventHook    = myEventHook,
        logHook            = dynamicLogWithPP $ myDzenPP_ dzen,
        startupHook        = myStartupHook
    }

-- Configs

myFont = "dejavu sans:size=8:antialias=true"
myIconDir = "~/.xmonad/dzen2/xbm8x8"
myDzenFGColor = "#d0d0d0"
myDzenBGColor = "#303030"
myNormalFGColor = "#d0d0d0"
myNormalBGColor = "#303030"
myFocusedFGColor = "#000000"
myFocusedBGColor = "#afd700"
myUrgentFGColor = "#303030"
myUrgentBGColor = "#303030"
myIconFGColor = "#d0d0d0"
myIconBGColor = "#303030"
myPatternColor = "#303030"
mySeperatorColor = "#d0d0d0"
myVisibleColor = "#585858"
myHiddenColor = "#585858"

-- Background conky
-- added by me 01-08-2013 

bgconky = "conky -c ~/.xmonad/.conkyrc-todo" 

-- Statusbar options:
myStatusBar = "dzen2 -x '0' -y '0' -h '20' -w '498' -ta 'l' -fg '" ++ myDzenFGColor ++ "' -bg '" ++ myDzenBGColor ++ "' -fn '" ++ myFont ++ "'"
myTopBar2 = "conky -c ~/.xmonad/.conky_dzen2 | dzen2 -x '498' -y '0' -h '20' -w '622' -ta 'l' -fg '" ++ myDzenFGColor ++ "' -bg '" ++ myDzenBGColor ++ "' -fn '" ++ myFont ++ "'"
myTopBar = "conky -c ~/.xmonad/.conky_dzen | dzen2 -x '1120' -y '0' -h '20' -w '246' -ta 'r' -fg '" ++ myDzenFGColor ++ "' -bg '" ++ myDzenBGColor ++ "' -fn '" ++ myFont ++ "'"

-- dynamicLog pretty printer for dzen:
myDzenPP_ h = defaultPP
    { ppCurrent = wrap ("^p(3)^ib(1)^fg(" ++ myFocusedBGColor ++ ")^i(" ++ myIconDir ++ "/corner_left.xbm)^r(1300x12)^p(-1300)^fg(" ++ myUrgentFGColor ++ ")^bg(" ++ myFocusedBGColor ++ ")^p()^fg(" ++ myFocusedFGColor ++ ")^p(2)") ("^p(2)^fg(" ++ myFocusedBGColor ++ ")^i(" ++ myIconDir ++ "/corner_right.xbm)^fg(" ++ myNormalBGColor ++ ")^r(1300x12)^p(-1300)^ib(0)^fg()^bg()^p()")
    , ppVisible = wrap ("^p(3)^ib(1)^fg(" ++ myVisibleColor ++ ")^i(" ++ myIconDir ++ "/corner_left.xbm)^r(1300x12)^p(-1300)^fg(" ++ myNormalFGColor ++ ")^bg(" ++ myFocusedBGColor ++ ")^p()^fg(" ++ myNormalFGColor ++ ")^p(2)") ("^p(2)^fg(" ++ myPatternColor ++ ")^i(" ++ myIconDir ++ "/corner_right.xbm)^fg(" ++ myNormalBGColor ++ ")^r(1300x12)^p(-1300)^ib(0)^fg()^bg()^p()")
    , ppHidden = wrap ("^p(3)^ib(1)^fg(" ++ myHiddenColor ++ ")^i(" ++ myIconDir ++ "/corner_left.xbm)^r(1300x12)^p(-1300)^fg()^bg()^p()^p(2)") ("^p(2)^fg(" ++ myPatternColor ++ ")^i(" ++ myIconDir ++ "/corner_right.xbm)^fg(" ++ myNormalBGColor ++ ")^r(1300x12)^p(-1300)^p()^ib(0)^fg()^bg()^p()")
    , ppUrgent = wrap (("^p(3)^ib(1)^fg(" ++ myPatternColor ++ ")^i(" ++ myIconDir ++ "/corner_left.xbm)^r(1300x12)^p(-1300)^fg(" ++ myUrgentFGColor ++ ")^bg(" ++ myNormalBGColor ++ ")^p()^fg(" ++ myUrgentFGColor ++ ")^p(2)")) ("^p(2)^fg(" ++ myPatternColor ++ ")^i(" ++ myIconDir ++ "/corner_right.xbm)^fg(" ++ myNormalBGColor ++ ")^r(1300x12)^p(-1300)^ib(0)^fg()^bg()^p()")
    , ppSep = " "
    , ppWsSep = ""
    , ppTitle = dzenColor ("" ++ myNormalFGColor ++ "") "" . wrap ("^ib(1)^fg(" ++ myPatternColor ++ ")^i(" ++ myIconDir ++ "/corner_left.xbm)^r(1300x12)^p(-1300)^p(2)^fg()< ") (" >^p(2)^fg(" ++ myPatternColor ++ ")^i(" ++ myIconDir ++ "/corner_right.xbm)^fg(" ++ myNormalBGColor ++ ")^r(1300x12)^p(-1300)^ib(0)^fg()")  . shorten 280
    , ppOutput = hPutStrLn h
    , ppLayout            =   dzenColor "#afd700" "#303030" .
      (\x -> case x of
          "Tall"             ->      " ^i(~/.xmonad/dzen2/xbm8x8/layout_tall.xbm)"
          "Grid"             ->      " ^i(~/.xmonad/dzen2/xbm8x8/layout_grid.xbm)"
          "Mirror Tall"      ->      " ^i(~/.xmonad/dzen2/xbm8x8/layout_mirror_tall.xbm)"
          "Full"                      ->      " ^i(~/.xmonad/dzen2/xbm8x8/layout_full.xbm)"
          _                           ->      x
      )
    }
