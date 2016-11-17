import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import XMonad.Layout.IM
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Reflect
import XMonad.Layout.Grid
import XMonad.Prompt
import XMonad.Prompt.Man 
import XMonad.Hooks.SetWMName 
import XMonad.Hooks.EwmhDesktops
import System.IO
 
myTerminal  = "gnome-terminal"
myWorkspaces = ["1:Fun","2:Study","3:Research","4:Music","5:Gimp","6:ServerRoom","7:Work","8:Additional 1","9: Additional 2"] 
myManageHook = composeAll
    [ className =? "smplayer"       
    , className =? "Gimp"           
    , className =? "subl3"          
    , className =? "feh"            
    , className=? "Spotify"         
    , className=? "Mendley"         
    ]
myLayoutHook = onWorkspace "5:Gimp" gimp $ onWorkspace "7:Work" standardLayout $ onWorkspace "Panic!" webLayout $ standardLayout 
    where
        standardLayout = avoidStruts ( Mirror tall ||| tall ||| Grid ||| Full ) 
            where
                tall = Tall nmaster delta ratio 
                nmaster = 1 
                ratio = 1/2 
                delta = 2/100
 
        gimp =  avoidStruts $ 
                withIM (0.11) (Role "gimp-toolbox") $ 
                reflectHoriz $
                withIM (0.15) (Role "gimp-dock") Full 
        terminalLayout = avoidStruts $ Grid 
        webLayout = avoidStruts $ Mirror tall 
            where
                tall = Tall nmaster delta ratio 
                nmaster = 1 
                ratio = 3/4 
                delta = 2/100

myLogHook h = dynamicLogWithPP xmobarPP
            { ppHidden = xmobarColor "grey" "" 
            , ppOutput = hPutStrLn h           
            , ppTitle = xmobarColor "green" "" 
            }
myStatusBar = "xmobar" 
myStartupHook :: X ()
myStartupHook = do
            spawn "~/scripts/startup.sh" 
            setWMName "LG3D"
 
main = do 
    din <- spawnPipe myStatusBar
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
        , layoutHook = myLayoutHook 
        , logHook = myLogHook din
        , startupHook = myStartupHook
        , terminal = myTerminal
        , workspaces = myWorkspaces
        , modMask = mod4Mask 
        , handleEventHook    = fullscreenEventHook
        , normalBorderColor  = "#00000"
        , focusedBorderColor = "#cd8bff"
        } `additionalKeys`
        [ ((mod4Mask, xK_F1),   spawn "chromium") 
        , ((mod4Mask, xK_m),    spawn "nylas-mail")
        , ((mod4Mask, xK_F11),  spawn "sudo /sbin/reboot") 
        , ((mod4Mask, xK_F12),  spawn "sudo /sbin/shutdown -h now") 
        , ((mod4Mask, xK_p),    spawn "dmenu_run -nb black -nf white") 
        , ((mod4Mask .|. shiftMask, xK_h), spawn "feh 
        , ((mod4Mask, xK_F1),   manPrompt defaultXPConfig) 
        , ((0, xK_Print),       spawn "'scrot' -e 'mv $f ~/Pictures/screenshots'") 
        
        , ((0, 0x1008ff13),     spawn "pamixer 
        , ((0, 0x1008ff11),     spawn "pamixer 
        , ((0, 0x1008ff12),     spawn "pamixer 
        , ((0, 0x1008ff2c),     spawn "eject") 
        , ((mod1Mask,xK_Shift_L), spawn  "sh /home/posten/layout_switch.sh") 
        , ((shiftMask,xK_Alt_L), spawn "sh /home/posten/layout_switch.sh")
        , ((mod1Mask,xK_Shift_R), spawn  "sh /home/posten/layout_switch.sh") 
        , ((shiftMask,xK_Alt_R), spawn "sh /home/posten/layout_switch.sh")
        , ((mod1Mask,xK_F9), spawn("xbacklight -inc 10"))
        , ((mod1Mask,xK_F8), spawn("xbacklight -dec 10"))
        , ((mod1Mask .|. controlMask, xK_l), spawn "slock")
        ] 
