$ErrorActionPreference = 'Stop'

$packageName = 'tsedat'
$url = 'https://sequencepublishing.com/_files/TheSage_Setup_7-46-2800.exe'
$checksum = 'ba44acdfdad9b77939614f451181aa15f1ad56f85092fa3f4a597ce07eaa62d8'
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
