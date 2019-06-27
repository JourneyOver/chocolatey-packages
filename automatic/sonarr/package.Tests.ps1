. "$PSScriptRoot\..\..\scripts\Run-PesterTests.ps1"

$packageName = Split-Path -Leaf $PSScriptRoot

Run-PesterTests `
  -packageName "$packageName" `
  -packagePath "$PSScriptRoot" `
  -streams "stable", "beta" `
  -expectedEmbeddedMatch '^NzbDrone\.(master|develop)\.exe$' `
  -licenseShouldMatch 'GNU GENERAL PUBLIC LICENSE' `
  -expectedDefaultDirectory "${env:ProgramData}\NzbDrone"

# Todo: wait until AdmiringWorm finishes https://github.com/AdmiringWorm/chocolatey-packages/issues/61 and then switch how I test this.
  Run-PesterTests `
    -packageName "$packageName" `
    -packagePath "$PSScriptRoot" `
    -streams "phantom" `
    -expectedEmbeddedMatch '^Sonarr\.phantom-develop\.[\d\.]+\.windows\.exe$' `
    -licenseShouldMatch 'GNU GENERAL PUBLIC LICENSE' `
    -installWithPreRelease `
    -expectedDefaultDirectory "${env:ProgramData}\Sonarr"
