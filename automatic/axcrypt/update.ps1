Import-Module au

$releases = 'https://www.axcrypt.net/download/'
$downloadraw_url = 'https://account.axcrypt.net/download/'
$versionnum = 'https://www.axcrypt.net/cryptographic-hashes-files/'

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*url(32)?\:\s*).*"        = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum(32)?\:\s*).*"   = "`${1}$($Latest.Checksum32)"
      "(?i)(^\s*checksum\s*type\:\s*).*" = "`${1}$($Latest.ChecksumType32)"
    }
  }
}

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $version_page = Invoke-WebRequest -Uri $versionnum -UseBasicParsing

  $regex = 'AxCrypt-(\d+)-Setup.exe'
  $url = ([regex]::match($download_page.Content, $regex))

  $versionRegEx = '(\d+).(\d+).(\d+).(\d+)-Setup.exe'
  $version = ([regex]::match($version_page.Content, $versionRegEx) -replace ('-Setup.exe', ''))

  $url32 = $downloadraw_url + $url

  $Latest = @{ URL32 = $url32; Version = $version }
  return $Latest
}

update -ChecksumFor none
