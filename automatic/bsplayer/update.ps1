import-module au

$releases = 'http://bsplayer.com/bsplayer-english/download-free.html'
$download = 'http://download2.bsplayer.com/download/file/mirror1/bsplayer000.setup.exe'

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

  $versionRegEx = 'BS.Player\s+FREE\s+(\d+)\.(\d+)'
  $version = ([regex]::match($download_page.Content, $versionRegEx) -replace ("BS.Player FREE ", ""))

  $ndot = $version.replace(".", "")

  $url32 = $download -replace ("000", "$ndot")

  $Latest = @{ URL32 = $url32; Version = $version }
  return $Latest
}

update -ChecksumFor 32