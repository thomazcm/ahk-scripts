;======= Config =======
    #NoEnv
    #Persistent
    #InstallKeybdHook
    SetWorkingDir %A_ScriptDir%
    SendMode Input
    SetTitleMatchMode, RegEx
    Menu, Tray, Icon, Resources\Icons\switch-on.ico


;======= Script Files =======
    #Include, TestKeys.ahk
    #Include, TestFunctions.ahk
    #Include, Include
    #Include, Global\GlobalKeys.ahk
    #Include, Global\GlobalFunctions.ahk

;======= Text Editors =======
    #Include, TextEditors\VSCode.ahk
    #Include, TextEditors\Eclipse.ahk
    #Include, TextEditors\OneNote.ahk
    #Include, TextEditors\MicrosoftWord.ahk

;======= Programs =======
    #Include, Other\7zip.ahk

;======= Browsers =======
    #Include, Browsers\Browsers.ahk
    ; #Include, Browsers\BrowserInfo.ahk

;======= Games =======
    #Include, Games\GameFunctions.ahk
    #Include, Games\BlueStacks.ahk
    #Include, Games\EldenRing.ahk
