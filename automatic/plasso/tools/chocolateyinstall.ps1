$ErrorActionPreference = 'Stop'
$ServerOS = (Get-WmiObject -class Win32_OperatingSystem).Caption

$packageName = 'plasso'
$url32 = 'https://bitsum.com/files/processlassosetup32.exe'
$url64 = 'https://bitsum.com/files/processlassosetup64.exe'
$checksum32 = 'd219b70ce097bdff9664c4343dcb53dbcecfaba51e75027f95034bf1da0fe7ea'
$checksum64 = '132a96fa063219ea8512482fe7e9f11015244fc59f8c5565f44eebd0b6ab036d'

$surl32 = 'https://bitsum.com/files/server/processlassosetup32.exe'
$surl64 = 'https://bitsum.com/files/server/processlassosetup64.exe'
$schecksum32 = '49d49e130203dc531423fb90821d1286b7e2651a586c931b43d47cbca8b1f7d7'
$schecksum64 = 'ed1d6aa55f55e500af70ae63344421ba08e49520a9cf19587f1151855a4cf8f9'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url32
  url64Bit       = $url64
  silentArgs     = "/S"
  validExitCodes = @(0)
  checksum       = $checksum32
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}

If ($ServerOS -match "Server") {
  write-host Installing Server Version
  $packageArgs.url = $surl32
  $packageArgs.url64Bit = $surl64
  $packageArgs.checksum = $schecksum32
  $packageArgs.checksum64 = $schecksum64
} Else {
  write-host Installing Workstations Version
}

Install-ChocolateyPackage @packageArgs
