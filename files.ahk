#Include %A_ScriptDir%\base.ahk
#Include %A_ScriptDir%\lib.ahk

vWorkingDir := A_Args[1]
SetWorkingDir, %vWorkingDir%

vStepsFiles := { 1_cleanup:              1
               , 2_createdistdir:        0
               , 3_copytemplatefragdir:  0
               , 4_copylocalfragdir:     0
               , 5_copyfragfilecontent:  0
               , 6_combine:              0
               , 7_cleanupafter:         0 }

FileDelete, files.log

Loop, Files, %vFilesDir%%vTokenDir%, DR 
{
    vTmpPath := A_LoopFilePath . "\" . vTmpDir
    vFinalPath := StrReplace(A_LoopFilePath, vSrc, vDist)
    vFinalPath := StrReplace(vFinalPath, vTokenDir, "")

    if FileExist(vTmpPath) {
        FileRemoveDir, %vTmpPath%, 1
        if ErrorLevel
            vStepsFiles["1_cleanup"] := 0
    }

    if FileExist(vFinalPath) {
        FileRemoveDir, %vFinalPath%, 1
        if ErrorLevel
            vStepsFiles["1_cleanup"] := 0
    }

    if vStepsFiles["1_cleanup"] {
        FileCreateDir, %vFinalPath%
        if !ErrorLevel
            vStepsFiles["2_createdistdir"] := 1
    }

    if vStepsFiles["2_createdistdir"] {
        FileCopyDir, %vTemplateTokenDir%, %vTmpPath%
        if !ErrorLevel
            vStepsFiles["3_copytemplatefragdir"] := 1
    }

    if vStepsFiles["3_copytemplatefragdir"] {
        FileCopy, %A_LoopFilePath%\*%vFileExt%, %vTmpPath%, 1
        if !ErrorLevel
            vStepsFiles["4_copylocalfragdir"] := 1
    }

    if vStepsFiles["4_copylocalfragdir"] {
        FileList := ""
        Loop, Files, %vTmpPath%*%vFileExt%
            FileList .= A_LoopFileName "`n"
        Sort, FileList, N

        Loop, parse, FileList, `n 
        {
            if (A_LoopField = "")
                continue

            FileRead, Contents, %vTmpPath%%A_LoopField%
            if !ErrorLevel
                vStepsFiles["5_copyfragfilecontent"] := 1

            if vStepsFiles["5_copyfragfilecontent"] {
                FileAppend, %Contents%, %vFinalPath%%vFile%
                Contents := ""
            }
        }

        if !ErrorLevel
            vStepsFiles["6_combine"] := 1

        FileRemoveDir, %vTmpPath%, 1
        if !ErrorLevel
            vStepsFiles["7_cleanupafter"] := 1
    }

    LogSteps("files", vFinalPath, vStepsFiles)
}
