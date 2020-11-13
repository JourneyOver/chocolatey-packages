#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Winahk = ahk_exe irsetup.exe

; Welcome Screen
WinWait, %Winahk%, &Help
ControlClick, &Next, %Winahk%

; Installation Folder
WinWait, %Winahk%, C&hange...
ControlClick, &Next, %Winahk%

; Shortcut Folder
WinWait, %Winahk%, Install shortcuts for current user only
sleep, 1000
ControlClick, Button4, %Winahk%
sleep, 1000
ControlClick, &Next, %Winahk%

; Ready To Install
sleep, 4000
WinWait, %Winahk%, &Cancel
ControlClick, &Next, %Winahk%

; Install Successfull
WinWait, %Winahk%, &Finish
ControlClick, &Finish, %Winahk%

ExitApp
