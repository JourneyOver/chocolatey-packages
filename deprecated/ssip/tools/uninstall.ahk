#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Winahk = Simple Static IP Uninstaller

; Uninstall Simple Static IP
WinWait, %Winahk%, &Next >
ControlClick, &Next, %Winahk%

; uninstallation successfull
WinWait, %Winahk%, &Finish
ControlClick, &Finish, %Winahk%

ExitApp
