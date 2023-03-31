#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

!r::
    Read(recording, "Test", "recording")
    Write(!recording, "Test", "recording")
    return
    return

^e::
    playRecording()
    return

~^Lbutton::
    Read(recording, "Test", "recording")
    if (recording = 0)
        return
    timePassed := A_TimeSincePriorHotkey
    MouseGetPos, xPos, yPos

    value := 1
    i := 0
    While, value != 0
    {
        i++
        key=X%i%
        Read(value, "Test", key)
    }
    saveValues(xPos, yPos, timePassed, i)
    return

playRecording()
{
    i := 0
    Loop
    {
        i++
        getValues(xPos, yPos, waitTime, i)
        if (xPos = 0)
            return
        Sleep, 150
        if (i > 1)
            Sleep, % waitTime-150
        
        Click %xPos% %yPos%
    }
    return
}

saveValues(xPos, yPos, timePassed, i)
{
    xKey=X%i%
    yKey=Y%i%
    waitKey=Wait%i%
    Write(xPos, "Test", xKey)
    Write(yPos, "Test", yKey)
    Write(timePassed, "Test", waitKey)
    return
}

getValues(ByRef xPos, ByRef yPos, ByRef timePassed, i)
{
    xKey=X%i%
    yKey=Y%i%
    waitKey=Wait%i%
    Read(xPos, "Test", xKey)
    Read(yPos, "Test", yKey)
    Read(timePassed, "Test", waitKey)
    return
}