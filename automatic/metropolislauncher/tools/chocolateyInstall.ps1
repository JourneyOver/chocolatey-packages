$ErrorActionPreference = 'Stop'

$packageName = 'metropolislauncher'
$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$url = ''
$checksum = ''

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP'
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$fileLocation = Get-Item "$toolsDir\Metropolis_Launcher\*_Launcher.exe"
$shortcutName = 'Metropolis_Launcher.lnk'

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$fileLocation" -WorkingDirectory "$toolsDir\Metropolis_Launcher"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$fileLocation" -WorkingDirectory "$toolsDir\Metropolis_Launcher"

Remove-Item $toolsDir\*.zip -ea 0 -Force
