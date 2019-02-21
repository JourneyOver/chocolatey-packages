$ErrorActionPreference = 'Stop'

$packageName = 'tsedat'
$url = 'http://www.sequencepublishing.website/_files/TheSage_Setup_7-28-2686.exe'
$checksum = 'c365022420ff82b47c1a90bf64680b8cd6ee23ae5ed28f8ebaa8bf689f9322b8'
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
