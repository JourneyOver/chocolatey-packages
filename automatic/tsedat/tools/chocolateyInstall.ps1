$ErrorActionPreference = 'Stop'

$packageName = 'tsedat'
$url = 'https://www.sequencepublishing.com/_files/TheSage_Setup_7-32-2704.exe'
$checksum = 'e4023f16325cdd8a2f9882cbf2858c09c76426b972b3c82b34e8871e593e0f30'
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
