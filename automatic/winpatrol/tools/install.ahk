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

WinWait, ahk_exe wpsetup.exe, &Next >

WinActivate
IfWinActive
; Welcome Screen
sleep, 2000 ;(wait 2 seconds)
MouseMove 354, 364
Click down
sleep, 50 ;(wait 50 milliseconds)
click up
; Important Information
sleep, 2000 ;(wait 2 seconds)
MouseMove 354, 364
Click down
sleep, 50 ;(wait 50 milliseconds)
click up
; Registration Info
sleep, 2000 ;(wait 2 seconds)
MouseMove 354, 364
Click down
sleep, 50 ;(wait 50 milliseconds)
click up
; Installation Options
sleep, 2000 ;(wait 2 seconds)
MouseMove 354, 364
Click down
sleep, 50 ;(wait 50 milliseconds)
click up
; Install Successfull
sleep, 9000 ;(wait 9 seconds)
MouseMove 343, 362
Click down
sleep, 50 ;(wait 50 milliseconds)
click up
Return