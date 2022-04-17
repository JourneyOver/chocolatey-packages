Import-Module au
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$Releases = 'https://download.sonarr.tv/v3/main/'
$betaReleases = 'https://download.sonarr.tv/v3/develop/'

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

function GetStableVersion() {
  $download_page = Invoke-WebRequest -Uri $Releases -UseBasicParsing

  $regex = '(\d)\.(\d)\.(\d)\.(\d+)\/$'
  $versioninfo = $download_page.links | Where-Object href -match $regex | ForEach-Object href | Select-Object -Last 1
  $version = $versioninfo -replace('/', '')

  $url = ($Releases + "$version/Sonarr.main.$version.windows.exe")

  @{
    PackageName = "sonarr"
    Version     = $version
    URL32       = $url
  }
}

function GetBetaVersion() {
  $download_page = Invoke-WebRequest -Uri $betaReleases -UseBasicParsing

  $regex = '(\d)\.(\d)\.(\d)\.(\d+)\/$'
  $versioninfo = $download_page.links | Where-Object href -match $regex | ForEach-Object href | Select-Object -Last 1
  $version = $versioninfo -replace('/', '')
  $build = "-beta"

  $url = ($betaReleases + "$version/Sonarr.develop.$version.windows.exe")

  @{
    PackageName = "sonarr"
    Version     = ($version + $build)
    URL32       = $url
  }
}

function global:au_GetLatest {
  $stableStream = GetStableVersion
  $betaStream = GetBetaVersion

  $streams = [ordered] @{
    stable  = $stableStream
    beta    = $betaStream
  }

  return @{ Streams = $streams }
}

update -ChecksumFor none
