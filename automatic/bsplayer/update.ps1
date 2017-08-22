import-module au

$releases = 'http://bsplayer.com/bsplayer-english/download-free.html'

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

  $versionRegEx = 'BS.Player\s+FREE\s+(\d+)\.(\d+)'
  $version = ([regex]::match($download_page.Content, $versionRegEx) -replace ("BS.Player FREE ", ""))

  $ndot = $version.replace(".", "")

  $url = "http://download2.bsplayer.com/download/file/mirror1/bsplayer000.setup.exe" -replace ("000", "$ndot")
  $url32 = $url

  $Latest = @{ URL32 = $url32; Version = $version }
  return $Latest
}

update -ChecksumFor 32