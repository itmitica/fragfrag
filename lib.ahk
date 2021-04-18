Timer() {
    FormatTime, time, , HH:mm:ss
    return time
}

LogSteps(subject, topic, vSteps) {
    log := "`n  " . subject . " - steps status" . "`n"
    log := log . "========================================`n"
    if topic
    {
        log := log . "  " . topic . "`n"
        log := log . "========================================`n"
    }
    for key, value in vSteps
        log := log . "    " . key . " : " . StrReplace(StrReplace(value, "1", "OK"), "0", "Error") . "`n"
    FileAppend, %log%, %subject%.log
}
