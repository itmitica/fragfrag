#NoEnv
#SingleInstance force

SetWorkingDir %A_ScriptDir%
SetBatchLines, -1
FileEncoding, UTF-8

vToken := "fragfrag"
vCutPrefix := vToken . "("
vCutSuffix := ")"
vSrc := "src"
vDist := "dist"

vFileName := "index"
vFileExt := ".html"
vFile := vFileName . vFileExt

vTokenDir := "_" . vToken
vTemplateDir := "template\"
vTemplateFile := vTemplateDir . vFile
vTemplateTokenDir := vTemplateDir . vTokenDir . "\"
vFilesDir := "files\"
vTmpDir := "~tmp\"
