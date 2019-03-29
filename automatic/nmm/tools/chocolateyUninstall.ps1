$ErrorActionPreference = 'Stop'

$packageName = 'nmm'
$programUninstallEntryName = 'Nexus Mod Manager*'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$registry = Get-UninstallRegistryKey -SoftwareName $programUninstallEntryName
$file = $registry.UninstallString -replace ('/SILENT', '')

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
  file           = $file
}

Start-Process 'AutoHotkey' "$toolsDir\uninstall.ahk"
Uninstall-ChocolateyPackage @packageArgs
