$ErrorActionPreference = 'Stop'

$packageName = 'tinymediamanager'
$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$embedded_path = Get-Item "$toolsDir\*.zip"
$Destination = "$toolsDir\tmm"

$packageArgs = @{
  packageName  = $packageName
  FileFullPath = $embedded_path
  Destination  = $Destination
}

Get-ChocolateyUnzip @packageArgs

$fileLocation = Get-Item "$toolsDir\tmm\*Manager.exe"
$shortcutName = 'tinyMediaManager.lnk'

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$fileLocation" -WorkingDirectory "$toolsDir\tmm"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$fileLocation" -WorkingDirectory "$toolsDir\tmm"

Remove-Item $toolsDir\*.zip -ea 0 -Force
