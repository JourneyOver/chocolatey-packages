Import-Module au

$Releases = 'https://sonarr.tv'
$betaReleases = 'https://download.sonarr.tv/v2/develop/latest/'

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*url(32)?\:\s*).*"        = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum(32)?\:\s*).*"   = "`${1}$($Latest.Checksum32)"
      "(?i)(^\s*checksum\s*type\:\s*).*" = "`${1}$($Latest.ChecksumType32)"
    }
  }

  @{
    ".\tools\chocolateyBeforeModify.ps1" = @{
      "(?i)(^\s*[$]service\s*=\s*)('.*')" = "`$1'$($Latest.Service)'"
    }
  }

  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*[$]service\s*=\s*)('.*')" = "`$1'$($Latest.Service)'"
    }
  }
}

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix

  if ($Latest.Version -like '*phantom*') {
    Copy-Item "$PSScriptRoot\README.phantom.md" "$PSScriptRoot\README.md" -Force
  } else {
    Copy-Item "$PSScriptRoot\README.stable.md" "$PSScriptRoot\README.md" -Force
  }
}

function global:au_AfterUpdate {
  . "$PSScriptRoot/update_helper.ps1"
  if ($Latest.Version -like '*phantom*') {
    addDependency ".\*.nuspec" 'dotnet4.6.1' '4.6.01055.20170308'
  } else {
    removeDependencies ".\*.nuspec"
  }
}

function GetStableVersion() {
  $download_page = Invoke-WebRequest -Uri $Releases -UseBasicParsing

  $regex = '.exe$'
  $url = $download_page.links | Where-Object href -match $regex | ForEach-Object href | Select-Object -First 1

  $dest = "$env:TEMP\Sonarr.exe"

  Invoke-WebRequest -Uri $url -OutFile $dest
  $version = (Get-Item $dest).VersionInfo.FileVersion -replace ('\s', '')
  Remove-Item -force $dest

  @{
    PackageName = "sonarr"
    Service     = "NzbDrone"
    Version     = $version
    URL32       = $url
  }
}

function GetBetaVersion() {
  $download_page = Invoke-WebRequest -Uri $betaReleases -UseBasicParsing

  $regex = '.exe$'
  $url = $download_page.links | Where-Object href -match $regex | ForEach-Object href | Select-Object -First 1 | ForEach-Object { ($betaReleases + $_) }

  $dest_dev = "$env:TEMP\Sonarr_dev.exe"

  Invoke-WebRequest -Uri $url -OutFile $dest_dev
  $version = (Get-Item $dest_dev).VersionInfo.FileVersion -replace ('\s', '')
  $build = "-beta"
  Remove-Item -force $dest_dev

  @{
    PackageName = "sonarr"
    Service     = "NzbDrone"
    Version     = ($version + $build)
    URL32       = $url
  }
}

function GetPhantomVersion() {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $regex = 'installer=true'
  $url = $download_page.links | Where-Object href -match $regex | ForEach-Object href | Select-Object -First 1 | ForEach-Object { ($_) -replace ('//s', 'https://s') } | ForEach-Object { Get-RedirectedUrl ($_) } | ForEach-Object { ($_) -replace ('zip', 'exe') }

  $dest_phant = "$env:TEMP\Sonarr_phantom.exe"

  Invoke-WebRequest -Uri $url -OutFile $dest_phant
  $version = (Get-Item $dest_phant).VersionInfo.FileVersion -replace ('\s', '')
  $build = "-phantom"
  Remove-Item -force $dest_phant

  @{
    PackageName = "sonarr"
    Service     = "Sonarr"
    Version     = ($version + $build)
    URL32       = $url
  }
}

function global:au_GetLatest {
  $stableStream = GetStableVersion
  $betaStream = GetBetaVersion
  $phantomStream = GetPhantomVersion

  $streams = [ordered] @{
    stable  = $stableStream
    beta    = $betaStream
    phantom = $phantomStream
  }

  return @{ Streams = $streams }
}

update -ChecksumFor none
