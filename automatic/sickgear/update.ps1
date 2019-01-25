Import-Module au
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$repoUser = "SickGear"
$repoName = "SickGear"

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$($Latest.ReleaseUri)>"
      "(?i)(^\s*url(32)?\:\s*).*"         = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum(32)?\:\s*).*"    = "`${1}$($Latest.Checksum32)"
      "(?i)(^\s*checksum\s*type\:\s*).*"  = "`${1}$($Latest.ChecksumType32)"
    }
  }
}

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
  $release = Get-LatestGithubReleases $repoUser $repoName $false

  $version = $release.latestStable.Version

  $url32 = "https://github.com/SickGear/SickGear/archive/release_$version.zip"

  $Latest = @{ URL32 = $url32; Version = $version; ReleaseUri = $release.latestStable.ReleaseUrl }
  return $Latest
}

update -ChecksumFor none
