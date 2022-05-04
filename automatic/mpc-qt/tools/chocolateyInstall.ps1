$ErrorActionPreference = 'Stop'

$packageName = 'mpc-qt'
$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$embedded_path = Get-Item "$toolsDir\*.zip"
$Destination = "$toolsDir\mpc-qt"

$packageArgs = @{
  packageName  = $packageName
  FileFullPath = $embedded_path
  Destination  = $Destination
}

Get-ChocolateyUnzip @packageArgs

$fileLocation = Get-Item "$toolsDir\mpc-qt\*-qt.exe"
$shortcutName = 'MPC-QT.lnk'

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$fileLocation" -WorkingDirectory "$toolsDir\mpc-qt"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$fileLocation" -WorkingDirectory "$toolsDir\mpc-qt"

$files = Get-ChildItem $toolsDir -Include *.exe -Recurse

foreach ($file in $files) {
  if (!($file.Name.Contains("mpc-qt.exe"))) {
    #generate an ignore file
    New-Item "$file.ignore" -type file -Force | Out-Null
  }
}

Remove-Item $toolsDir\*.zip -ea 0 -Force
