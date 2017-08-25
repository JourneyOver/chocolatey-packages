$ErrorActionPreference = 'Stop'

$packageName = 'jackett'

$packageArgs = @{
  packageName    = $packageName
  fileType        = 'exe'
  silentArgs      = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
  File            = "${Env:ProgramFiles(x86)}\Jackett\unins000.exe"
}

Uninstall-ChocolateyPackage @packageArgs

#remove Jackett folder that gets left behind
$fexist = Test-Path $env:ProgramData\Jackett
If ($fexist) {
  write-host "Removing Jackett Folder that's left behind"
  Remove-Item $env:ProgramData\Jackett -Recurse -Force
} else {
  Write-Host Jackett Folder not found
}