$ErrorActionPreference = 'Stop'

$packageName = 'radarr'
$url = 'https://github.com/Radarr/Radarr/releases/download/v0.2.0.870/Radarr.develop.0.2.0.870.installer.exe'
$checksum = 'cade414bb7d1a7a683f02047e30adc74bd72dff3f2c9b1b42e64ec59b5e8edaf'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
  checksum       = $checksum
  checksumType   = 'sha256'
}

Install-ChocolateyPackage @packageArgs

if (Get-Service "$packageName" -ErrorAction SilentlyContinue) {
  $running = Get-Service $packageName
  if ($running.Status -eq "Running") {
    Write-Host 'Service is already running'
  } elseif ($running.Status -eq "Stopped") {
    Start-Service $packageName
  }
}
