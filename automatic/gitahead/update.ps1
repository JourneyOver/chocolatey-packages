Import-Module au
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$repoUser = "gitahead"
$repoName = "gitahead"

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$($Latest.ReleaseUri)>"
      "(?i)(^\s*url(32)?\:\s*).*"         = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*url64?\:\s*).*"           = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum(32)?\:\s*).*"    = "`${1}$($Latest.Checksum32)"
      "(?i)(^\s*checksum64?\:\s*).*"      = "`${1}$($Latest.Checksum64)"
      "(?i)(^\s*checksum\s*type\:\s*).*"  = "`${1}$($Latest.ChecksumType32)"
    }
  }
}

function global:au_BeforeUpdate($Package) {
  $licenseFile = "$PSScriptRoot\legal\LICENSE.txt"
  if (Test-Path $licenseFile) { rm -Force $licenseFile }

  iwr -UseBasicParsing -Uri $($Package.nuspecXml.package.metadata.licenseUrl -replace 'blob', 'raw') -OutFile $licenseFile
  if (!(Get-ValidOpenSourceLicense -path "$licenseFile")) {
    throw "Unknown license download. Please verify it still contains distribution rights."
  }

  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
  $release = Get-LatestGithubReleases $repoUser $repoName $false

  $url32 = $release.latestStable.Assets | Where-Object { $_ -match 'win32-(\d+)\.(\d+)\.(\d+)\.exe$' } | Select-Object -First 1
  $url64 = $release.latestStable.Assets | Where-Object { $_ -match 'win64-(\d+)\.(\d+)\.(\d+)\.exe$' } | Select-Object -First 1

  $Latest = @{ URL32 = $url32; URL64 = $url64; Version = $release.latestStable.Version; ReleaseUri = $release.latestStable.ReleaseUrl }
  return $Latest
}

update -ChecksumFor none
