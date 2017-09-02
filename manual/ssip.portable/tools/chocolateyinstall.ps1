$ErrorActionPreference = 'Stop'

$packageName = 'ssip.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'http://www.pcwintech.com/files/setups/Simple_Static_IP_v1.3.0.zip'
$checksum = '7496DB174F17DF41D98B4D6FBB496B25FC080D0F3B0286B39A2315CEAFD239F6'
$shortcutName = 'Simple Static IP.lnk'
$exe = 'Simple_Static_IP.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP'
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$ToolsDir\$exe"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$ToolsDir\$exe"