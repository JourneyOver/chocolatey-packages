$ErrorActionPreference = 'Stop'

$packageName = 'jackett'
$programUninstallEntryName = "Jackett"

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
    $packageArgs['file'] = "$($app.QuietUninstallString)"
    Uninstall-ChocolateyPackage @packageArgs
  }
}

#remove Jackett folder that gets left behind
$fexist = Test-Path $env:ProgramData\Jackett
If ($fexist) {
  write-host "Removing Jackett Folder that's left behind"
  Remove-Item $env:ProgramData\Jackett -Recurse -Force
} else {
  Write-Host Jackett Folder not found
}