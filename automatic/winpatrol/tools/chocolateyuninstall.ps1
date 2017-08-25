$programUninstallEntryName = "WinPatrol"
$uninstallString = (Get-ItemProperty HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, QuietUninstallString | Where-Object {$_.DisplayName -like "$programUninstallEntryName*"}).QuietUninstallString
# get the uninstall string of the installed Skype version from the registry

$uninstallString = "$uninstallString" -replace '[{]', '`{' # adding escape character to the braces
$uninstallString = "$uninstallString" -replace '[}]', '`} /remove /q' # to work properly with the Invoke-Expression command, add silent arguments

# Kill Winpatrol process before uninstall if running
$killWP = Get-Process WinPatrolEx -ErrorAction SilentlyContinue
if ($killWP) {
  # try gracefully first
  $killWP.CloseMainWindow()
  # kill after 2 seconds
  Start-Sleep 2
  if (!$killWP.HasExited) {
    $killWP | Stop-Process -Force
  }
}

if ($uninstallString -ne "") {
  Invoke-Expression "$uninstallString" # start uninstaller
}