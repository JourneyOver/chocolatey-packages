$ErrorActionPreference = 'Stop'

$packageName = 'mpc-qt'
$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$embedded_path = Get-Item "$toolsDir\*.zip"
$Destination = "$toolsDir\mpc-qt"

Add-Type -Assembly "system.io.compression.filesystem"
[io.compression.zipfile]::ExtractToDirectory($embedded_path, $destination)

$fileLocation = Get-Item "$toolsDir\mpc-qt\*-qt.exe"
$shortcutName = 'MPC-QT.lnk'

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$fileLocation" -WorkingDirectory "$toolsDir\mpc-qt"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$fileLocation" -WorkingDirectory "$toolsDir\mpc-qt"

Remove-Item $toolsDir\*.zip -ea 0 -Force
