$ErrorActionPreference = 'Stop'

$packageName = 'tsedat'
$url = 'https://sequencepublishing.com/_files/TheSage_Setup_7-48-2802.exe'
$checksum = '12a90860fb15056e33775b2a559c99d7de1a1a8950ca3324115e2a385b1af001'
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
