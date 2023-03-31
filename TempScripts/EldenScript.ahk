#NoEnv
#Persistent
#InstallKeybdHook
SetWorkingDir %A_ScriptDir%
SendMode Input
Menu, Tray, Icon, Resources\Icons\EldenScript.ico

#Include, IncludeScripts
#Include, Global\GlobalFunctions.ahk
#Include, Games\GameFunctions.ahk

Write(1, "EldenRing", "AutosaveStatus")

if !WinExist("ahk_exe eldenring.exe")
    Run, C:\Program Files (x86)\Steam\steamapps\common\ELDEN RING\Game\eldenring.exe

minutes := 60000
Sleep, 2.5*minutes

while WinExist("ahk_exe eldenring.exe")
{
    timer := 1*minutes
    if WinActive("ahk_exe eldenring.exe")
    {
        BackupSave("EldenRing", "AutoSave", 5)
        timer := 5*minutes
    }
    Sleep, %timer%
}
Write(0, "EldenRing", "AutosaveStatus")
ExitApp

^+p::
    ExitApp