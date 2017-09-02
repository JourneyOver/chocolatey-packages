import-module au

$releases = 'https://www.axcrypt.net/download/'
$downloadraw_url = 'https://account.axcrypt.net/download/'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "([$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
      "([$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "([$]version\s*=\s*)('.*')" = "`$1'$($Latest.Version)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $regex = 'AxCrypt-(\d+)-Setup.exe'
  $url = ([regex]::match($download_page.Content, $regex))

  $versionRegEx = 'Windows:\s+(\d+)\.(\d+)\.(\d+)'
  $version = ([regex]::match($download_page.Content, $versionRegEx) -replace ("Windows: ", ""))

  $url32 = $downloadraw_url + $url

  $Latest = @{ URL32 = $url32; Version = $version }
  return $Latest
}

update -ChecksumFor 32