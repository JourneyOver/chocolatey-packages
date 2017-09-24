$packageName = '-plex'
$BundleName = '.bundle'
$url = ''
$checksum = ''
$LocalAppDataPath = Get-ItemProperty -path "registry::hkey_current_user\software\Plex, Inc.\Plex Media Server" | select-object -expandproperty LocalAppDataPath

if ($LocalAppDataPath -eq $null) {
  Write-Host "Plex Media Server has not been configured yet!" -ForegroundColor red -BackgroundColor blue
  Write-Host "Creating default directories..." -ForegroundColor green -BackgroundColor blue
  New-Item "$env:LOCALAPPDATA\Plex" -Type Directory -force
  New-Item "$env:LOCALAPPDATA\Plex\Plex Media Server" -Type Directory -force
  New-Item "$env:LOCALAPPDATA\Plex\Plex Media Server\Plug-ins" -Type Directory -force
  $LocalAppDataPath = "$env:LOCALAPPDATA\Plex"
}
$UnZipDir = Join-Path -Path $LocalAppDataPath -ChildPath "Plex Media Server\Plug-ins"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $UnZipDir
  fileType      = 'ZIP'
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$strFileName = "$LocalAppDataPath\Plex Media Server\Plug-ins\$BundleName.old"
If (Test-Path $strFileName) {
  Write-Host "Removing previous .old version." -ForegroundColor green -BackgroundColor blue
  Remove-Item "$UnZipDir\$BundleName.old" -recurse
} Else {
  Write-Host ".old version does not exist." -ForegroundColor green -BackgroundColor blue
}

$strFileName = "$LocalAppDataPath\Plex Media Server\Plug-ins\$BundleName"
If (Test-Path $strFileName) {
  Write-Host "Renaming previous version .old." -ForegroundColor green -BackgroundColor blue
  Rename-Item "$UnZipDir\$BundleName" "$BundleName.old"
} Else {
  Write-Host "No previous version exists." -ForegroundColor green -BackgroundColor blue
}

Rename-Item "$UnZipDir\$BundleName-x.x.x" $BundleName
Write-Host "You can ignore Only an exit code of non-zero will fail... messages." -ForegroundColor green -BackgroundColor blue