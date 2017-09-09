$ErrorActionPreference = 'Stop'

$packageName = 'therenamer.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$url32 = 'https://github.com/tvrenamer/tvrenamer/releases/download/v0.8/TVRenamer-0.8-win32.exe'
$url64 = 'https://github.com/tvrenamer/tvrenamer/releases/download/v0.8/TVRenamer-0.8-win64.exe'
$checksum32 = ''
$checksum64 = ''
$shortcutName = 'TheRenamer.lnk'
$exe = '.exe'
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