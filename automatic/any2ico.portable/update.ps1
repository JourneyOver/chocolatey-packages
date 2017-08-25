import-module au

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "([$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
      "([$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $versionRegEx = '(\d+)\.(\d+)\.(\d+)\.(\d+)'
  $version = ([regex]::match($download_page.Content, $versionRegEx))

  $url32 = 'http://www.carifred.com/quick_any2ico/Quick_Any2Ico.exe'

  $Latest = @{ URL32 = $url32; version = $version }
  return $Latest
}

update -ChecksumFor 32