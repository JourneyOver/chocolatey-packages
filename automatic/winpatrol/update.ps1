Import-Module au

$releases = 'http://www.winpatrol.ceom/download.html'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*[$]url(32)?\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*[$]checksum(32)?\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*[$]checksumType\s*=\s*)('.*')"  = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $regex = '.exe$'
  $url = $download_page.links | Where-Object href -Match $regex | Select-Object -First 2 -Expand href

  $versionRegEx = 'V(\d+)\.(\d+).(\d+).(\d+)'
  $version = ([regex]::match($download_page.Content, $versionRegEx) -replace ('V', ''))

  $url32 = $url[0]

  $Latest = @{ URL32 = $url32; Version = $version }
  return $Latest
}

update -ChecksumFor 32
