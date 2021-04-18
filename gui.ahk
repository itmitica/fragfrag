;Autoexec:
    #Include lib.ahk
    global vScriptName

    Gui, Font, s10,
    Gui, Add, Edit, y+10 w620 h420 vLog
    Gui, Add, Text, Section, Choose script: 
    Gui, Add, DropDownList, ys gRunScript, template|files|
    Gui, Add, Button, gRun ys, Run

    Gui, Show, w640 h480, Script Logger
    GuiControl, Focus, Close
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
    if vScriptName {
        Gui, 1:+Disabled
        ClearLogger()

        Logger("[ " . Timer() . " ]" . " script """ . vScriptName . """ running...`n")
        RunWait autohk %vScriptName%.ahk
        FileRead, Contents, %vScriptName%.log 
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
