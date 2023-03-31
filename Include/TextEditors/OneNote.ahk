#IfWinActive, ahk_class Framework::CFrame 
;Functions
    FontDown(times){
        Loop, %times%
            Send, ^+,
    }
    FontUp(times){
        Loop, %times%
            Send, ^+.
    }

;Font Size
    +WheelUp::
    FontUp(1)
    return

    +WheelDown::
    FontDown(1)
    return

^WheelUp:: ;Zoom In
    Send, ^{WheelUp}
    Sleep, 300
    Send, {WheelLeft}{WheelLeft}
    return

^Enter:: ;Skip Line
    Send, {End}{Enter}   
    return
^d:: ;Delete Line
    Send, {End}+{Home}+{Tab}+{Tab}+{Tab}{BackSpace}
    return