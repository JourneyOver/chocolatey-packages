$ErrorActionPreference = 'Stop'

$packageName = 'tsedat'
$url = 'http://www.sequencepublishing.website/_files/TheSage_Setup_7-24-2682.exe'
$checksum = 'c454062d90389b5232baaa9df51e1a011aa0b64518c2bf7b719a8278ff0731df'
$checksumType = 'sha256'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url
  silentArgs     = '/S'
  validExitCodes = @(0)
  checksum       = $checksum
  checksumType   = $checksumType
}

Install-ChocolateyPackage @packageArgs
