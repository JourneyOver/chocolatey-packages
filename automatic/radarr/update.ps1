Import-Module au

$repoUser = "Radarr"
$repoName = "Radarr"

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
  $release = Get-LatestGithubReleases $repoUser $repoName $true

  $url32 = $release.latest.Assets | Where-Object { $_ -match 'installer\.exe$' } | Select-Object -First 1

  $Latest = @{ URL32 = $url32; Version = $release.latest.Version; ReleaseUri = $release.latest.ReleaseUrl }
  return $Latest
}

update -ChecksumFor none
