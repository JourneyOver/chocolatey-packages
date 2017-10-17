$ErrorActionPreference = 'Stop'

$packageName = 'axcrypt'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$fileLocation = Get-Item "$toolsDir\*.exe"

$registrypaths = @('HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{9E15EF89-8322-C117-CAF2-E79EFAC71395}', 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{9E15EF89-8322-C117-CAF2-E79EFAC71395}')
$version = '2.1.1541.0'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  file           = $fileLocation
  silentArgs     = '/S'
  validExitCodes = @(0)
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
