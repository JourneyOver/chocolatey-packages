$ErrorActionPreference = 'Stop'

$packageName = 'tvrenamer.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$url32 = 'https://github.com/tvrenamer/tvrenamer/releases/download/v0.8/TVRenamer-0.8-win32.exe'
$url64 = 'https://github.com/tvrenamer/tvrenamer/releases/download/v0.8/TVRenamer-0.8-win64.exe'
$checksum32 = '2D6CC43EF0E694EAFB54DE47450955E62765DC6620FC55B3FBDCBF891F530FB3'
$checksum64 = '81F45AE5B676970003B0A102D614FCA8F0AEE9D0E4D6F4D1E555CCA7E6A1E27C'
$bits = $ENV:PROCESSOR_ARCHITECTURE -replace ("amd", "") -replace ("x86", "32")
$shortcutName = 'TVRenamer.lnk'
$exe = "TVRenamer-$version-win$bits.exe"
$installerPackage = Join-Path $scriptDir $Exe

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url32
  url64Bit       = $url64
  FileFullPath   = $installerPackage
  softwareName   = ''
  checksum       = $checksum32
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir\"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir\"