. "$PSScriptRoot\..\..\scripts\Run-PesterTests.ps1"

$packageName = Split-Path -Leaf $PSScriptRoot

Run-PesterTests `
  -packageName "$packageName" `
  -packagePath "$PSScriptRoot" `
  -streams "stable", "beta" `
  -expectedEmbeddedMatch '^NzbDrone\.(master|develop)\.exe$' `
  -licenseShouldMatch 'GNU GENERAL PUBLIC LICENSE' `
  -expectedDefaultDirectory "${env:ProgramData}\NzbDrone"

# Todo: wait until AdmiringWorm finishes https://github.com/AdmiringWorm/chocolatey-packages/issues/61 or I find some way to implement it myself
#  Run-PesterTests `
#    -packageName "$packageName" `
#    -packagePath "$PSScriptRoot" `
#    -streams "phantom" `
#    -expectedEmbeddedMatch '^Sonarr\.phantom-develop\.[\d\.]+\.windows\.exe$' `
#    -licenseShouldMatch 'GNU GENERAL PUBLIC LICENSE' `
#    -expectedDefaultDirectory "${env:ProgramData}\Sonarr"
