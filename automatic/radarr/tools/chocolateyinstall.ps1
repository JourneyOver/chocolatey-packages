$ErrorActionPreference = 'Stop'

$packageName = 'radarr'
$url = 'https://github.com/Radarr/Radarr/releases/download/v0.2.0.846/Radarr.develop.0.2.0.846.installer.exe'
$checksum = 'f0d5bb7278dd2270a1fefab5f3c075ae409558fa0467eeb98157f3b070cfeb70'

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
