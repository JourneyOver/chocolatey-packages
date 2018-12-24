$ErrorActionPreference = 'Stop'

$packageName = 'any2ico.portable'
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$url = 'http://www.carifred.com/quick_any2ico/Quick_Any2Ico.exe'
$checksum = 'b0256ed7a727aee6ea05b9dc457cf9c5df639e7171530408ce2652d224bfe68f'
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
