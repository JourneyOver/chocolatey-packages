$packageName = '-plex'
$BundleName = '.bundle'
$LocalAppDataPath = Get-ItemProperty -path "registry::hkey_current_user\software\Plex, Inc.\Plex Media Server" | select-object -expandproperty LocalAppDataPath

if ($LocalAppDataPath -eq $null) {
  Write-Host "Plex Media Server has not been configured yet!" -ForegroundColor red -BackgroundColor blue
  $LocalAppDataPath = "$env:LOCALAPPDATA\Plex"
}
$UnZipDir = Join-Path -Path $LocalAppDataPath -ChildPath "Plex Media Server\Plug-ins"

$strFileName = "$LocalAppDataPath\Plex Media Server\Plug-ins\$BundleName.old"
If (Test-Path $strFileName) {
  Write-Host "Removing previous .old version." -ForegroundColor green -BackgroundColor blue
  Remove-Item "$UnZipDir\$BundleName.old" -recurse
} Else {
  Write-Host ".old version does not exist." -ForegroundColor green -BackgroundColor blue
}

$strFileName = "$LocalAppDataPath\Plex Media Server\Plug-ins\$BundleName"
If (Test-Path $strFileName) {
  Write-Host "Removing $packageName" -ForegroundColor green -BackgroundColor blue
  Remove-Item "$UnZipDir\$BundleName" -recurse
} Else {
  Write-Host "ERROR: No previous version exists." -ForegroundColor green -BackgroundColor blue
}
Write-Host "You can ignore Only an exit code of non-zero will fail... messages." -ForegroundColor green -BackgroundColor blue
