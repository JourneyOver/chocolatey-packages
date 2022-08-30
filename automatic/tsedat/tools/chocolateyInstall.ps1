$ErrorActionPreference = 'Stop'

$packageName = 'tsedat'
$url = 'https://sequencepublishing.com/_files/TheSage_Setup_7-42-2714.exe'
$checksum = '6fd59e3e848abf7a8721c20fcd1a007b09c6ee7b8ea9dfbb02cb6e085adc600a'
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
