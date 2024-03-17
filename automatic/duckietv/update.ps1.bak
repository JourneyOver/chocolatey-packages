Import-Module au
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*[$]url(32)?\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*[$]url64\s*=\s*)('.*')"         = "`$1'$($Latest.URL64)'"
      "(?i)(^\s*[$]checksum(32)?\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*[$]checksum64\s*=\s*)('.*')"    = "`$1'$($Latest.Checksum64)'"
    }
  }
}

function global:au_AfterUpdate($Package) {
  Invoke-VirusTotalScan $Package
}

#function GetStableVersion() {
#  $repoUser = "SchizoDuckie"
#  $repoName = "DuckieTV"
#
#  $release = Get-LatestGithubReleases $repoUser $repoName $false
#
#  $url32 = $release.latestStable.Assets | Where-Object { $_ -match 'x32\.zip$' } | Select-Object -First 1
#  $url64 = $release.latestStable.Assets | Where-Object { $_ -match 'x64\.zip$' } | Select-Object -First 1
#
#  @{
#    PackageName = "duckietv"
#    Version     = $release.latestStable.Version
#    URL32       = $url32
#    URL64       = $url64
#  }
#}

function GetNightlyVersion() {
  $repoUser = "DuckieTV"
  $repoName = "Nightlies"
  $release_page = 'https://github.com/DuckieTV/Nightlies/releases'

  $release = Get-LatestGithubReleases $repoUser $repoName $true
  $getcommithash = Invoke-WebRequest -Uri $release_page -UseBasicParsing

  $url32 = $release.latest.Assets | Where-Object { $_ -match 'x32\.zip$' } | Select-Object -First 1
  $url64 = $release.latest.Assets | Where-Object { $_ -match 'x64\.zip$' } | Select-Object -First 1

  $version = $release.latest.Version -replace '(....(?!$))', '$1.'
  $build = '-nightly'

  $regex = 'commit\/.+$'
  $commithashfull = $getcommithash.links | Where-Object href -Match $regex | Select-Object -First 1 -Expand href
  $hashnew = $commithashfull -replace ('/DuckieTV/Nightlies/commit/', '')
  $hashold = Get-Content -Path "./hashcheck.md"
  if ($hashold -eq $hashnew) {
    Write-Host 'commit hash matches old release'
    return 'ignore'
  }

  Set-Content "./hashcheck.md" $hashnew

  @{
    PackageName = "duckietv"
    Version     = ($version + $build)
    URL32       = $url32
    URL64       = $url64
  }
}

function global:au_GetLatest {
  #$stableStream = GetStableVersion
  $nightlyStream = GetNightlyVersion

  $streams = [ordered] @{
    #stable  = $stableStream
    nightly = $nightlyStream
  }

  return @{ Streams = $streams }
}

update
