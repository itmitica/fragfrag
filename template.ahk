#Include %A_ScriptDir%\base.ahk
#Include %A_ScriptDir%\lib.ahk

vWorkingDir := A_Args[1]
SetWorkingDir, %vWorkingDir%

vStepsTemplate := { 1_cleanup:            1
                  , 2_createfragdir:      0
                  , 3_templatefileexists: 0
                  , 4_templatefilecut:    0 }

FileDelete, template.log

if FileExist(vTemplateTokenDir) {
    FileRemoveDir, %vTemplateTokenDir%, 1
    if ErrorLevel
        vStepsTemplate["1_cleanup"] := 0
}

if vStepsTemplate["1_cleanup"] {
    FileCreateDir, %vTemplateTokenDir%
    if !ErrorLevel
        vStepsTemplate["2_createfragdir"] := 1
}

if vStepsTemplate["2_createfragdir"] {
    if FileExist(vTemplateFile)
        vStepsTemplate["3_templatefileexists"] := 1
}

if vStepsTemplate["3_templatefileexists"] {
    Loop, read, %vTemplateFile% 
    {
        if InStr(A_LoopReadLine, vCutPrefix) {
            FileName := vTemplateTokenDir
                . RTrim(StrReplace(A_LoopReadLine, vCutPrefix, ""), vCutSuffix)
                . vFileExt
            FileAppend, , %FileName%
        }
        else
            FileAppend, %A_LoopReadLine%`n, %FileName%
    }

    if !ErrorLevel
        vStepsTemplate["4_templatefilecut"] := 1
}

LogSteps("template", "", vStepsTemplate)
