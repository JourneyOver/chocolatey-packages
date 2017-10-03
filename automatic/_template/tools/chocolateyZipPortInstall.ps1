$ErrorActionPreference = 'Stop'

$packageName = ''
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = ''
$url64 = ''
$checksum = ''
$checksum64 = ''
$shortcutName = '.lnk'
$exe = '.exe'

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

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir\"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir\"
