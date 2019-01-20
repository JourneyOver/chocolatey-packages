Import-Module au

$releases = 'https://www.axcrypt.net/downloads/4519/'
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
  $version_page = Invoke-WebRequest -Uri $versionnum -UseBasicParsing -Headers @{ "Accept-Encoding" = 'gzip' }

  $versionRegEx = '(\d+).(\d+).(\d+).(\d+)-Setup.exe'
  $version = ([regex]::match($version_page.Content, $versionRegEx) -replace ('-Setup.exe', ''))

  $url32 = Get-RedirectedUrl $releases

  $Latest = @{ URL32 = $url32; Version = $version }
  return $Latest
}

update -ChecksumFor none
