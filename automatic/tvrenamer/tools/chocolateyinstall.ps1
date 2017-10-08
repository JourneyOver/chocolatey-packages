$ErrorActionPreference = 'Stop'

$packageName = 'tvrenamer'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/tvrenamer/tvrenamer/releases/download/v0.8/TVRenamer-0.8-win32.exe'
$url64 = 'https://github.com/tvrenamer/tvrenamer/releases/download/v0.8/TVRenamer-0.8-win64.exe'
$checksum = '2d6cc43ef0e694eafb54de47450955e62765dc6620fc55b3fbdcbf891f530fb3'
$checksum64 = '81f45ae5b676970003b0a102d614fca8f0aee9d0e4d6f4d1e555cca7e6a1e27c'
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
