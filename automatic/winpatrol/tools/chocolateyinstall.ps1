$ErrorActionPreference = 'Stop'

$packageName = 'winpatrol'
$url = 'https://data.winpatrol.com/downloads/wpsetup.exe'
$checksum = '5EE0B4EA12EBF1BF8EE8CF5DED16F923CD08652EFFA7F7302CB6206E4BE0FBAC'
$checksumType = 'sha256'
$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url
  silentArgs     = ''
  validExitCodes = @(0)
  checksum       = $checksum
  checksumType   = $checksumType
}

Start-Process 'AutoHotkey' "$toolsPath\install.ahk"
Install-ChocolateyPackage @packageArgs
