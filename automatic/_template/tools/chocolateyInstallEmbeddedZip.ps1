$ErrorActionPreference = 'Stop'

$packageName = ''

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$embedded_path = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
  Write-Host "Installing 64 bit version"; Get-Item "$toolsDir\*_x64.zip"
} else { Write-Host "Installing 32 bit version"; Get-Item "$toolsDir\*_x32.zip" }

$packageArgs = @{
  packageName  = $packageName
  FileFullPath = $embedded_path
  Destination  = $toolsDir
}

ls $toolsPath\* | ? { $_.PSISContainer } | rm -Recurse -Force #remove older package dirs

Get-ChocolateyUnzip @packageArgs

Remove-Item $toolsDir\*.zip -ea 0 -force
