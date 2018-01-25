$ErrorActionPreference = 'Stop'

$packageName = 'tsedat'
$url = 'http://www2.fs.u-bunkyo.ac.jp/~gilner/_files/TheSage_Setup_7-21-2680.exe'
$checksum = '94981e73465653f93749a65236da1ddabccdee100f1626c2071137d1d212f2b7'
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
