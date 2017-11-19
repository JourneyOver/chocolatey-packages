$ErrorActionPreference = 'Stop'

$packageName = 'tvrenamer'
$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$fileLocation = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
  Write-Host "Using 64 bit version"; Get-Item "$toolsDir\*-win64.exe"
} else { Write-Host "Using 32 bit version"; Get-Item "$toolsDir\*-win32.exe" }
$shortcutName = 'TVRenamer.lnk'

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$fileLocation" -WorkingDirectory "$toolsDir\"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$fileLocation" -WorkingDirectory "$toolsDir\"

if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
  Remove-Item $toolsDir\*-win32.exe -ea 0 -Force
} else {
  Remove-Item $toolsDir\*-win64.exe -ea 0 -Force
}
