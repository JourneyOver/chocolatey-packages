$ErrorActionPreference = 'Stop'

$packageName = 'ssip'
$url = 'http://www.pcwintech.com/files/setups/Simple_Static_IP_v1.3.0_Setup.exe'
$checksum = '00bbe92bb807c6821ae78831dad1fdf8a6e2af0d547f2d01452e6971638fb211'
$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url
  silentArgs     = ''
  validExitCodes = @(0)
  checksum       = $checksum
  checksumType   = 'sha256'
}

Start-Process 'AutoHotkey' "$toolsPath\install.ahk"
Install-ChocolateyPackage @packageArgs
