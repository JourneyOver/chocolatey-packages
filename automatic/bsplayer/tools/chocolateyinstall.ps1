$ErrorActionPreference = 'Stop'

$packageName = 'bsplayer'
$url = 'http://download2.bsplayer.com/download/file/mirror1/bsplayer271.setup.exe'
$checksum = 'C1CB5C485D7F7F20B48AF3F930575FF69234A9AEA09F2C4F47277B3566229F35'
$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url
  silentArgs     = "/S"
  validExitCodes = @(0)
  checksum       = $checksum
  checksumType   = 'sha256'
}

Start-Process 'AutoHotkey' "$toolsPath\install.ahk"
Install-ChocolateyPackage @packageArgs

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