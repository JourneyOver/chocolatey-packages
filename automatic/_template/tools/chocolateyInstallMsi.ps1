$ErrorActionPreference = 'Stop'

$packageName = ''
$url = ''
$url64 = ''
$checksum = ''
$checksum64 = ''

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'msi'
  url            = $url
  url64Bit       = $url64
  silentArgs     = '/quiet /qn /norestart'
  validExitCodes = @(0, 3010, 1641)
  checksum       = $checksum
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}

Install-ChocolateyPackage @packageArgs
