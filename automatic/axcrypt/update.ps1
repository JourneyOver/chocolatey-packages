import-module au

$releases = 'https://www.axcrypt.net/download/'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "([$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
      "([$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $regex = 'https://www.axcrypt.net/downloads/'
  $url = $download_page.links | Where-Object href -match $regex | Select-Object -First 2 -expand href

  $versionRegEx = 'Windows:\s+(\d+)\.(\d+)\.(\d+)'
  $version = ([regex]::match($download_page.Content, $versionRegEx) -replace ("Windows: ", ""))

  $url32 = $url[1]

  $Latest = @{ URL32 = $url32; Version = $version }
  return $Latest
}

update -ChecksumFor 32