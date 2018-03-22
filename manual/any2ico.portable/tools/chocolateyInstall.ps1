$ErrorActionPreference = 'Stop'

$packageName = 'any2ico.portable'
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$url = 'http://www.carifred.com/quick_any2ico/Quick_Any2Ico.exe'
$checksum = 'DF0FF4C0613B3781216CC640F6D5F797ABA4DC4E96C9FBA573108CDFA723A4E0'
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
