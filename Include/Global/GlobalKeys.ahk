;======= Global Keys =======
~^+r:: ;Reload Script
    WinGetActiveStats, Title, Width, Height, X, Y
    if RegExMatch(Title, "eclipse")
        return
    else
        Reload
    return

Pause:: ;Pause Script
    Run, PauseMain.ahk , TempScripts
    ExitApp

F10::
!+s:: ;Switch Sound Output
    ToggleSoundOutput()
    return

^F9:: ;GHub button - Close Window from taskbar
    CloseTaskBarWindow()
    return

+Pause:: ; Get mouse coords
    clipMouseCoords()
    return
!+Pause:: ;Get mouse coord in screen mode
    clipMouseCoords(1)
    return
    
^Capslock::
    Send, {Media_Play_Pause}
    return

^F10:: ;GHub button - mouse to third screen or back
    MoveMouseThirdScreen()
    return
; ==============  Temporary Scripts  ================
^+F9:: ;Launch Elden Ring with AutoSave
    Sleep, 500
    Run, EldenScript.ahk
    return

^+F11:: ;AIDungeon controls
    Run, AI.ahk , Tempscripts
    return

^+Space::
    KeyWait, Lctrl
    Read(snapActive, "SnapState", "active")
    if (snapActive = 0)
    {
        Run, SnapMain.ahk
        Write(1, "SnapState", "active")
    }
    else
        Write(0, "SnapState", "active")
    return

#IfWinActive, ahk_exe SNAP.exe
^Space::
    Write(1, "SnapState", "play")
    return