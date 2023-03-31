Log(text)
{
	FileAppend, % A_NowUTC ": " text "`n", Resources\logfile.txt
    return
}
;=======  ini file functions =======
    Read(byRef value, section, key, initialValue := 0, file := "Resources\config.ini")
    {
        IniRead, value, %file%, %section%, %key%
        if (value = "ERROR")
        {
            Write(0, section, key)
            value := initialValue   
        }
        return
    }

    Write(value, section, key, file := "Resources\config.ini")
    {
        IniWrite, %value%, %file%, %section%, %key%
        return
    }

    ReadCoords(byRef x, byRef y, section, key)
    {
        Xkey=X%key%
        Ykey=Y%key%
        Read(x, section, Xkey)
        Read(y, section, Ykey)
        return
    }

    Toggle(byRef returnVar, section, key)
    {
        Read(returnVar, "System", "soundCurrent")
        Write(!returnVar, "System", "soundCurrent")
        return
    }
;
;=======  Streamline code functions =======
    Copy()
    {
        Clipboard := ""
        Send, ^c
        ClipWait, 1
        return
    }

    SendDU(key)
    {
        Send {%key% down}
        Sleep, 25
        Send, {%key% up}
    }

    AutoType(string)
    {
        saveClipboard := clipboard
        clipboard = %string%
        Sleep, 50
        Send, ^v
        Sleep, 50
        clipboard := saveClipboard
        return
    }

    ClickRet(x, y, Button := "L")
    {
        MouseGetPos, xPos, yPos
        Click %x% %y% %Button%
        MouseMove, %xPos%, %yPos%
    }

    multiClickRet(clicks)
    {
        MouseGetPos, xReturn, yReturn
        i := 1
        Loop, % clicks.length()/2
        {
            x := clicks[i]
            y := clicks[i+1]

            Click %x% %y% L
            Sleep, 350
            i+=2
        }
        MouseMove, %xReturn%, %yReturn%
    }
    

    ClickRetDU(x, y, mouseButton := "LButton")
    {
        MouseGetPos, xPos, yPos
        MouseMove, %x%, %y%
        Sleep, 15
        Send, {%mouseButton% down}
        Sleep, 25
        Send, {%mouseButton% up}
        Sleep, 15
        MouseMove, %xPos%, %yPos%
    }

    SendW(key, delay)
    {
        Send, %key%
        Sleep, %delay%
        return
    }

    CoordModeScreen()
    {
        CoordMode, Pixel, Screen
        CoordMode, Mouse, Screen
        return
    }

    ToggleSoundOutput()
    {
        CoordModeScreen()
        MouseGetPos, xPos, yPos
        Click 2397, 1067
        MouseMove, %xPos%, %yPos%
        Sleep, 300
        SendW("{Tab}", 350)
        SendW("{Enter}", 500)
    
        KeyWait, Enter, D L
        Sleep, 100
        Send, {Esc}
        return
    }

    ConfirmSound(times := 1, sound := 1)
    {
        Loop, %times%
            {
                SoundPlay, Resources\Sounds\confirm%sound%.wav
                Sleep, 250
            }
        return
    }

    ErrorSound(times := 1, sound := 1)
    {
        Loop, %times%
            {
                SoundPlay, Resources\Sounds\error%sound%.wav
                Sleep, 250
            }
        return
    }

    CountDown(seconds)
    {
        SoundPlay, Resources\Sounds\ticktock.wav
        Sleep, seconds*1000
        SoundPlay, Resources\Sounds\endCount.wav

    }
;
;======= Get information functions =======
    clipMouseCoords(screenMode := 0)
    {
        if (screenMode = 1)
                CoordModeScreen()
        MouseGetPos, x, y
        clipboard = %x%, %y%
        ;Log(clipboard)
        return
    }

    GetSelectionLength()
    {
        saveClipboard := clipboard
        Copy()
        Length := StrLen(clipboard)
        clipboard := saveClipboard
        return Length
    }

    keyIsDown(key)
    {
        GetKeyState, state, %key%, P
        if (state = "D")
            return True
        return False
    }

    activeWindowContains(name)    
    {
        WinGetActiveTitle, title
        if RegExMatch(title, name)
            return 1
        return 0
    }
    
    isPixelWhite(x , y)
    {
        PixelGetColor, color, %x%, %y%
        clipboard =%color%
        if (color="0xFFFFFF")
            return 1
        else
            return 0
    }

    ; isPixelWhitish(x , y)
    ; {
    ;     PixelGetColor, color, %x%, %y%
    ;     clipboard =%color%
    ;     if RegExMatch("0xF.*", color)
    ;         return 1
    ;     else
    ;         return 0
    ; }
;
;=======  Image functions =======
    FindImage(image, ByRef x, ByRef y , xSearch1 := 0, ySearch1 := 0, xSearch2 := 2560, ySearch2 := 1080)
    {
        i := 1
        Loop, 10
        {
            ImageSearch, x, y, %xSearch1%, %ySearch1%, %xSearch2%, %ySearch2%, Resources\Images\%i%\%image%.png
            if (x != "")
                return 1
            i++
            nextFolder=Resources\Images\%i%
            if !ContainsFile(image, nextFolder)
                return 0
        }
        return 0
    }

    CheckImage(image, xSearch1 := 0, ySearch1 := 0, xSearch2 := 2560, ySearch2 := 1080)
        {
            if FindImage(image, x, y , xSearch1, ySearch1, xSearch2, ySearch2)
                return true
            return false
        }

    HoverImage(image,  xSearch1 := 0, ySearch1 := 0, xSearch2 := 2560, ySearch2 := 1080)
    {
        if !FindImage(image, x, y, xSearch1, ySearch1, xSearch2, ySearch2)
            return
        MouseMove, %x%, %y%
        return
    }

    ClickImage(image, xSearch1 := 0, ySearch1 := 0, xSearch2 := 2560, ySearch2 := 1080)
    {
        if !FindImage(image, x, y, xSearch1, ySearch1, xSearch2, ySearch2)
            return 0
        Click %x% %y%
        return 1
    }

    ClickRetImage(image, xSearch1 := 0, ySearch1 := 0, xSearch2 := 2560, ySearch2 := 1080)
    {
        if !FindImage(image, x, y, xSearch1, ySearch1, xSearch2, ySearch2)
        if (x = "")
            return 0
        ClickRet(x, y)
        return 1
    }
    
    ContainsFile(fileName, directory)
    {
        files := list_files(directory)
        if RegExMatch(files, fileName)
            return 1
        return 0
    }   

    List_files(directory)
    {
        files =
        Loop %directory%\*.*
        {
            files = %files% %A_LoopFileName%
        }
        return files
    }
;
;=======  Key Functions =======
CloseTaskBarWindow()
{
    WinGetActiveStats, title1, W, H, X, Y
    Sleep, 50
    Click
    Sleep, 150
    WinGetActiveStats, title2, W, H, X, Y
    WinGet, state, MinMax, %title1%
    if !(title1 != title2)
        return
    if (state = -1)
    {
        Click
        Sleep, 150
    }
    Send, !{F4}
}

MoveMouseThirdScreen()
{
    CoordModeScreen()
    if mouseOnTop()
        MouseMove, 889, 545
    else
        MouseMove, -652, -58
    return
}
;mouseOnTop
    mouseOnTop()
    {
        CoordModeScreen()
        MouseGetPos, xPos, yPos
        if (xPos < 0)
            return 1
        return 0
    }
;
