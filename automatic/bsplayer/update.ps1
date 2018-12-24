Import-Module au

$releases = 'http://bsplayer.com/bsplayer-english/download-free.html'
$buildreal = 'http://www.softpedia.com/get/Multimedia/Video/Video-Players/BS-Player.shtml'
$download = 'http://download11.bsplayer.com/download/file/mirror1/bsplayer000.setup.exe'

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
  $build_page = Invoke-WebRequest -Uri $buildreal -UseBasicParsing

  $versionRegEx = 'BS.Player\s+FREE\s+(\d+)\.(\d+)'
  $version = ([regex]::match($download_page.Content, $versionRegEx) -replace ("BS.Player FREE ", ""))

  $buildRegEx = 'Build\s+(\d+)'
  $build = ([regex]::match($build_page.Content, $buildRegEx) -replace ("Build ", "."))

  $ndot = $version.replace(".", "")

  $url32 = $download -replace ("000", "$ndot")

  $Latest = @{ URL32 = $url32; Version = ($version + $build) }
  return $Latest
}

try {
  update -ChecksumFor 32
} catch {
  $ignore = 'Unable to connect to the remote server'
  if ($_ -match $ignore) { Write-Host $ignore; 'ignore' }  else { throw $_ }
}
