. "$PSScriptRoot\..\..\scripts\Run-PesterTests.ps1"

Set-Content "./hashcheck.txt" " - 0000000"

$packageName = Split-Path -Leaf $PSScriptRoot

Run-PesterTests `
  -packageName "$packageName" `
  -packagePath "$PSScriptRoot" `
  -streams "stable", "nightly" `
  -expectedDefaultDirectory "${env:APPDATA}\DuckieTV" `
  -test32bit
