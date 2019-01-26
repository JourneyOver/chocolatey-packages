$ErrorActionPreference = 'Stop'

$packageName = 'metropolislauncher'
$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$url = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-201901200130/DuckieTV-201901200130-windows-x32.zip'
$checksum = '7414179c2824e34b0fb101f58e09a69728a0f3546eaaf81e4fe21592a343a962'

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
