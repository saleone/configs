Dim WinScriptHost
Set WinScriptHost = CreateObject("WScript.Shell")
strPath = Wscript.ScriptFullName
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.GetFile(strPath)
strFolder = objFSO.GetParentFolderName(objFile)
WinScriptHost.Run Chr(34) & strFolder + "\run_wsl.bat" & Chr(34), 0
Set WinScriptHost = Nothing
