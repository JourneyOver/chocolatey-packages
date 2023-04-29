Import-Module au
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$Releases = 'https://services.sonarr.tv/v1/download/main/latest?version=3&os=windows&installer=true'

$repoUser = "Sonarr"
$repoName = "Sonarr"

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*url(32)?\:\s*).*"        = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum(32)?\:\s*).*"   = "`${1}$($Latest.Checksum32)"
      "(?i)(^\s*checksum\s*type\:\s*).*" = "`${1}$($Latest.ChecksumType32)"
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

function GetV3StableVersion() {
  $download_page = Get-RedirectedUrl $Releases

  $url = $download_page

  $regex = '(\d+)\.(\d+)\.(\d+)\.(\d+)'
  $version = ([regex]::match($url, $regex))

  @{
    PackageName = "sonarr"
    Version     = $version
    URL32       = $url
  }
}

function GetV3DevVersion() {
  $download_page = Get-RedirectedUrl $Releases.replace('main', 'develop')

  $url = $download_page

  $regex = '(\d+)\.(\d+)\.(\d+)\.(\d+)'
  $version = ([regex]::match($url, $regex))
  $build = "-beta"

  @{
    PackageName = "sonarr"
    Version     = ($version + $build)
    URL32       = $url
  }
}

function GetV4DevVersion() {
  $download_page = Get-RedirectedUrl $Releases.replace('main', 'develop').Replace('version=3', 'version=4')

  $url = $download_page

  $regex = '(\d+)\.(\d+)\.(\d+)\.(\d+)'
  $version = ([regex]::match($url, $regex))
  $build = "-v4beta"

  @{
    PackageName = "sonarr"
    Version     = ($version + $build)
    URL32       = $url
  }
}

function global:au_GetLatest {
  $v3stableStream = GetV3StableVersion
  $v3devStream = GetV3DevVersion
  $v4devStream = GetV4DevVersion

  $streams = [ordered] @{
    V3_Stable = $v3stableStream
    V3_Dev    = $v3devStream
    V4_Dev    = $v4devStream
  }

  return @{ Streams = $streams }
}

update -ChecksumFor none
