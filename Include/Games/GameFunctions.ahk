BackupSave(game, saveName := "Save", maxSaves := 10)
{
    GameInfo(game, saveName, source, dest, lastSave)
    currentSave := IncrementSave(lastSave, maxSaves)

    finalDest = %dest%%saveName%-%currentSave%

    FileCopyDir, %source%, %finalDest%, 1
    Write(currentSave, game, saveName)
    RegisterSave(game, saveName, lastSave, currentSave)
    return
}

GameInfo(game, saveName, byRef source, byRef dest, byRef lastSave)
{
    Read(source, game, "source")
    Read(dest, game, "dest")
    Read(lastSave, game, saveName)
    return
}

IncrementSave(lastSave, maxSaves, vector := 1)
{
    currentSave := lastSave + vector
    if (currentSave > maxSaves)
        currentSave := 1
    if (currentSave < 1)
        currentSave := maxSaves
    return currentSave
}

RegisterSave(game, saveName, lastSave, currentSave)
{
    Read(dest, game, "dest")

    finalSource = %dest%Last %saveName%-%lastSave%
    finalDest = %dest%Last %saveName%-%currentSave%

    FileMove, %finalSource%, %finalDest%, 1
}

Load(game, saveNumber := 0, saveName := "Save", maxSaves := 10)
{
    loaded := LoadSave(game, saveNumber, saveName, maxSaves)

    Read(lastSave, game, saveName)
    LogText = Loaded %saveName% %loaded% (last %saveName% is %lastSave%)
    Log(LogText)

    saveNumber++
    ConfirmSound(saveNumber, 2)
    return
}

LoadSave(game, saveNumber := 0, saveName := "Save", maxSaves := 10)
{
    GameInfo(game, saveName, source, dest, lastSave)
    saveToLoad := lastSave

    Loop, %saveNumber%
        saveToLoad := IncrementSave(saveToLoad, maxSaves, -1)

    finalSource = %dest%%saveName%-%saveToLoad%
    FileCopyDir, %finalSource%, %source%, 1
    
    return saveToLoad
}