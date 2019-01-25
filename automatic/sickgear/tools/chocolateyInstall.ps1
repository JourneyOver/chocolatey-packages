$packageName = 'sickgear'
$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$embedded_path = Get-Item "$toolsDir\*.zip"
$Destination = "C:\SickGear"

$packageArgs = @{
  packageName  = $packageName
  FileFullPath = $embedded_path
  Destination  = $Destination
}

Get-ChocolateyUnzip @packageArgs

Rename-Item -path "$Destination\SickGear-release_$env:ChocolateyPackageVersion" -newName ‘SickGear’
mkdir "c:\SickGear\data"

$shortcutName = 'SickGear.lnk'

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "C:\python27\pythonw.exe" -WorkingDirectory "C:\python27" -Arguments 'C:\SickGear\SickGear\sickgear.py --datadir "C:\SickGear\data"'
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\$shortcutName" -targetPath "C:\python27\pythonw.exe" -WorkingDirectory "C:\python27" -Arguments 'C:\SickGear\SickGear\sickgear.py --datadir "C:\SickGear\data"'

Remove-Item $toolsDir\*.zip -ea 0 -Force

python -m pip install -U pip setuptools cryptography pyOpenSSL ndg-httpsclient lxml regex scandir
cd "C:\SickGear\SickGear"
pip install -r requirements.txt

invoke-item "$env:Public\Desktop\$shortcutName"
