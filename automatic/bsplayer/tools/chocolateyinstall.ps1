$ErrorActionPreference = 'Stop'

$packageName = 'bsplayer'
$url = 'http://download2.bsplayer.com/download/file/mirror1/bsplayer271.setup.exe'
$checksum = 'c1cb5c485d7f7f20b48af3f930575ff69234a9aea09f2c4f47277b3566229f35'
$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$registryPath = $('HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\BSPlayerf')
$version = '2.71.1081'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url
  silentArgs     = '/S'
  validExitCodes = @(0)
  checksum       = $checksum
  checksumType   = 'sha256'
}

if (Test-Path $registryPath) {
  $installedVersion = (
    Get-ItemProperty -Path $registryPath -Name 'DisplayVersion'
  ).DisplayVersion
}

if ($installedVersion -eq $version) {
  Write-Output $(
    "bsplayer $installedVersion is already installed. " +
    "Skipping download and installation."
  )
} else {
  Start-Process 'AutoHotkey' "$toolsPath\install.ahk"
  Install-ChocolateyPackage @packageArgs
}

# Kill AutoHotKey process After Install if running
$killAHK = Get-Process AutoHotKey -ErrorAction SilentlyContinue
if ($killAHK) {
  # try gracefully first
  $killAHK.CloseMainWindow()
  # kill after five seconds
  Start-Sleep 5
  if (!$killAHK.HasExited) {
    $killAHK | Stop-Process -Force
  }
}