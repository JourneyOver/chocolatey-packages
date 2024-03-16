Import-Module au
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$repoUser = "loot"
$repoName = "loot"

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$($Latest.ReleaseUri)>"
      "(?i)(^\s*url(32)?\:\s*).*"         = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum(32)?\:\s*).*"    = "`${1}$($Latest.Checksum32)"
      "(?i)(^\s*checksum\s*type\:\s*).*"  = "`${1}$($Latest.ChecksumType32)"
    }

    ".\loot.nuspec"        = @{
      "(\*\s+\[(\w+)\])(.*)" = "`$1($($Latest.Changelog))"
    }
  }
}

function global:au_BeforeUpdate($Package) {
  $licenseData = Get-GithubRepositoryLicense $repoUser $repoName
  $licenseFile = "$PSScriptRoot\legal\LICENSE.txt"
  if (Test-Path $licenseFile) { Remove-Item -Force $licenseFile }

  Invoke-WebRequest -Uri $licenseData.download_url -UseBasicParsing -OutFile "$licenseFile"
  $Latest.LicenseUrl = $licenseData.html_url

  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_AfterUpdate($Package) {
  Update-Metadata -key "licenseUrl" -value $Latest.LicenseUrl
  Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
  $release = Get-LatestGithubReleases $repoUser $repoName $false

  $url32 = $release.latest.Assets | Where-Object { $_ -match 'win64\.exe$' } | Select-Object -First 1
  $cversionlog = $release.latest.Version
  $changelog = "https://loot.readthedocs.io/en/0.0.0/app/changelog.html" -replace ("en\/(\d+)\.(\d+)\.(\d+)\/app", "en/$cversionlog/app")

  $Latest = @{ URL32 = $url32; Version = $release.latest.Version; ReleaseUri = $release.latest.ReleaseUrl; Changelog = $changelog }
  return $Latest
}

update -ChecksumFor none
