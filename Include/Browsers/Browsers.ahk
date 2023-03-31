;======= All Browsers =======
    #IfWinActive, ahk_exe (opera|chrome|firefox)\.exe
    #Include, Browsers\BrowserFunctions.ahk

    ^b:: ;Bitwarden
        ClickBitwardenExtension()
        return

    !s::
        ResetZoom()
        return
;       
;======= Firefox =======
    #IfWinActive, ahk_exe firefox.exe
    ^+n:: ;New incognito window
        Send, ^+p
        return    
