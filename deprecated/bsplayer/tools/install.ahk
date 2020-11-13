#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

loop, 10
{
WinWait, BS.Player ahk_class #32770 ahk_exe codecmanager.exe

WinActivate
IfWinActive
sleep, 5000 ;(wait 5 seconds)
ControlClick, Button1
}
Return

ExitApp
