;======= Functions =======
CheckLineEnd()
{
    Send, +{right}
    Copy()
    Send, {Left}
    if regexmatch(clipboard,"`n")
        return 1
    return 0
}

SendInsert(char, times := 1)
{
    Loop, %times%
    {
        Send, %char%
        if !CheckLineEnd()
            Send, {Delete}
    }
    return
}

CreateLine(Length, Start)
{
    Loop, %Start%
    {
        if CheckLineEnd()
            Send, {Space}
        else
            Send, {Right}
    }
    SendInsert("{NumpadAdd}")
    SendInsert("-", Length+2)
    SendInsert("{NumpadAdd}")
}



SurroundText(symbols)
{
    saveClipboard := clipboard
    Send, {Home}+{Right}
    Copy()
    Send, {Left}
    if (clipboard = ";")
        Send, {Right}
    clipboard := symbols
    Sleep, 100
    Send, ^v{Space}{End}{Space}^v
    Sleep, 100
    clipboard := saveClipboard
}
CreateBigEdges(Length, Start)
{
    Loop, %Start%
    {
        if CheckLineEnd()
            Send, {Space}
        else
            Send, {Right}
    }
    SendInsert("|")
    SendInsert("{Space}", Length+2)
    SendInsert("|")
}
CreateEdges(Length, Start, Line := 0)
{
    Loop, %Start%
        Send, {Right}
    Send,|{Space}

    if (Line = 0)
        Line := Length

    Loop, %Line%
        Send, {Right}
    Loop, % Length-Line
        Send, {Space}
    
    Send, {Space}|
    if !CheckLineEnd()
    {
        Loop, 4
            Send, {Delete}
    }
    return
}

CreateBox(boxSize := 0)
{
    saveClipboard := clipboard
    StartBox(Length, Start)
    Loop, %boxSize%
    {
        Send, {Home}{Up}
        CreateBigEdges(Length, Start)
    }

    Send, {Home}{Home}{Up}
    CreateLine(Length, Start)
    Send, {Home}{Home}
    
    Loop, % 2 + boxSize
        Send, {Down}
    Loop, %boxSize%
    {
        CreateBigEdges(Length, Start)
        Send, {Home}{Home}
        Send, {Down}
    }
    CreateLine(Length, Start)
    clipboard := saveClipboard
    return
}

StartBox(byRef Length, byRef Start)
{
    Length := GetSelectionLength()
    Send, {Right}+{Home}+{Home}
    Start := GetSelectionLength()-Length
    
    Send, {Left}
    CreateEdges(Length, Start)
    Send, {Home}
    return
}

CustomBox()
{
    saveClipboard := clipboard
    Send, +{End}
    StartBox(Length, Start)
    CustomBoxLoop(Length, Start)
    clipboard := saveClipboard
    return
}

CustomBoxLoop(Length, Start)
{
    end := 0
    Loop,
    {
        Input, key , L1 
        if (key = "s")
            Send, {Down}
        else if (key = "w")
            Send, {up}
        else if (key = "e")
        {
            if CheckLineEnd()
            {
                Send, |
                Loop, % Length+2
                    Send, {Space}
                Send, |{Home}
            }
            else
            {
                Send, +{End}
                Line := GetSelectionLength()
                Send, {Right}{Home}{Home}
                CreateEdges(Length, Start, Line)
                Send, {Home}
            }
        }
        else if (key = "q")
        {  
            CreateLine(Length, Start)
            Send, {Home}
            if (end = 1)
                break
            end++
        }
        else if (key = "f")
            break
    }
    return
}