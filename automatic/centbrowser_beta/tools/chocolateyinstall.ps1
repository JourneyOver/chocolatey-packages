$ErrorActionPreference = 'Stop'

$packageName = 'CentBrowser'
$url32 = 'http://static.centbrowser.com/beta_32/centbrowser_2.8.3.34.exe'
$url64 = 'http://static.centbrowser.com/beta_64/centbrowser_2.8.3.34_x64.exe'
$checksum32 = '4e90868b1ce19922eb28183cd104aba99e7c4cfabd7a40ecf7de37fcf20411a2'
$checksum64 = 'b511f111645f1d1ebb46cd0ce7e4b43c40070a6a40c1ad0ffa55d34c012c2ee8'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url32
  url64Bit       = $url64
  silentArgs     = "--cb-auto-update"
  validExitCodes = @(0)
  checksum       = $checksum32
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}

Install-ChocolateyPackage @packageArgs

# Kill CB process after install if running
$killCB = Get-Process chrome -ErrorAction SilentlyContinue
if ($killCB) {
  # try gracefully first
  $killCB.CloseMainWindow()
  # kill after ten seconds
  Start-Sleep 10
  if (!$killCB.HasExited) {
    $killCB | Stop-Process -Force
  }
}