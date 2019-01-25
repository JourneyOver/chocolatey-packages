$ErrorActionPreference = 'Stop'

$packageName = 'swift-im'
$programUninstallEntryName = 'Swift'
$uninstallString = (Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, UninstallString | Where-Object { $_.DisplayName -like "$programUninstallEntryName*" }).UninstallString
# get the uninstall string of the installed swift-im version from the registry

$uninstallString = "$uninstallString" -replace '[{]', '`{' # adding escape character to the braces
$uninstallString = "$uninstallString" -replace '[}]', '`} /quiet /qn /norestart' # to work properly with the Invoke-Expression command, add silent arguments

if ($uninstallString -ne "") {
  Invoke-Expression "$uninstallString" # start uninstaller
}
