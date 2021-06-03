$ErrorActionPreference = 'Stop'

$packageName = 'duckietv'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$url32 = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-202106022304/DuckieTV-202106022304-windows-x32.zip'
$url64 = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-202106022304/DuckieTV-202106022304-windows-x64.zip'
$checksum32 = '1007fe1daeb149a51a8fe7cc630cf100e905c0781e97a27a10a2f0188ba28cfc'
$checksum64 = 'c3e9ee77105eec1fbea0bbaa837cda1049036f0958ed076a8fd700e83bcd5ddb'
$silentArgs = '/S'
$validExitCodes = @(0)

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP'
  url            = $url32
  url64Bit       = $url64
  checksum       = $checksum32
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$fileLocation = Get-Item "$toolsDir\*.exe"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $fileLocation
  silentArgs     = $silentArgs
  validExitCodes = $validExitCodes
  softwareName   = 'DuckieTV*'
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item $toolsDir\*.zip -ea 0 -Force
Remove-Item $toolsDir\*.exe -ea 0 -Force
