$ErrorActionPreference = 'Stop'

$packageName = 'tsedat'
$url = 'http://www.sequencepublishing.website/_files/TheSage_Setup_7-26-2684.exe'
$checksum = '10c17d6255499c47b67db108f84b328373404579b95aeba798468fe6c0e307f8'
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
