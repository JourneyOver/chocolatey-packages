# Stop Radarr service before upgrade/uninstall if running
$service = "Radarr"
If (Get-Service "$service" -ErrorAction SilentlyContinue) {
  $running = Get-Service $service
  if ($running.Status -eq "Running") {
    Stop-Service $service
  }
}
