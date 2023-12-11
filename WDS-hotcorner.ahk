;---- Duletun, 2023 ----;
#Persistent
SetTimer, HotCorners, 0
cornerActivated := false
hotkeysEnabled := true
return

HotCorners:
    if (!hotkeysEnabled)
        return

    CoordMode, Mouse, Screen

    ; Get desktop size
    WinGetPos, X, Y, Xmax, Ymax, Program Manager

    ; Adjust tolerance value if desired
    T = 10

    ; Get the mouse position
    MouseGetPos, MouseX, MouseY

    ; Check if the mouse is in the top left corner
    TopLeftCorner := (MouseY < T and MouseX < T)

    if (TopLeftCorner and !cornerActivated) {
        ; Open task view
        Run, explorer.exe shell:::{3080F90E-D7AD-11D9-BD98-0000947B0257}
        cornerActivated := true
    }

    if (!TopLeftCorner) {
        cornerActivated := false
    }

    return

; Hotkeys for switching virtual desktops
!WheelUp::
    if (hotkeysEnabled)
        Send, ^#{Left}
		Sleep, 100
return

!WheelDown::
    if (hotkeysEnabled)
        Send, ^#{Right}
		Sleep, 100
return

!z::
    if (hotkeysEnabled)
        Send, ^#{Left}
return

!x::
    if (hotkeysEnabled)
        Send, ^#{Right}
return

; Toggle all functions on and off with the right Shift key press
>RShift::
    hotkeysEnabled := !hotkeysEnabled
    if (hotkeysEnabled)
        ShowCustomMessage("Hotkeys Enabled", "ENABLED", "Green")
    else
        ShowCustomMessage("Hotkeys Disabled", "DISABLED", "Red")
return

ShowCustomMessage(title, text, color) {
   ; SplashTextOn, 200, 50, %title%, %text%
   ; Sleep 500
   ; SplashTextOff
	
	Gui, +AlwaysOnTop -Caption +ToolWindow
    Gui, Color, White
    Gui, Font, c%color%
    Gui, Add, Text,+Center w80, %text%
    Gui, Show, w100 h25, %title%
    Sleep, 500
    Gui, Destroy
}
