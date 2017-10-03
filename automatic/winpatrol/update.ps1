Import-Module au

$releases = 'http://www.winpatrol.com/download.html'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "([$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
      "([$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "([$]version\s*=\s*)('.*')"  = "`$1'$($Latest.Version)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $regex = '.exe$'
  $url = $download_page.links | Where-Object href -match $regex | Select-Object -First 2 -expand href

  $versionRegEx = 'V(\d+)\.(\d+).(\d+).(\d+)'
  $version = ([regex]::match($download_page.Content, $versionRegEx) -replace ('V', ''))

  $url32 = $url[0]

  $Latest = @{ URL32 = $url32; version = $version }
  return $Latest
}

update -ChecksumFor 32
