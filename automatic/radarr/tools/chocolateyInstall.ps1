$ErrorActionPreference = 'Stop'

$packageName = 'radarr'
$url = 'https://github.com/Radarr/Radarr/releases/download/v0.2.0.778/Radarr.develop.0.2.0.778.installer.exe'
$checksum = '890448a07df2125de0681cb7b6f60979200d149405023bbb1fa6bfde4e90e9a9'

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