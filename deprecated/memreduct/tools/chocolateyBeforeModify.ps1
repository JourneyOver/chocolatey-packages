# Kill memreduct process before upgrade/uninstall if running
$killMR = Get-Process | Where-Object { $_.Path -like "$env:programfiles\Mem Reduct\memreduct.exe" } -ErrorAction SilentlyContinue
if ($killMR) {
  # try gracefully first
  $killMR.CloseMainWindow()
  # kill after five seconds
  Start-Sleep 5
  if (!$killMR.HasExited) {
    $killMR | Stop-Process -Force
  }
}
