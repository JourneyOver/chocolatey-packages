# Kill CB process before upgrade/uninstall if running
$killCB = Get-Process | Where-Object {$_.Path -like "$env:LOCALAPPDATA\CentBrowser\Application\chrome.exe"} -ErrorAction SilentlyContinue
if ($killCB) {
  # try gracefully first
  $killCB.CloseMainWindow()
  # kill after ten seconds
  Start-Sleep 10
  if (!$killCB.HasExited) {
    $killCB | Stop-Process -Force
  }
}
