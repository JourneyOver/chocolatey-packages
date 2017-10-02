#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Loop, %0%  ; For each parameter:
  {
    param := %A_Index%  ; Fetch the contents of the variable whose name is contained in A_Index.
    params .= A_Space . param
  }
ShellExecute := A_IsUnicode ? "shell32\ShellExecute":"shell32\ShellExecuteA"

if not A_IsAdmin
{
  If A_IsCompiled
    DllCall(ShellExecute, uint, 0, str, "RunAs", str, A_ScriptFullPath, str, params , str, A_WorkingDir, int, 1)
  Else
    DllCall(ShellExecute, uint, 0, str, "RunAs", str, A_AhkPath, str, """" . A_ScriptFullPath . """" . A_Space . params, str, A_WorkingDir, int, 1)
  ExitApp
}


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
