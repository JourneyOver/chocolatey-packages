$ErrorActionPreference = 'Stop'

$packageName = 'compactor'
$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$embedded_path = Get-Item "$toolsDir\*.zip"
$Destination = "$toolsDir"

$packageArgs = @{
  packageName  = $packageName
  FileFullPath = $embedded_path
  Destination  = $Destination
}

Get-ChocolateyUnzip @packageArgs

$fileLocation = Get-Item "$toolsDir\Compactor-*\*.exe"
$shortcutName = 'Compactor.lnk'

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$fileLocation"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$fileLocation"

Remove-Item $toolsDir\*.zip -ea 0 -Force
