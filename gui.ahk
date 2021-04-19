;Autoexec:
    #Include %A_ScriptDir%\lib.ahk
    global vScriptName
    global vWorkingDir

    Gui, Font, s10,
    Gui, Add, Text, Section, Select directory: 
    Gui, Add, Button, gDir , ... 
    Gui, Add, Text, w320 r2 vCDir, No directory is selected...
    Gui, Add, Text, ys Section, Select script: 
    Gui, Add, DropDownList, gRunScript w280, template|files|
    Gui, Add, Button, gRun, Run
    Gui, Add, Edit, xm Section w620 h380 vLog

    Gui, Show, w640 h480, Script Logger
    GuiControl, Focus, Close
Return

Dir:
    FileSelectFolder, vWorkingDir, , 3
    if vWorkingDir =
        MsgBox, No directory was selected...
    else {
        GuiControlGet, CDir
        GuiControl, , CDir, %vWorkingDir%
    }
Return

RunScript:
    vScriptName := A_GuiControl
Return

Run:
    Runner()
Return

GuiEscape:
GuiClose:
    Gui, Destroy
    ExitApp
Return

Runner() {
    global vWorkingDir

    if vScriptName {
        Gui, 1:+Disabled
        ClearLogger()

        Logger("[ " . Timer() . " ]" . " script """ . vScriptName . """ running...`n")
        RunWait autohk %A_ScriptDir%\%vScriptName%.ahk %vWorkingDir%
        FileRead, Contents, %vWorkingDir%\%vScriptName%.log 
        Logger(Contents)
        time := Timer()
        Logger("[ " . Timer() . " ]" . " script """ . vScriptName . """ finished`n")

        Gui, 1:-Disabled
    }
    else
        MsgBox Choose script to run
}

Logger(msg) {
    GuiControlGet, Log
    GuiControl, , Log, %Log%%msg%`n
}

ClearLogger() {
    GuiControlGet, Log
    GuiControl, , Log,
}
