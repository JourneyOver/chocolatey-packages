. "$PSScriptRoot\..\..\scripts\Run-PesterTests.ps1"

$packageName = Split-Path -Leaf $PSScriptRoot

Run-PesterTests `
  -packageName "$packageName" `
  -packagePath "$PSScriptRoot" `
  -expectedEmbeddedMatch '^nuclear\.Setup\.[\d\.]+\.exe$' `
  -licenseShouldMatch 'GNU GENERAL PUBLIC LICENSE' `
  -expectedDefaultDirectory "${env:LOCALAPPDATA}\Programs\nuclear"
