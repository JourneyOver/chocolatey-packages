# Kill BSplayer process before uninstall if running
$killBS = Get-Process bsplayer -ErrorAction SilentlyContinue
if ($killBS) {
  # try gracefully first
  $killBS.CloseMainWindow()
  # kill after ten seconds
  Start-Sleep 10
  if (!$killBS.HasExited) {
    $killBS | Stop-Process -Force
  }
}