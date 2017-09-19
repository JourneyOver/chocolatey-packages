$ErrorActionPreference = 'Stop'

$packageName = 'duckietv'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/SchizoDuckie/DuckieTV/releases/download/1.1.5/DuckieTV-1.1.5-windows-x32.zip'
$url64 = 'https://github.com/SchizoDuckie/DuckieTV/releases/download/1.1.5/DuckieTV-1.1.5-windows-x64.zip'
$checksum = '9d294285da2dfe73473b7682279d566e092b21dce38350cc64151eeab0bef650'
$checksum64 = '215ec0b23ff40f976ef7a7579654a52eb87b7f181cd7e847376fd5041a210e58'
$silentArgs = '/S'
$validExitCodes = @(0)
$bits = Get-ProcessorBits
$fileLocation = "$env:ChocolateyInstall\lib\$packageName\tools\DuckieTV-$env:ChocolateyPackageVersion-windows-x$bits.exe"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'ZIP'
  url            = $url
  url64Bit       = $url64
  unzipLocation  = $toolsDir
  checksum       = $checksum
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $fileLocation
  silentArgs     = $silentArgs
  validExitCodes = $validExitCodes
  softwareName   = 'DuckieTV*'
}

Install-ChocolateyInstallPackage @packageArgs
