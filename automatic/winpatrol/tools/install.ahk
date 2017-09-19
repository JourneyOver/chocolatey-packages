#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetControlDelay, -1

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

Winahk = ahk_exe wpsetup.exe

; Welcome Screen
WinWait, %Winahk%
ControlClick, &Next, %Winahk%

sleep, 2000 ;(wait 2 seconds)

; Important Information
WinWait, %Winahk%
ControlClick, &Next, %Winahk%

sleep, 2000 ;(wait 2 seconds)

; Registration Info
WinWait, %Winahk%
ControlClick, &Next, %Winahk%

sleep, 2000 ;(wait 2 seconds)

; Installation Options
WinWait, %Winahk%
ControlClick, &Install, %Winahk%

sleep, 5000 ;(wait 5 seconds)

; Install Successfull
WinWait, %Winahk%
ControlClick, &Finish, %Winahk%