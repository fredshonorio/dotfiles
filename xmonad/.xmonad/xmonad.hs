import XMonad                      (XConfig(..), X(..), Window, WindowSpace
                                   , spawn, xmonad, composeAll, doFloat, stringProperty, doIgnore, className
                                   , (.|.), (<+>), (|||), (-->), (=?)
                                   , shiftMask, modMask, mod4Mask, noModMask
                                   , xK_p, xK_c, xK_q, xK_b, xK_s, xK_f, xK_Print, xK_t, xK_e, xK_a, xK_s
                                   , screenWorkspace, whenJust, windows
                                   )
import XMonad.Actions.SpawnOn      (spawnHere)
import XMonad.Config.Desktop       (desktopConfig)
import XMonad.Hooks.SetWMName      (setWMName)
import XMonad.Hooks.FadeInactive   (fadeInactiveLogHook)
import XMonad.Hooks.DynamicLog     (xmobarPP, xmobarColor, dynamicLogWithPP, PP(..), shorten)
import XMonad.Hooks.ManageDocks    (avoidStruts)
import XMonad.Hooks.ManageHelpers  (doFullFloat, isFullscreen)
import XMonad.Hooks.Place          (fixed, placeHook)
import XMonad.Layout               (Full(..), Tall(..))
import XMonad.Layout.Grid          (Grid(..))
import XMonad.Layout.ComboP        (SwapWindow(..), Property(..), combineTwoP)
import XMonad.Layout.TwoPane       (TwoPane(..))
import XMonad.Layout.Named         (named)
import XMonad.Layout.NoBorders     (smartBorders)
import XMonad.Layout.Fullscreen    (fullscreenSupport)
import XMonad.Layout.ToggleLayouts (ToggleLayout(..), toggleLayouts)
import XMonad.Operations           (sendMessage, screenWorkspace, windows)
import XMonad.Util.Run             (spawnPipe, hPutStrLn, safeSpawn)
import XMonad.Actions.WindowBringer (WindowBringerConfig(..), gotoMenuConfig)
import XMonad.StackSet (tag)
import XMonad.Util.NamedWindows (getName)

import qualified XMonad.StackSet as W
import qualified Data.Map as M

-- monokai theme colors
mForeground = "#F8F8F2"
mBackground = "#272822"
mGreen      = "#A6E22E"
mRed        = "#F92672"

main = do
  xmobarProcess <- spawnPipe "xmobar ~/.xmobarrc"
  xmonad $ desktopConfig
    { terminal           = "wezterm"
    , modMask            = mod4Mask
    , keys               = myKeys <+> keys desktopConfig
    , borderWidth        = 5
    , normalBorderColor  = mBackground
    , focusedBorderColor = mRed
    , startupHook        = startup
    , logHook            = xmobarHook xmobarProcess <+> transparencyHook
    , layoutHook         = avoidStruts . smartBorders $ layouts
    , manageHook         = manageHooks
    }

-- use $ xwininfo to find the wmName for a window
manageHooks = composeAll
  [ isFullscreen                --> doFullFloat -- without this vlc doesn't correctly come out of full screen
  , wmName    =? "sakura_float" --> placeHook (fixed (0.5, 0.5)) <+> doFullFloat
  , wmName    =? "Krita - Edit Text" --> placeHook (fixed (0.5, 0.5)) <+> doFullFloat
  , className =? "trayer"       --> doIgnore
  , wmName    =? "xfce4-notifyd" --> doIgnore
  ]
  where
    wmName = stringProperty "WM_NAME"

layouts = toggleLayouts full (tall ||| twoPane ||| grid)
  where
    full    = Full              -- fullscreen
    tall    = Tall 1 0.03 0.5   -- tall
    twoPane = TwoPane 0.03 0.5  -- keep only two windows visible
    grid    = Grid              -- a fair-ish grid, usefull for multiple terminals
    -- streams = named "Streams" $ -- keep non-master windows visible, mod+shift+s swaps windows
    --  combineTwoP twoPane full grid (Const True)

-- https://xmonad.github.io/xmonad-docs/xmonad-contrib/src/XMonad.Actions.WindowBringer.html
rofiCfg :: WindowBringerConfig
rofiCfg = WindowBringerConfig "rofi" ["-dmenu", "-i"] decorateName (\_ -> return True)

myKeys (XConfig {modMask = mod}) = M.fromList $
    [ ((mod,               xK_p), spawn "rofi -show run -modi run")
    , ((mod .|. shiftMask, xK_p), spawn "xfce4-appfinder")
    , ((mod,               xK_e), spawn "nemo")
    , ((mod,               xK_c), gotoMenuConfig rofiCfg)
    , ((mod .|. shiftMask, xK_q), spawn "xfce4-session-logout")
    , ((mod .|. shiftMask, xK_t), spawn "sakura -t sakura_float -r 20 -c 150")
    -- , ((mod .|. shiftMask, xK_s), sendMessage $ SwapWindow)   -- only usable in combineTwoP (streams) layout
    , ((mod              , xK_f), sendMessage $ ToggleLayout) -- toggle fullscreen
    , ((noModMask        , xK_Print), spawn "xfce4-screenshooter --fullscreen")
    ] ++
    [((m .|. mod, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_a, xK_s] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

wallpapers = "$HOME/Tresors/wallpapers/*"

startup = setWMName "LG3D"                                          -- required for java apps
          >> spawnHere ("feh --randomize --bg-center " ++ wallpapers) -- load random wallpaper

-- transparency for inactive windows
transparencyHook = fadeInactiveLogHook 0.97 -- percent

xmobarHook xmobarProc = dynamicLogWithPP $                 -- setup xmonad to output status to xmobar
  xmobarPP { ppOutput = hPutStrLn xmobarProc               -- write message to xmobar stdin
           , ppTitle = xmobarColor mGreen "" . shorten 140 -- display window title
           , ppCurrent = xmobarColor mRed ""               -- display current workspace
           , ppUrgent = xmobarColor mRed ""
           , ppSep = " ~ "
           }
-- util
decorateName workspace window = do
  name <- show <$> getName window
  return $ "[" ++ tag workspace ++ "] " ++ name
