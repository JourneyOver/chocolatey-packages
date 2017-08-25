$ErrorActionPreference = 'Stop'
$packageName = 'any2ico.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$url = 'http://www.carifred.com/quick_any2ico/Quick_Any2Ico.exe'
$checksum = 'C040F95DF54B5C8EEAEB359640874A6840760A5742EA1105F4CC2197A2AE283A'
$shortcutName = 'Quick_Any2Ico.lnk'
$exe = 'Quick_Any2Ico.exe'
$installerPackage = Join-Path $scriptDir $Exe

$packageArgs = @{
  packageName  = $packageName
  fileType     = 'EXE'
  url          = $url
  FileFullPath = $installerPackage
  softwareName = ''
  checksum     = $checksum
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir\"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir\"