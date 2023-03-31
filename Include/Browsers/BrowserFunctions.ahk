;======= Auxiliary Functions =======
    ResetZoom()
    {
        CoordModeScreen()
        Send, {LCtrl down}
        Click WU
        Send, {LCtrl up}
        Sleep, 300
        FindImage("reset", x, y)
        if (x != "")
            ClickRet(x, y)
        return
    }

    ResetZoomChrome()
    {
        ;CoordModeScreen()
        Send, {LCtrl down}
        Click WU
        Send, {LCtrl up}
        Sleep, 300
        ClickRet(1675, 95)
    }


;======= Key Functions =======
ClickBitwardenExtension()
{
    if activeWindowContains("Initializr")
    {
        Send, %A_ThisHotkey%
        return
    }
    WinGetActiveStats, t, width, height, X, Y
    x1 := width-220
    
    FindImage("bitwarden",xF,yF, x1, 0, width, 250)
    if (xF = "")
        return
    ClickRet(xF, yF)
}
