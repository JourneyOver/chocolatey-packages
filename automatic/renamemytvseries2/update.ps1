Import-Module au

$releases = 'https://www.tweaking4all.com/home-theatre/rename-my-tv-series-v2/'

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
  $download = Invoke-WebRequest -Uri $releases -UseBasicParsing -Headers @{ "Accept-Encoding" = 'gzip' }

  $versionRegEx = '(\d+).(\d+).(\d+)-Windows-32bit-setup.exe'
  $version = ([regex]::match($download.Content, $versionRegEx) -replace ('-Windows-32bit-setup.exe', ''))

  $url32 = 'https://www.tweaking4all.com/?wpfb_dl=148'

  $Latest = @{ URL32 = $url32; Version = $version }
  return $Latest
}

update -ChecksumFor 32
