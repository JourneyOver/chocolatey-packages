Import-Module au

$releases = "https://slobs-cdn.streamlabs.com/Streamlabs+Desktop+Setup+0.0.0.exe"
$versioninfo = "https://github.com/stream-labs/desktop/tags"


function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*[$]url(64)?\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
      "(?i)(^\s*[$]checksum(64)?\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
      "(?i)(^\s*[$]checksumType\s*=\s*)('.*')"  = "`$1'$($Latest.ChecksumType64)'"
    }
  }
}

function global:au_AfterUpdate($Package) {
  Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $versioninfo -UseBasicParsing

  $regex = "v\d+\.\d+\.\d+$"
  $versioninfo = $download_page.links | Where-Object href -match $regex | ForEach-Object href | Select-Object -First 1
  $version = $versioninfo -replace("/stream-labs/desktop/releases/tag/v", "")

  $url64 = $releases -replace("0.0.0", "$version")

  $Latest = @{ URL64 = $url64; Version = $version }
  return $Latest
}

update -ChecksumFor 64
