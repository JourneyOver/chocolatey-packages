$ErrorActionPreference = 'Stop'

$packageName = 'ssip'
$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  silentArgs     = '"/U:C:\Program Files (x86)\Simple Static IP\Uninstall\uninstall.xml"'
  validExitCodes = @(0)
  File           = "C:\Windows\Simple Static IP\uninstall.exe"
}

Start-Process 'AutoHotkey' "$toolsPath\uninstall.ahk"
Uninstall-ChocolateyPackage @packageArgs
