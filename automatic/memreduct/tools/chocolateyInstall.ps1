$ErrorActionPreference = 'Stop'

$packageName = 'memreduct'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$fileLocation = Get-Item "$toolsDir\*.exe"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  file           = $fileLocation
  silentArgs     = "/S"
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

# Remove the installers as there is no more need for it
Remove-Item $toolsDir\*.exe -ea 0 -Force

# Check to see if memreduct.ini already exists or not.
$fexist = Test-Path "$env:ProgramFiles\Mem Reduct\memreduct.ini"
if ($fexist) {
  Write-Host "memreduct.ini already exists"
} else {
  # Make memreduct.ini file to turn product portable for easier uninstall
  New-Item -Path "$env:ProgramFiles\Mem Reduct" -Name "memreduct.ini" -ItemType File
}

# Run memreduct if not already running
if ( get-process | Where-Object {$_.path -eq "$env:programfiles\Mem Reduct\memreduct.exe"} ) {
  Write-Host "$packageName is already running"
} else {
  Write-Host "Starting $packageName"
  Start-Process "$env:programfiles\Mem Reduct\memreduct.exe"
}
