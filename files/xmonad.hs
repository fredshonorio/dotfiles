import XMonad                      (XConfig(..), X(..), Window, WindowSpace
                                   , spawn, xmonad, composeAll, doFloat, stringProperty, doIgnore, className, appName
                                   , (.|.), (<+>), (|||), (-->), (=?)
                                   , shiftMask, modMask, mod4Mask, noModMask
                                   , xK_p, xK_c, xK_q, xK_b, xK_s, xK_f, xK_Print, xK_t, xK_e, xK_a, xK_s, xK_w
                                   , screenWorkspace, whenJust, windows
                                   )
import XMonad.Actions.SpawnOn      (spawnHere)
import XMonad.Config.Desktop       (desktopConfig)
import XMonad.Hooks.SetWMName      (setWMName)
import XMonad.Hooks.FadeInactive   (fadeInactiveLogHook)
import XMonad.Hooks.DynamicLog     (dynamicLogWithPP, PP(..), def, wrap)
import XMonad.Hooks.ManageDocks    (avoidStruts, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers  (doFullFloat, isFullscreen)
import XMonad.Hooks.Place          (fixed, placeHook)
import XMonad.Layout               (Full(..), Tall(..))
import XMonad.Layout.Grid          (Grid(..))
import XMonad.Layout.ComboP        (SwapWindow(..), Property(..), combineTwoP)
import XMonad.Layout.TwoPane       (TwoPane(..))
import XMonad.Layout.Named         (named)
import XMonad.Layout.NoBorders     (noBorders, smartBorders)
import XMonad.Layout.ToggleLayouts (ToggleLayout(..), toggleLayouts)
import XMonad.Operations           (sendMessage, screenWorkspace, windows, kill)
import XMonad.Util.Run             (spawnPipe, hPutStrLn, safeSpawn)
import XMonad.Actions.WindowBringer (WindowBringerConfig(..), gotoMenuConfig)
import XMonad.StackSet (tag)
import XMonad.Util.NamedWindows (getName)
import XMonad.Hooks.EwmhDesktops (ewmh)
-- polybar
import qualified DBus as D
import qualified DBus.Client as D
import qualified Codec.Binary.UTF8.String as UTF8
--
import qualified XMonad.StackSet as W
import qualified Data.Map as M

-- https://github.com/xmonad/xmonad/blob/master/TUTORIAL.md

-- monokai theme colors
mForeground = "#F8F8F2"
mBackground = "#272822"
mGreen      = "#A6E22E"
mRed        = "#F92672"

myTerminal   = "wezterm"
wallpapers   = "$HOME/wallpapers/*"
startPolybar =  "$HOME/.bin/polybar.sh"

main = do
  dbus <- D.connectSession
  _ <- D.requestName dbus (D.busName_ "org.xmonad.Log") [ D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue ]
  xmonad $ ewmh $ desktopConfig
    { terminal           = myTerminal
    , modMask            = mod4Mask
    , keys               = myKeys <+> keys desktopConfig
    , borderWidth        = 4
    , normalBorderColor  = mBackground
    , focusedBorderColor = mRed
    , startupHook        = startup
    , logHook            = polybarLogHook dbus <+> transparencyHook
    , layoutHook         = layouts
    , manageHook         = manageHooks
    }

polybarLogHook :: D.Client -> X ()
polybarLogHook dbus = dynamicLogWithPP $ def
    { ppOutput  = dbusOutput dbus
    , ppTitle   = \_ -> ""            -- dont't output window title, polybar handles showing it
    , ppCurrent = polybarColor mRed   -- display current workspace
    , ppUrgent  = polybarColor mGreen
    , ppSep     = " ~ "
    }
    where
      polybarColor :: String -> String -> String
      polybarColor clr = wrap ("%{F" ++ clr ++ "} ") " %{F-}"

      dbusOutput :: D.Client -> String -> IO ()
      dbusOutput dbus str = do
          let signal = (D.signal objectPath interfaceName memberName) {
                  D.signalBody = [D.toVariant $ UTF8.decodeString str]
              }
          D.emit dbus signal
        where
          objectPath = D.objectPath_ "/org/xmonad/Log"
          interfaceName = D.interfaceName_ "org.xmonad.Log"
          memberName = D.memberName_ "Update"

-- use $ xwininfo to find the wmName for a window
manageHooks = composeAll
  [ isFullscreen                     --> doFullFloat -- without this vlc doesn't correctly come out of full screen
  , wmName    =? "sakura_float"      --> placeHook (fixed (0.5, 0.5)) <+> doFullFloat
  , wmName    =? "Krita - Edit Text" --> placeHook (fixed (0.5, 0.5)) <+> doFullFloat
  , wmName    =? "xfce4-notifyd"     --> doIgnore
  , appName   =? "copyq"             --> placeHook (fixed (0.5, 0.5)) <+> doFullFloat
  ]
  where
    wmName = stringProperty "WM_NAME"

layouts = avoidStruts $ toggleLayouts full rest
  where
    full    = noBorders Full    -- fullscreen
    tall    = Tall 1 0.03 0.5   -- tall
    twoPane = TwoPane 0.03 0.5  -- keep only two windows visible
    grid    = Grid              -- a fair-ish grid, usefull for multiple terminals
    rest    = smartBorders $ (tall ||| twoPane ||| grid) -- add spacing to all layouts except full

-- https://xmonad.github.io/xmonad-docs/xmonad-contrib/src/XMonad.Actions.WindowBringer.html
rofiCfg :: WindowBringerConfig
rofiCfg = WindowBringerConfig "rofi" ["-dmenu", "-i"] decorateName (\_ -> return True)

myKeys (XConfig {modMask = mod}) = M.fromList $
    [ ((mod,               xK_p), spawn "rofi -show run -modi run")
    , ((mod .|. shiftMask, xK_p), spawn "xfce4-appfinder")
    , ((mod,               xK_e), spawn "thunar")
    , ((mod,               xK_c), gotoMenuConfig rofiCfg)
    , ((mod .|. shiftMask, xK_q), spawn "xfce4-session-logout")
    , ((mod .|. shiftMask, xK_t), spawn "sakura -t sakura_float -r 20 -c 150")
    , ((mod,               xK_t), spawn myTerminal)
    , ((mod,               xK_w), kill)
    -- , ((mod .|. shiftMask, xK_s), sendMessage $ SwapWindow)   -- only usable in combineTwoP (streams) layout
    , ((mod              , xK_f), sendMessage $ ToggleLayout) -- toggle fullscreen
    , ((mod              , xK_b), sendMessage $ ToggleStruts) -- toggle struts
    , ((noModMask        , xK_Print), spawn "xfce4-screenshooter --fullscreen")
    ] ++
    [((m .|. mod, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_a, xK_s] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


startup =
  do
    setWMName "LG3D"                                       -- required for java apps
    spawnHere ("feh --randomize --bg-fill " ++ wallpapers) -- load random wallpaper
    spawn startPolybar

-- transparency for inactive windows
transparencyHook = fadeInactiveLogHook 0.97 -- percent

-- util
decorateName workspace window = do
  name <- show <$> getName window
  return $ "[" ++ tag workspace ++ "] " ++ name
