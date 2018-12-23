Import-Module au
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$repoUser = "DuckieTV"
$repoName = "Nightlies"

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$($Latest.ReleaseUri)>"
      "(?i)(^\s*url(32)?\:\s*).*"         = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*url64:\s*).*"             = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum(32)?\:\s*).*"    = "`${1}$($Latest.Checksum32)"
      "(?i)(^\s*checksum64:\s*).*"        = "`${1}$($Latest.Checksum64)"
      "(?i)(^\s*checksum\s*type\:\s*).*"  = "`${1}$($Latest.ChecksumType32)"
    }
  }
}

function global:au_BeforeUpdate {
  if (!(Test-Path "$PSScriptRoot\tools" -PathType Container)) { New-Item -ItemType Directory "$PSScriptRoot\tools" }
  Copy-Item "$PSScriptRoot\..\duckietv\tools" "$PSScriptRoot" -Force -Recurse
  if (!(Test-Path "$PSScriptRoot\legal" -PathType Container)) { New-Item -ItemType Directory "$PSScriptRoot\legal" }
  Copy-Item "$PSScriptRoot\..\duckietv\legal" "$PSScriptRoot" -Force -Recurse

  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
  $release = Get-LatestGithubReleases $repoUser $repoName $true

  $url32 = $release.latest.Assets | Where-Object { $_ -match 'x32\.zip$' } | Select-Object -First 1
  $url64 = $release.latest.Assets | Where-Object { $_ -match 'x64\.zip$' } | Select-Object -First 1

  $nightly = $release.latest.Version -replace '(....(?!$))', '$1.'
  $build = '-nightly'

  $hashRegEx = ' - (\w+)'
  $hash = ([regex]::match($release.latest.Body, $hashRegEx))
  $hashnew = $hash
  $hashold = Get-Content -Path ".\hashcheck.txt"
  if ($hashold -eq $hashnew) {
    Write-Host 'Changelog hash matches old release'
    return 'ignore'
  }

  Set-Content ".\hashcheck.txt" $hashnew

  $Latest = @{ packageName = 'duckietv'; URL32 = $url32; URL64 = $url64; Version = ($nightly + $build); ReleaseUri = $release.latest.ReleaseUrl }
  return $Latest
}

update -ChecksumFor none
