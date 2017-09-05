http://win7gadgets.com/media/g/g1345/virus-blue-wifi.gadget

$ErrorActionPreference = 'Stop'
$packageName      = '-gadget' 
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = ''
$checksum         = ''
$installerPackage = Join-Path $ToolsDir ".gadget"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  FileFullPath  = $installerPackage
  checksum      = $checksum
  checksumType  = 'sha256'
}

Get-ChocolateyWebFile @packageArgs



