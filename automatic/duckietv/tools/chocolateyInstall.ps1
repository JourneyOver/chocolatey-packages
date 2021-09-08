$ErrorActionPreference = 'Stop'

$packageName = 'duckietv'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$url32 = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-202109072304/DuckieTV-202109072304-windows-x32.zip'
$url64 = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-202109072304/DuckieTV-202109072304-windows-x64.zip'
$checksum32 = 'a1bf73b22eedcdeb9d266c67bae9e288c231b67316f6a2b5e7c8bccdc7dece5b'
$checksum64 = 'f3f22969b04d41848bfe5b8d462b16df461f0d6efa2f7375c1ee074aee1f950a'
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
