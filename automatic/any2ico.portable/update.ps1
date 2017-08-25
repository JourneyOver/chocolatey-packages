import-module au

$releases = 'http://www.carifred.com/quick_any2ico/'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "([$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $versionRegEx = '(\d+)\.(\d+)\.(\d+)\.(\d+)'
  $version = ([regex]::match($download_page.Content, $versionRegEx))

  $Latest = @{version = $version }
  return $Latest
}

update -ChecksumFor 32