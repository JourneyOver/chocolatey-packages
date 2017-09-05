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
    [ValidateSet('Installer', 'Portable', 'EInstaller', 'EPortable')]
    # Future Types -- 'CExtension', 'FExtension', 'PBundle', 'WGadget'
    [string] $Type,

    #Github repository in the form username/repository
    [string] $GithubRepository
  )

  if ($Name -eq $null) { throw "Name can't be empty" }
  if (Test-Path $Name) { throw "Package with that name already exists" }
  if (!(Test-Path _template)) { throw "Template for the packages not found" }
  $LowerName = $Name.ToLower() -replace ' ', '_'
  cp _template $LowerName -Recurse

  Move-Item "$LowerName/template.nuspec" "$LowerName/$LowerName.nuspec" -Force;
  ../scripts/Update-IconUrl.ps1 -Name "$LowerName" -GithubRepository $GithubRepository;
  $nuspec = gc -Encoding utf8 "$LowerName/$LowerName.nuspec";

  Write-Verbose 'Fixing nuspec'
  $nuspec = $nuspec -replace '<id>.+', "<id>$LowerName</id>"
  $nuspec = $nuspec -replace '<title>.+', "<title>$Name</title>"
  $nuspec = $nuspec -replace '<iconUrl>.+', "<iconUrl>https://cdn.rawgit.com/$GithubRepository/master/icons/$LowerName.png</iconUrl>"
  $nuspec = $nuspec -replace '<packageSourceUrl>.+', "<packageSourceUrl>https://github.com/$GithubRepository/tree/master/automatic/$LowerName</packageSourceUrl>"
  $nuspec | Out-File -Encoding UTF8 "$LowerName\$LowerName.nuspec"

  switch ($Type) {
    'Installer' {
      Write-Verbose 'Using installer template'
      mv "$LowerName\tools\chocolateyInstallExe.ps1" "$LowerName\tools\chocolateyinstall.ps1"
    }
    'Portable' {
      Write-Verbose 'Using portable template'
      mv "$LowerName\tools\chocolateyInstallZip.ps1" "$LowerName\tools\chocolateyinstall.ps1"
    }
    'EInstaller' {
      Write-Verbose 'Using embedded installer template'
      mv "$LowerName\tools\chocolateyInstallEmbeddedExe.ps1" "$LowerName\tools\chocolateyinstall.ps1"
    }
    'EPortable' {
      Write-Verbose 'Using embedded portable template'
      mv "$LowerName\tools\chocolateyInstallEmbeddedZip.ps1" "$LowerName\tools\chocolateyinstall.ps1"
    }

    default { throw 'No template given' }
  }
  rm "$Name\tools\*.ps1" -Exclude chocolateyinstall.ps1, chocolateyuninstall.ps1

  Write-Verbose 'Fixing chocolateyinstall.ps1'
  $installer = gc "$LowerName\tools\chocolateyinstall.ps1"
  $installer -replace "([$]packageName\s*=\s*)('.*')", "`$1'$($LowerName)'" | sc "$LowerName\tools\chocolateyinstall.ps1"
}

New-Package $Name $Type -GithubRepository JourneyOver/chocolatey-packages -Verbose
