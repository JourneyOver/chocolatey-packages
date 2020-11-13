$ErrorActionPreference = 'Stop'

$packageName = 'namemytvseries.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://www.tweaking4all.com/?wpfb_dl=1'
$checksum = 'F7DA6C752282A144684218815994B1B5A0CE86834B2A9B193900CDB7AF44C10E'
$shortcutName = 'NameMyTVSeries.lnk'
$exe = 'NameMyTVSeries.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP'
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$files = get-childitem $toolsDir -include *.exe -recurse

foreach ($file in $files) {
  if (!($file.Name.Contains("NameMyTVSeries.exe"))) {
    #generate an ignore file
    New-Item "$file.ignore" -type file -force | Out-Null
  }
}

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$ToolsDir\Name-My-TV-Series-v1.8.4-Windows-x86\$exe"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$ToolsDir\Name-My-TV-Series-v1.8.4-Windows-x86\$exe"

Remove-Item $toolsDir\*.zip -ea 0 -Force
