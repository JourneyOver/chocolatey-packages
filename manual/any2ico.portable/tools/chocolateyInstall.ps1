$ErrorActionPreference = 'Stop'

$packageName = 'any2ico.portable'
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$url = 'http://www.carifred.com/quick_any2ico/Quick_Any2Ico.exe'
$checksum = 'c040f95df54b5c8eeaeb359640874a6840760a5742ea1105f4cc2197a2ae283a'
$checksumType = 'sha256'
$shortcutName = 'Quick_Any2Ico.lnk'
$exe = 'Quick_Any2Ico.exe'
$installerPackage = Join-Path $toolsDir $Exe

$packageArgs = @{
  packageName  = $packageName
  fileType     = 'EXE'
  url          = $url
  FileFullPath = $installerPackage
  checksum     = $checksum
  checksumType = $checksumType
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir\"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir\"
