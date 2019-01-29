$ErrorActionPreference = 'Stop'

$packageName = 'gitahead'
$url = ''
$url64 = ''
$checksum = ''
$checksum64 = ''
$checksumType = 'sha256'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url
  url64Bit       = $url64
  silentArgs     = "/S"
  validExitCodes = @(0)
  checksum       = $checksum
  checksum64     = $checksum64
  checksumType   = $checksumType
  checksumType64 = $checksumType
}

Install-ChocolateyPackage @packageArgs
