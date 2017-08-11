import-module au

$releases = 'http://static.centbrowser.com/beta_32/'

# Copy the original file from the centbrowser folder
#  if (!(Test-Path "$PSScriptRoot\tools" -PathType Container)) { New-Item -ItemType Directory "$PSScriptRoot\tools" }
#  Copy-Item -path "$PSScriptRoot\..\centbrowser\tools\*" -Destination "$PSScriptRoot\tools\" -Force -Recurse

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

  $regex = '.exe$'
  $url = $download_page.links | Where-Object href -match $regex | Select-Object -Last 2 -expand href

  $version = $url[0] -split 'centbrowser_|.exe' | Select-Object -Last 1 -Skip 1

  $url32 = $releases + $url[0]
  $url64 = $releases + $url[0] -replace("beta_32", "beta_64")
  $build = "-beta"

  $Latest = @{ PackageName = 'centbrowser'; URL32 = $url32; URL64 = $url64 -replace(".exe", "_x64.exe "); version = ($version + $build) }
  return $Latest
}

update