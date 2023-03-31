#NoEnv
#Persistent
#InstallKeybdHook
SetWorkingDir C:\Users\Thomaz\Dropbox\Programacao\Scripts
SendMode Input
Menu, Tray, Icon, Resources\Icons\off-button.ico
Pause::
    Run, Main.ahk
    ExitApp
    return