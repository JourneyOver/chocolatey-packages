$ErrorActionPreference = 'Stop'

$packageName = 'duckietv'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/SchizoDuckie/DuckieTV/releases/download/1.1.4/DuckieTV-1.1.4-windows-x32.zip'
$url64 = 'https://github.com/SchizoDuckie/DuckieTV/releases/download/1.1.4/DuckieTV-1.1.4-windows-x64.zip'
$checksum = 'ECAE9E1DAA64673E72BC06B40908DFCD7DD85D1D0C074350A4049D1E0320060B'
$checksum64 = '6B3289787E24FDAF4519C6C9A810335C058DD592BA25E6F324E3663FFD8037F2'
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