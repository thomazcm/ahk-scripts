#IfWinActive, ahk_exe eldenring.exe
; ~!Tab:: ;Activate autosave routine
;     Read(autosaveStatus, "EldenRing", "AutosaveStatus")
;     if (autosaveStatus = 0)
;         Run, EldenScript.ahk
;     return

^u:: ;Ctrl Left Trigger
    CountDown(60)
    return

^i:: ;Ctrl RIght Trigger
    Read(inventorySlot, "EldenRing", "inventorySlot")
    Read(verticalDirection, "EldenRing", "verticalDirection")
    Read(horizontalDirection, "EldenRing", "horizontalDirection")
    Read(verticalDistance, "EldenRing", "verticalDistance")
    Read(horizontalDistance, "EldenRing", "horizontalDistance")

    SendMode, Event
    SetKeyDelay, 0, 25
    Send, {Down down}
    Sleep, 550
    Send, {Down up}
    SendKey("{Down}", 100, inventorySlot)
    Sleep, 100
    Send, {Esc}
    Sleep, 300
    Send, e
    Sleep, 300
    SendKey("{Down}", 100, 3)
    Send, e
    Sleep, 300
    SendKey(verticalDirection, 100, verticalDistance)
    SendKey(horizontalDirection, 100, horizontalDistance)
    Sleep, 100
    Send, e
    Sleep, 100
    Send, {Esc}
    Sleep, 100
    Send, r
    return

!v:: ;Save Soul boost parameters
    InputBox, inventorySlot, Inventory Slot of Gold Pickled Foot
    InputBox, verticalDirection, Up or Down from current Amulet 
    InputBox, horizontalDirection, Left or Right from current Amulet 
    InputBox, verticalDistance, How far %verticalDirection% from current Amulet 
    InputBox, horizontalDistance, How far %horizontalDirection% from current Amulet
    verticalDirection={%verticalDirection%}
    horizontalDirection={%horizontalDirection%}

    Write(inventorySlot, "EldenRing", "inventorySlot")
    Write(verticalDirection, "EldenRing", "verticalDirection")
    Write(horizontalDirection, "EldenRing", "horizontalDirection")
    Write(verticalDistance, "EldenRing", "verticalDistance")
    Write(horizontalDistance, "EldenRing", "horizontalDistance")
    return


SendKey(key, delay, times := 1)
{
    Loop, %times%
    {
        Send, %key%
        Sleep, %delay%
    }
    return
}

;Save/Load
    ^s::
        BackupSave("EldenRing")
        Sleep, 500
        ConfirmSound()
        return

    ; F8::
        Load("EldenRing")
        return

    ; F9::
    ;     Load("EldenRing", 1)
    ;     return

    F10::
        Load("EldenRing", 2)
        return

    F11::
        Load("EldenRing", 0, "Autosave", 5)
        return
;