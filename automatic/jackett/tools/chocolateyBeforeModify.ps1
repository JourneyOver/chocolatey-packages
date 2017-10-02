# Stop Jackett service before upgrade/uninstall if running
$service = "Jackett"
If (Get-Service "$service" -ErrorAction SilentlyContinue) {
  $running = Get-Service $service
  If ($running.Status -eq "Running") {
    Stop-Service $service
  }
}
