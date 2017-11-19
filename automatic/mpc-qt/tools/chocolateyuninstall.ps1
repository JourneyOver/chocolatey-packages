$packageName = 'mpc-qt'
$shortcutName = 'MPC-QT.lnk'

Remove-Item "$env:Public\Desktop\$shortcutName" -Force -ErrorAction 'SilentlyContinue'
Remove-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -Force -ErrorAction 'SilentlyContinue'
