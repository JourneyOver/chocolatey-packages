$ErrorActionPreference = 'Stop'

$packageName = 'tsedat'
$url32 = 'http://www2.fs.u-bunkyo.ac.jp/~gilner/_files/TheSage_Setup_7-18-2678.exe'
$checksum32 = '7347b717823c95d7ca9b31badef89a4157023a500611d483abf7a44003c5babe'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url32
  silentArgs     = "/S"
  validExitCodes = @(0)
  checksum       = $checksum32
  checksumType   = 'sha256'
}

Install-ChocolateyPackage @packageArgs
