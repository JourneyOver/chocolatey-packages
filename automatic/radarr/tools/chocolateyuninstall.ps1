$ErrorActionPreference = 'Stop'

$packageName = 'radarr'
$programUninstallEntryName = "Radarr"

$PATHS = @("HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall",
  "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall")

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}

ForEach ($path in $PATHS) {
  $installed = Get-ChildItem -Path $path |
    ForEach-Object { Get-ItemProperty $_.PSPath } |
    Where-Object { $_.DisplayName -match $programUninstallEntryName } |
    Select-Object -Property DisplayName, DisplayVersion, UninstallString, QuietUninstallString

  ForEach ($app in $installed) {
    $packageArgs['file'] = "$($app.UninstallString)"
    Uninstall-ChocolateyPackage @packageArgs
  }
}

#remove Radarr folder that gets left behind
$fexist = Test-Path $env:ProgramData\Radarr
If ($fexist) {
  Write-Host "Removing Radarr Folder that's left behind"
  Remove-Item $env:ProgramData\Radarr -Recurse -Force
} else {
  Write-Host Radarr Folder not found
}