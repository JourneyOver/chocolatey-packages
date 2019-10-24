$ErrorActionPreference = 'Stop'

$packageName = 'tsedat'
$url = 'https://www.sequencepublishing.com/_files/TheSage_Setup_7-28-2700.exe'
$checksum = '7d07abff96ddbe0f046a892852c2022bbbb91d3fc6d6a5f91d70273ff2427517'
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
