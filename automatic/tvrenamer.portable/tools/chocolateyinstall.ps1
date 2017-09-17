$ErrorActionPreference = 'Stop'

$packageName = 'tvrenamer.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/tvrenamer/tvrenamer/releases/download/0.7.2/TVRenamer-0.7.2-win32.exe'
$url64 = 'https://github.com/tvrenamer/tvrenamer/releases/download/0.7.2/TVRenamer-0.7.2-win64.exe'
$checksum = 'D9D0E9DD0D106173000EDF9D3A00B82FFFD005D6D29A44B527E05366A15ECD7B'
$checksum64 = 'C0AD3E1DD22AF24C588C5432B881A875EBB89189A8EA1ACE16D4CADBCB701DAD'
$bits = Get-ProcessorBits
$shortcutName = 'TVRenamer.lnk'
$exe = "TVRenamer-$env:ChocolateyPackageVersion-win$bits.exe"
$installerPackage = Join-Path $toolsDir $Exe

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  url64Bit       = $url64
  FileFullPath   = $installerPackage
  softwareName   = ''
  checksum       = $checksum
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir\"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir\"
