# Kill Winpatrol process before upgrade/uninstall if running
$killWP = Get-Process WinPatrolEx -ErrorAction SilentlyContinue
if ($killWP) {
  # try gracefully first
  $killWP.CloseMainWindow()
  # kill after 2 seconds
  Start-Sleep 2
  if (!$killWP.HasExited) {
    $killWP | Stop-Process -Force
  }
}
