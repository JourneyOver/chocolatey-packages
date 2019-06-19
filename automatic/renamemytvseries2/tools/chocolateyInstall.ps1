$ErrorActionPreference = 'Stop'

$packageName = 'renamemytvseries2'
$url = 'https://www.tweaking4all.com/?wpfb_dl=148'
$checksum = '69a9bfe54ea433617a13773f75ddecfcd41bfd6e0549cc26832cf23125d0e06b'
$checksumType = 'sha256'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url
  silentArgs     = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes = @(0)
  checksum       = $checksum
  checksumType   = $checksumType
}

Install-ChocolateyPackage @packageArgs
