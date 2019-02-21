. "$PSScriptRoot\..\..\scripts\Run-PesterTests.ps1"

$packageName = Split-Path -Leaf $PSScriptRoot

Run-PesterTests `
  -packageName "$packageName" `
  -packagePath "$PSScriptRoot" `
  -streams "stable" `
  -expectedDefaultDirectory "${env:APPDATA}\DuckieTV" `
  -test32bit
