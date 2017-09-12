$packageName = 'duckietv'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32 = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-201709120130/DuckieTV-201709120130-windows-x32.zip'
$url64 = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-201709120130/DuckieTV-201709120130-windows-x64.zip'
$checksum32 = '8EE3AF7D52A050A73C83BF7299F41CC3FAA440B4BEA47A475068532098065B26'
$checksum64 = '7C73D77D11657BB6C50864122F8D1D494D158FFB463DD8C21E71DD615EB2E21D'
$silentArgs = '/S'
$validExitCodes = @(0)
$bits = $ENV:PROCESSOR_ARCHITECTURE -replace ("amd", "") -replace ("x86", "32")
$fversion = $version.replace('.', '').replace('-nightly', '')
$fileLocation = "$env:ChocolateyInstall\lib\$packageName\tools\DuckieTV-$fversion-windows-x$bits.exe"

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

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $fileLocation
  silentArgs     = $silentArgs
  validExitCodes = $validExitCodes
  softwareName   = 'DuckieTV*'
}

Install-ChocolateyInstallPackage @packageArgs
