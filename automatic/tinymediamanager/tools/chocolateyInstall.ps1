$ErrorActionPreference = 'Stop'

$packageName = 'tinymediamanager'
$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$embedded_path = Get-Item "$toolsDir\*.zip"
$Destination = "C:\Tools"

$packageArgs = @{
  packageName  = $packageName
  FileFullPath = $embedded_path
  SpecificFolder = 'tinyMediaManager'
  Destination  = $Destination
}

Get-ChocolateyUnzip @packageArgs

$fileLocation = Get-Item "$Destination\tinyMediaManager\*Manager.exe"
$shortcutName = 'tinyMediaManager.lnk'

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$fileLocation" -WorkingDirectory "$Destination"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$fileLocation" -WorkingDirectory "$Destination"

Remove-Item $toolsDir\*.zip -ea 0 -Force
