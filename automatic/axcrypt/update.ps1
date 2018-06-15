Import-Module au

# Parse Softpedia for version number for now until I can figure something better out 
# since 'https://www.axcrypt.net/information/release-notes/' doesn't seem to want to work anymore.
$versionnum = 'http://www.softpedia.com/get/Security/Encrypting/AxCrypt.shtml'

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
  $version_page = Invoke-WebRequest -Uri $versionnum -UseBasicParsing

  $versionRegEx = '(\d+).(\d+).(\d+).(\d+)-Setup.exe'
  $version = ([regex]::match($version_page.Content, $versionRegEx)) -replace ('-Setup.exe', '')

  # Url Never Changes it seems so hardcode it for now.
  $url32 = 'https://account.axcrypt.net/download/axcrypt-2-setup.exe';

  $Latest = @{ URL32 = $url32; Version = $version }
  return $Latest
}

update -ChecksumFor none
