$ErrorActionPreference = 'Stop'

$packageName = 'axcrypt'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$embedded_path = Get-Item "$toolsDir\*.exe"

$checksum = 'b20929f8825194e5f9a398ed4be8b3121304ca979f356ce4d4b9bbfcf7d58327'
$registrypaths = @('HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{9E15EF89-8322-C117-CAF2-E79EFAC71395}', 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{9E15EF89-8322-C117-CAF2-E79EFAC71395}')
$version = '2.1.1541.0'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  file           = "$embedded_path"
  silentArgs     = '/S'
  validExitCodes = @(0)
  checksum       = $checksum
  checksumType   = 'sha256'
}

Foreach ($registry in $registrypaths) {
  if (Test-Path $registry) {
    $installedVersion = (
      Get-ItemProperty -Path $registry -Name 'DisplayVersion'
    ).DisplayVersion
  }
}

if ($installedVersion -eq $version) {
  Write-Output $(
    "AxCrypt $installedVersion is already installed. " +
    "Skipping download and installation."
  )
} else {
  Install-ChocolateyInstallPackage @packageArgs

  # Remove the installers as there is no more need for it
  Remove-Item $toolsDir\*.exe -ea 0 -force
}
