. "$PSScriptRoot\..\..\scripts\Run-PesterTests.ps1"

$packageName = Split-Path -Leaf $PSScriptRoot

Run-PesterTests `
  -packageName "$packageName" `
  -packagePath "$PSScriptRoot" `
  -expectedEmbeddedMatch '^GitAhead-win(32|64)-[\d\.]+\.exe$' `
  -licenseShouldMatch 'MIT License' `
  -expectedDefaultDirectory "${env:ProgramFiles}\GitAhead" `
  -test32bit
