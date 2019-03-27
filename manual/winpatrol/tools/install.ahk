#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetControlDelay, -1

Winahk = ahk_exe wpsetup.exe

; Welcome Screen
WinWait, %Winahk%, InstallMate will install
ControlClick, &Next, %Winahk%

; Important Information
WinWait, %Winahk%, Please read this information carefully before continuing.
ControlClick, &Next, %Winahk%

; Registration Info
WinWait, %Winahk%, Registration information
ControlClick, &Next, %Winahk%

; Installation Options
WinWait, %Winahk%, Installation options
ControlClick, &Install, %Winahk%

; Install Successfull
WinWait, %Winahk%, Installation completed
ControlClick, &Finish, %Winahk%

ExitApp
