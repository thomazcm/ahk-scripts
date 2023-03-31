#IfWinActive,  ahk_exe eclipse.exe
;======= Functions =======
    CheckQuote()
    {
        saveClipboard := clipboard
        Send, +{Right}
        Copy()
        Send, {Left}
        if (clipboard = """")
        {
            clipboard := saveClipboard
            return True
        }
        return False
    }
;======= Hotkeys =======
    ^;:: ;End Statement
        Send, {End}
        if CheckQuote()
            Send, {End}{end}{End}
        Send,;
        return


    ^Enter:: ;Skip Line
    ^NumpadEnter:: ;Skip Line
        Send, {End}
        Sleep, 55
        send, {End}{Enter}
        return


    ^e:: ;Concatenate Strings
        Read(reset, "Eclipse", "ResetString")
        if (reset = 0)
        {
            if !CheckQuote()
                Send, +'{Left}
            Send, {Right}{Space}{NumpadAdd}{Space}
            SetTimer, ResetString, 10000
            Write(1, "Eclipse", "ResetString")
            return
        }
        Send, {Space}{NumpadAdd}{Space}+'
        Write(0, "Eclipse", "ResetString")
        return
        ;Timer ResetString
            ResetString:
                Write(0, "Eclipse", "ResetString")
                return
        ;
