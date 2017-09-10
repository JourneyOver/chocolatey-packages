$ErrorActionPreference = 'Stop'

$packageName = 'radarr'
$url = 'https://github.com/Radarr/Radarr/releases/download/v0.2.0.852/Radarr.develop.0.2.0.852.installer.exe'
$checksum = '1fbc4bfed389cc584c8ae19b8e3397b04ee8a3f5a0aea7d4613412b37a032511'

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
