#IfWinActive, ahk_exe WINWORD.EXE

    ^a:: ;Select all
        Send, ^t
        return