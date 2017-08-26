import-module au

$releases = 'https://github.com/DuckieTV/Nightlies/releases'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "([$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
      "([$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
      "([$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "([$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $regex = 'x(\d+).zip$'
  $url = $download_page.links | Where-Object href -match $regex | ForEach-Object href | Select-Object -First 2

  $bversion = $url[0] -split 'nightly-|/' | Select-Object -Last 1 -Skip 1
  $version = $bversion -replace '(....(?!$))', '$1.'
  $build = '-nightly'

  $url32 = 'https://github.com' + $url[0]
  $url64 = 'https://github.com' + $url[1]

  $userAgent = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2;)"
  $32url = "$url32"
  $64url = "$url64"
  $path = "C:\DuckieTV-$bversion-windows-x32.zip"
  $64path = "C:\DuckieTV-$bversion-windows-x64.zip"

  $client = New-Object System.NET.Webclient
  $client.Headers.Add("user-agent", $userAgent)
  $client.DownloadFile( $32url, $path )
  $client.DownloadFile( $64url, $64path )
  $Latest.Checksum32 = Get-FileHash C:\DuckieTV-$bversion-windows-x32.zip | ForEach-Object Hash
  $Latest.Checksum64 = Get-FileHash C:\DuckieTV-$bversion-windows-x64.zip | ForEach-Object Hash
  Remove-Item C:\DuckieTV-$bversion-windows-x32.zip
  Remove-Item C:\DuckieTV-$bversion-windows-x64.zip

  $Latest = @{ PackageName = 'duckietv'; URL32 = $url32; URL64 = $url64; Version = ($version + $build)}
  return $Latest
}

update -ChecksumFor none