$ErrorActionPreference = 'Stop'

$packageName = 'bsplayer'
$url = 'http://download11.bsplayer.com/download/file/mirror1/bsplayer273.setup.exe'
$checksum = 'c58f7a0bb02aed16adcbba017e510d08485175b25fb4c03007cf7a606aec7b54'
$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url
  silentArgs     = '/S'
  validExitCodes = @(0)
  checksum       = $checksum
  checksumType   = 'sha256'
}

Start-Process 'AutoHotkey' "$toolsPath\install.ahk"
Install-ChocolateyPackage @packageArgs
