Import-Module au

$releases = 'https://account.axcrypt.net/download/axcrypt-2-setup.exe'

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
  $url32 = $releases
  $dest = "$env:TEMP\axcrypt.exe"

  Invoke-WebRequest -Uri $url32 -OutFile $dest
  $version = (Get-Item $dest).VersionInfo.FileVersion -replace ('\s', '')
  Remove-Item -Force $dest

  $Latest = @{ URL32 = $url32; Version = $version }
  return $Latest
}

update -ChecksumFor none
