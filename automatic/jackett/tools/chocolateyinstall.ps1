$ErrorActionPreference = 'Stop'

$packageName = 'jackett'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$fileLocation = Get-Item "$toolsDir\*.exe"

$registrypaths = @('HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C2A9FC00-AA48-4F17-9A72-62FBCEE2785B}_is1', 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{C2A9FC00-AA48-4F17-9A72-62FBCEE2785B}_is1')
$version = '0.8.321'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  file           = $fileLocation
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}

Foreach ($registry in $registrypaths) {
  if (Test-Path $registry) {
    $installedVersion = (
      Get-ItemProperty -Path $registry -Name 'DisplayVersion'
    ).DisplayVersion
  }
}

if ($installedVersion -match $version) {
  Write-Output $(
    "Jackett $installedVersion is already installed. " +
    "Skipping download and installation."
  )
} else {
  Install-ChocolateyInstallPackage @packageArgs

  # Remove the installers as there is no more need for it
  Remove-Item $toolsDir\*.exe -ea 0 -force
}

if (Get-Service "$packageName" -ErrorAction SilentlyContinue) {
  $running = Get-Service $packageName
  if ($running.Status -eq "Running") {
    Write-Host 'Service is already running'
  } elseif ($running.Status -eq "Stopped") {
    Start-Service $packageName
  }
}
