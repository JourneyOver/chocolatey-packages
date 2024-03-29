﻿# AU Packages Template: https://github.com/majkinetor/au-packages-template

param([string[]] $Name, [string] $ForcedPackages, [string] $Root = "$PSScriptRoot\automatic")

if (Test-Path $PSScriptRoot/update_vars.ps1) { . $PSScriptRoot/update_vars.ps1 }

$Options = [ordered]@{
  WhatIf                    = $au_WhatIf                              #Whatif all packages
  Force                     = $false                                  #Force all packages
  Timeout                   = 100                                     #Connection timeout in seconds
  UpdateTimeout             = 1200                                    #Update timeout in seconds
  Threads                   = 10                                      #Number of background jobs to use
  Push                      = $Env:au_Push -eq 'true'                 #Push to chocolatey
  PushAll                   = $true                                   #Allow to push multiple packages at once
  PluginPath                = ''                                      #Path to user plugins
  IgnoreOn                  = @(                                      #Error message parts to set the package ignore status
    'Could not create SSL/TLS secure channel'
    'Could not establish trust relationship'
    'The operation has timed out'
    'Internal Server Error'
    'Service Temporarily Unavailable'
    'The connection was closed unexpectedly.'
    'already exists on a Simple OData Server'             # https://github.com/chocolatey/chocolatey.org/issues/613
    'already exists on the repository'             # https://github.com/chocolatey/chocolatey.org/issues/613
    'and no approved stable releases'             #  ignores when package is brand new and hasn't been approved yet and a new release happens.
    'Conflict'
    'package version already exists'
  )

  RepeatOn                  = @(                                      #Error message parts on which to repeat package updater
    'Could not create SSL/TLS secure channel'             # https://github.com/chocolatey/chocolatey-coreteampackages/issues/718
    'Could not establish trust relationship'              # -||-
    'Unable to connect'
    'The remote name could not be resolved'
    'Choco pack failed with exit code 1'                  # https://github.com/chocolatey/chocolatey-coreteampackages/issues/721
    'The operation has timed out'
    'Internal Server Error'
    'An exception occurred during a WebClient request'
    'remote session failed with an unexpected state'
    'Job returned no object, Vector smash ?'
    'The connection was closed unexpectedly.'
    'already exists on a Simple OData Server'             # https://github.com/chocolatey/chocolatey.org/issues/613
    'already exists on the repository'             # https://github.com/chocolatey/chocolatey.org/issues/613
    'Conflict'
    'Origin Time-out'
  )
  RepeatSleep               = 60                                    #How much to sleep between repeats in seconds, by default 0
  RepeatCount               = 2                                      #How many times to repeat on errors, by default 1

  #NoCheckChocoVersion = $true                            #Turn on this switch for all packages

  Report                    = @{
    Type   = 'markdown'                                   #Report type: markdown or text
    Path   = "$PSScriptRoot\Update-AUPackages.md"         #Path where to save the report
    Params = @{                                          #Report parameters:
      Github_UserRepo = $Env:github_user_repo         #  Markdown: shows user info in upper right corner
      NoAppVeyor      = $true                            #  Markdown: do not show AppVeyor build shield
      UserMessage     = "[Build Details]($env:GH_ACTIONS_BUILD_URL) | [Ignored](#ignored) | [History](#update-history) | [Releases](https://github.com/$Env:github_user_repo/tags)"       #  Markdown, Text: Custom user message to show
      NoIcons         = $false                            #  Markdown: don't show icon
      IconSize        = 32                                #  Markdown: icon size
      Title           = ''                                #  Markdown, Text: TItle of the report, by default 'Update-AUPackages'
    }
  }

  History                   = @{
    Lines           = 30                                         #Number of lines to show
    Github_UserRepo = $Env:github_user_repo             #User repo to be link to commits
    Path            = "$PSScriptRoot\Update-History.md"            #Path where to save history
  }

  Gist                      = @{
    Id     = $Env:gist_id                               #Your gist id; leave empty for new private or anonymous gist
    ApiKey = $Env:github_api_key                        #Your github api key - if empty anoymous gist is created
    Path   = "$PSScriptRoot\Update-AUPackages.md", "$PSScriptRoot\Update-History.md"       #List of files to add to the gist
  }

  Git                       = @{
    User     = ''                                       #Git username, leave empty if github api key is used
    Password = $Env:github_api_key                      #Password if username is not empty, otherwise api key
  }

  GitReleases               = @{
    ApiToken    = $Env:github_api_key                   #Your github api key
    ReleaseType = 'date'                             #Either 1 release per date, or 1 release per package
  }

  RunInfo                   = @{
    Exclude = 'password', 'apikey', 'UserName', 'To', 'ApiToken', 'webhookurl'          #Option keys which contain those words will be removed
    Path    = "$PSScriptRoot\update_info.xml"           #Path where to save the run info
  }

  Mail                      = if ($Env:mail_user) {
    @{
      To          = $Env:mail_user
      Server      = $Env:mail_server
      UserName    = $Env:mail_user
      Password    = $Env:mail_pass
      Port        = $Env:mail_port
      EnableSsl   = $Env:mail_enablessl -eq 'true'
      Attachment  = "$PSScriptRoot\update_info.xml"
      UserMessage = "Update status: https://gist.github.com/JourneyOver/$Env:gist_id"
      SendAlways  = $false                        #Send notifications every time
    }
  } else { }

  ForcedPackages            = $ForcedPackages -split ' '
  UpdateIconScript          = "$PSScriptRoot\scripts\Update-IconUrl.ps1"
  UpdatePackageSourceScript = "$PSScriptRoot\scripts\Update-PackageSourceUrl.ps1"
  ModulePaths               = @("$PSScriptRoot\scripts\au_extensions.psm1"; "Wormies-AU-Helpers")
  BeforeEach                = {
    param($PackageName, $Options )
    $Options.ModulePaths | ForEach-Object { Import-Module $_ }
    . $Options.UpdatePackageSourceScript $PackageName.ToLowerInvariant() -Quiet
    if (Test-Path tools) {
      Expand-Aliases -Directory tools -AliasWhitelist @(
        'Get-PackageParameters'
        'Get-UninstallRegistryKey'
        'Install-ChocolateyInstallPackage'
        'Uninstall-ChocolateyPackage'
      )
    }

    $pattern = "^${PackageName}(?:\\(?<stream>[^:]+))?(?:\:(?<version>.+))?$"
    $p = $Options.ForcedPackages | Where-Object { $_ -match $pattern }
    if (!$p) { return }

    $global:au_Force = $true
    $global:au_IncludeStream = $Matches['stream']
    $global:au_Version = $Matches['version']
  }
}

if ($ForcedPackages) { Write-Host "FORCED PACKAGES: $ForcedPackages" }
$global:au_Root = $Root          #Path to the AU packages
$global:info = updateall -Name $Name -Options $Options

#Uncomment to fail the build on AppVeyor on any package error
#if ($global:info.error_count.total) { throw 'Errors during update' }
