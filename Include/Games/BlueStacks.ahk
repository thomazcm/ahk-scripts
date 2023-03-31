#IfWinActive, ahk_exe HD-Player.exe
!r::
    Reload
    return

Space::
    prepareShot(0)
    return

+s:: ;Yellow
    prepareShot(74)
    return

!s:: ;Orange
    prepareShot(120)
    return

^s:: ; Max Red
    prepareShot(168)
    return

prepareShot(strength)
{
    BlockInput, Mousemove
    waitForKeys()
    SendMode, Input
    updatePower(strength)
    Sleep, 25
    WinGetActiveStats, Title, Width, Height, X, Y
    x := Width - 285
    MouseMove, %x%, 645
    Sleep, 50
    Send, {Lbutton down}
    Sleep, 50
    MouseMove, 0, % 119+strength, , Relative
    Sleep, 50
    BlockInput, MousemoveOff
}

waitForkeys()
{
    KeyWait, Lalt, U P
    KeyWait, Lshift, U P
    KeyWait, Lctrl, U P 
    return
}

Esc::
    WinGetActiveStats, Title, Width, Height, X, Y
    x := Width - 284
    MouseMove, %x%, 645
    Sleep, 100
    Send, {Lbutton up} 
    return

^q::
    Send, {F7}
    return

f::
    Send, {Lbutton up} 
    return

s::
    changePower(8)
    return

w::
    changePower(-4)
    return

+w::
    changePower(-1)
    return

a::
    SendMode, Event
    MouseMove, -1, 0, 50 , Relative
    KeyWait, %A_ThisHotkey%, U P
    return

^a::
    SendMode, Event
    MouseMove, -4, 0, 50 , Relative
    KeyWait, %A_ThisHotkey%, U P
    return

d::
   SendMode, Event
   MouseMove, 1, 0, 50 , Relative
   KeyWait, %A_ThisHotkey%, U P
   return

^d::
    SendMode, Event
    MouseMove, 4, 0, 50 , Relative
    KeyWait, %A_ThisHotkey%, U P
    return

changePower(change)
{
    MouseMove, 0, %change%,, Relative
    updatePower(change/4)
    return
}

^c::
    Write("", "Golf", "Str")
    return

;======= ini Functions =======
updatePower(change)
{
    ; if !recordingActive()
    ;     return

    if (change > 25 or change = 0)
    {
        Write(1, "Golf", "IsFirst")
        Write(strengthLetter(change), "Golf", "Start")
        Write(0, "Golf", "Power")
    }
    else
    {
        checkFirst(change)
        Read(currentPower, "Golf", "Power")
        power := currentPower + adjustChange(change)
        Write(smartRound(power), "Golf", "Power")
    }
    updateStr()
    return
}

updateStr()
{
    Read(start, "Golf", "Start")
    Read(power, "Golf", "Power")
    
    text=%start%
    if (power != 0)
    {
        if (power > 0)
            text=%text%+
        text=%text%%power%
    }
    Write(text, "Golf", "Str")
}

smartRound(power)
{
    i := 0 
    While, i < 4
    {
        if (power = Round(power, i))
            return Round(power, i)
        i++
    }
    return
}

checkFirst(change)
{
    Read(isFirst, "Golf", "IsFirst")
    if (isFirst)
    {
        multiplier := 0.5
        if (change < 0)
            multiplier := 1
        Write(multiplier, "Golf", "Multiplier")
    }
    Write(0, "Golf", "IsFirst")
    return isFirst
}

adjustChange(change)
{
    Read(multiplier, "Golf", "Multiplier")
    change := change*multiplier
    return change
}


recordingActive()
{
    Read(recording, "Golf", "Recording")
    return recording
}

strengthLetter(strength)
{
    if (strength = 168)
        return "R"
    if (strength = 120)
        return "O"
    if (strength = 74)
        return "Y"
    return "G"
}
