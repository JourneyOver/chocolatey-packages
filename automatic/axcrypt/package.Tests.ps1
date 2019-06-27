. "$PSScriptRoot\..\..\scripts\Run-PesterTests.ps1"

$packageName = Split-Path -Leaf $PSScriptRoot

Run-PesterTests `
  -packageName "$packageName" `
  -packagePath "$PSScriptRoot" `
  -expectedEmbeddedMatch '^axcrypt-[\d\.]+-setup\.exe$' `
  -licenseShouldMatch 'GNU GENERAL PUBLIC LICENSE'
#  Directory changes every version so disabled until further notice
# -expectedDefaultDirectory "${env:ProgramData}\Package Cache\{4802bd28-932d-4070-99e2-068ea74d872d}"
