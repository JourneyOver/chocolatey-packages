. "$PSScriptRoot\..\..\scripts\Run-PesterTests.ps1"

#Remove hashcheck.txt file to run streams test
$FileName = "$PSScriptRoot\hashcheck.txt"
if (Test-Path $FileName) {
  Remove-Item $FileName
}

Run-PesterTests `
  -packageName "duckietv" `
  -packagePath "$PSScriptRoot" `
  -streams "stable", "nightly" `
  -expectedDefaultDirectory "${env:APPDATA}\DuckieTV" `
  -test32bit
