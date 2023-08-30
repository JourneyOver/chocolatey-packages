$ErrorActionPreference = 'Stop'

$packageName = 'tsedat'
$url = 'https://sequencepublishing.com/_files/TheSage_Setup_7-50-2804.exe'
$checksum = '363277fa8a14b63a18d66090f34989dd39537bd7a883ca104e72ae258720170f'
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
