. "$PSScriptRoot\..\..\scripts\Run-PesterTests.ps1"

Run-PesterTests `
  -packageName "duckietv" `
  -packagePath "$PSScriptRoot" `
  -streams "stable", "nightly" `
  -expectedDefaultDirectory "${env:APPDATA}\DuckieTV" `
  -test32bit
