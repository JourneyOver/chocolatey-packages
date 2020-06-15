Import-Module au

$stableReleases = 'https://www.centbrowser.com/'
$betaReleases = 'http://static.centbrowser.com/beta_32/'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*[$]url(32)?\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*[$]url64\s*=\s*)('.*')"         = "`$1'$($Latest.URL64)'"
      "(?i)(^\s*[$]checksum(32)?\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*[$]checksum64\s*=\s*)('.*')"    = "`$1'$($Latest.Checksum64)'"
      "(?i)(^\s*[$]checksumType\s*=\s*)('.*')"  = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function GetStableVersion() {
  $download_page = Invoke-WebRequest -Uri $stableReleases -UseBasicParsing

  $regex = '.exe$'
  $url = $download_page.links | Where-Object href -Match $regex | Select-Object -Last 2 -Expand href
  $version = $url[0] -split 'centbrowser_|.exe' | Select-Object -Last 1 -Skip 1

  @{
    PackageName = "CentBrowser"
    Version     = $version
    URL32       = "http://static.centbrowser.com/installer_32/centbrowser_${version}.exe"
    URL64       = "http://static.centbrowser.com/installer_64/centbrowser_${version}_x64.exe"
  }
}

function GetBetaVersion() {
  $download_page = Invoke-WebRequest -Uri $betaReleases -UseBasicParsing

  $regex = '.exe$'
  $url = $download_page.links | Where-Object href -Match $regex | Select-Object -Last 2 -Expand href
  $version = $url[0] -split 'centbrowser_|.exe' | Select-Object -Last 1 -Skip 1
  $build = "-beta"

  @{
    PackageName = "CentBrowser"
    Version     = ($version + $build)
    URL32       = "http://static.centbrowser.com/beta_32/centbrowser_${version}.exe"
    URL64       = "http://static.centbrowser.com/beta_64/centbrowser_${version}_x64.exe"
  }
}

function global:au_GetLatest {
  $stableStream = GetStableVersion
  $betaStream = GetBetaVersion

  $streams = [ordered] @{
    stable = $stableStream
    beta   = $betaStream
  }

  return @{ Streams = $streams }
}

update
