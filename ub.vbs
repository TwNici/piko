Set objShell = WScript.CreateObject("WScript.Shell")
appName = "mshta.exe" ' Prozessname für HTA-Anwendungen
appPath = "Cl.hta" ' Vollständiger Pfad zur HTA-Datei

' Endlosschleife zur Überwachung des Programms
Do
    ' Überprüfen, ob das Programm läuft
    Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")
    Set colProcesses = objWMIService.ExecQuery("Select * from Win32_Process Where Name = '" & appName & "'")

    appIsRunning = False

    For Each objProcess in colProcesses
        If InStr(objProcess.CommandLine, "Cl.hta") > 0 Then
            appIsRunning = True
            Exit For
        End If
    Next

    ' Wenn das Programm nicht läuft, starte es neu
    If Not appIsRunning Then
        objShell.Run appPath
    End If

    ' Warte einige Sekunden vor dem nächsten Check
    WScript.Sleep 100 ' Wartezeit in Millisekunden (5000 ms = 5 Sekunden)
Loop
