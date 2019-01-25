$packageName = 'sickgear'
$shortcutName = 'SickGear.lnk'

Remove-Item "$env:Public\Desktop\$shortcutName" -Force -ErrorAction 'SilentlyContinue'
Remove-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\$shortcutName" -Force -ErrorAction 'SilentlyContinue'
Remove-Item -r "C:\SickGear*" -ea 0 -Force
