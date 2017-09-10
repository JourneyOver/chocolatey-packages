# Original Source: <https://github.com/majkinetor/chocolatey/blob/master/New-Package.ps1>

param($Name, $Type)

<#
.SYNOPSIS
    Create a new package from the template

.DESCRIPTION
    This function creates a new package by using the directory _template which contains desired package basic settings.
#>
function New-Package {
  [CmdletBinding()]
  param(
    #Package name
    [string] $Name,

    #Type of the package
    [ValidateSet('EInstaller', 'MInstaller', 'EPortable', 'ZPortable', 'CExtension', 'FExtension', 'PBundle')]
    [string] $Type,

    #Github repository in the form username/repository
    [string] $GithubRepository
  )

  if ($Name -eq $null) { throw "Name can't be empty" }
  if (Test-Path $Name) { throw "Package with that name already exists" }
  if (!(Test-Path _template)) { throw "Template for the packages not found" }
  $LowerName = $Name.ToLower() -replace ' ', '_'
  Copy-Item _template $LowerName -Recurse

  Move-Item "$LowerName/template.nuspec" "$LowerName/$LowerName.nuspec" -Force;
  ../scripts/Update-IconUrl.ps1 -Name "$LowerName" -GithubRepository $GithubRepository;
  $nuspec = Get-Content -Encoding utf8 "$LowerName/$LowerName.nuspec";

  Write-Verbose 'Fixing nuspec'
  $nuspec = $nuspec -replace '<id>.+', "<id>$LowerName</id>"
  $nuspec = $nuspec -replace '<title>.+', "<title>$Name</title>"
  $nuspec = $nuspec -replace '<iconUrl>.+', "<iconUrl>https://cdn.rawgit.com/$GithubRepository/master/icons/$LowerName.png</iconUrl>"
  $nuspec = $nuspec -replace '<packageSourceUrl>.+', "<packageSourceUrl>https://github.com/$GithubRepository/tree/master/automatic/$LowerName</packageSourceUrl>"
  $nuspec | Out-File -Encoding UTF8 "$LowerName\$LowerName.nuspec"

  switch ($Type) {
    'EInstaller' {
      Write-Verbose 'Using exe installer template'
      Move-Item "$LowerName\tools\chocolateyInstallExe.ps1" "$LowerName\tools\chocolateyinstall.ps1"
      Move-Item "$LowerName\tools\chocolateyUninstallExe.ps1" "$LowerName\tools\chocolateyuninstall.ps1"
    }
    'MInstaller' {
      Write-Verbose 'Using msi installer template'
      Move-Item "$LowerName\tools\chocolateyInstallMsi.ps1" "$LowerName\tools\chocolateyinstall.ps1"
      Move-Item "$LowerName\tools\chocolateyUninstallMsi.ps1" "$LowerName\tools\chocolateyuninstall.ps1"
    }
    'EPortable' {
      Write-Verbose 'Using exe portable template'
      Move-Item "$LowerName\tools\chocolateyExePortInstall.ps1" "$LowerName\tools\chocolateyinstall.ps1"
      Move-Item "$LowerName\tools\chocolateyPortUninstall.ps1" "$LowerName\tools\chocolateyuninstall.ps1"
    }
    'ZPortable' {
      Write-Verbose 'Using zip portable template'
      Move-Item "$LowerName\tools\chocolateyZipPortInstall.ps1" "$LowerName\tools\chocolateyinstall.ps1"
      Move-Item "$LowerName\tools\chocolateyPortUninstall.ps1" "$LowerName\tools\chocolateyuninstall.ps1"
    }
    'CExtension' {
      Write-Verbose 'Using chrome extension template'
      Move-Item "$LowerName\tools\chocolateyInstallChrome.ps1" "$LowerName\tools\chocolateyinstall.ps1"
      Move-Item "$LowerName\tools\chocolateyUninstallChrome.ps1" "$LowerName\tools\chocolateyuninstall.ps1"
    }
    'FExtension' {
      Write-Verbose 'Using firefox extension template'
      Move-Item "$LowerName\tools\chocolateyInstallFF.ps1" "$LowerName\tools\chocolateyinstall.ps1"
      Move-Item "$LowerName\tools\chocolateyUninstallFF.ps1" "$LowerName\tools\chocolateyuninstall.ps1"
    }
    'PBundle' {
      Write-Verbose 'Using firefox extension template'
      Move-Item "$LowerName\tools\chocolateyInstallPB.ps1" "$LowerName\tools\chocolateyinstall.ps1"
      Move-Item "$LowerName\tools\chocolateyUninstallPB.ps1" "$LowerName\tools\chocolateyuninstall.ps1"
    }

    default { throw 'No template given' }
  }
  Remove-Item "$Name\tools\*.ps1" -Exclude chocolateyinstall.ps1, chocolateyuninstall.ps1

  Write-Verbose 'Fixing chocolateyinstall.ps1'
  $installer = Get-Content "$LowerName\tools\chocolateyinstall.ps1"
  $installer -replace "([$]packageName\s*=\s*)('.*')", "`$1'$($LowerName)'" | Set-Content "$LowerName\tools\chocolateyinstall.ps1"
}

New-Package $Name $Type -GithubRepository JourneyOver/chocolatey-packages -Verbose