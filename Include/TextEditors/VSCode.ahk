#IfWinActive, ahk_exe Code\.exe 
#Include, TextEditors\VsCodeFunctions.ahk
;======= Hotkeys =======
F4:: ;Type Symbol
    saveClipboard := clipboard
    MouseGetPos, xReturn, yReturn
    Click 2
    Sleep, 50
    Copy()
    Click 427, 57
    Sleep, 50
    Send, ^v
    MouseMove, %xReturn%, %yReturn%
    Sleep, 250
    clipboard := saveClipboard
    return

^r:: ;Save and Reload
        Send, ^s
        Sleep, 200
        Reload
        return
        
~^w:: ;Quick Close Draft
    ;CoordModeScreen()
    i := 0
    while !CheckImage("vsCloseWarning", 741, 407, 1920, 1080)
    {
        Sleep, 50
        if (i = 8)
            return
        i++
    }
    Send, {right}{Enter}
    return

+CapsLock:: ;Replace All
    Sleep, 200
    SetKeyDelay, 50, 10
    Send, +{Tab}+{Tab}^{F2}
    return

F2:: ;New Hotkey, comment new Hotkey on double press
    WinGetActiveStats, title, Width, Height, X, Y
    if !RegExMatch(title, "ahk")
    {
        Send, {F2}
        return
    }   
    Read(commentScript, "VSCode", "commentScript")
    KeyWait, F2
    if (commentScript = 1)
    {
        Send, {Up}{End}{Space};
        Write(0, "VSCode", "commentScript")
        return
    }
    Send, ::{Home}+{Home} 
    Start := GetSelectionLength()
    remainder := Mod(Start, 4)
    if (remainder > 0)
        Start := 0
    
    Send, {End}{Enter}{Enter}{Home}
    Loop, % (Start/4)+1
        Send, {Tab}
    Send, return{Esc}{Up}{Home}
    Loop, % (Start/4)+1
        Send, {Tab}
    
    Write(1, "VSCode", "commentScript")
    SetTimer, CommentScriptTimer, 3000
    return

;Timer for Commenting Script
        CommentScriptTimer:
            Write(0, "VSCode", "commentScript")
            SetTimer, CommentScriptTimer, Off
            return

^,:: ;Fast comma
    Send, {right},{space}
    return

!t::
    SurroundText("=======")
    return

!g::
    SurroundText("---")
    return
    
^m:: ;Msg box
    Autotype("MsgBox,,,  , 2")
    Loop, 4
        Send, {Left}
    return
;
;======= Box Scripts =======
; ^b:: ;Create Box Around Selection
;     KeyWait, Lctrl
;     Input, size, L1 T1, ,1,2,3
;     if (ErrorLevel = "Timeout")
;         size := 0
;     CreateBox(size)
;     return

; !b:: ; Custom Box
;     KeyWait, Lalt
;     CustomBox()
;     return
