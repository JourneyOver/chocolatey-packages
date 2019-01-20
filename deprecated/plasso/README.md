# [<img src="https://cdn.jsdelivr.net/gh/JourneyOver/chocolatey-packages@c28e2ded32fc8910b6227c10fdaf5cd0c17091c3/icons/plasso.png" height="48" width="48" /> ![Process Lasso](https://img.shields.io/chocolatey/v/plasso.svg?label=Process%20Lasso&style=for-the-badge)](https://chocolatey.org/packages/plasso)

Process Lasso is a tool designed to manage and edit how your processes and services run.

It offers a robust list of capabilities including default process priorities and affinities, termination of disallowed processes, instance count limits, a system responsiveness graph, logging of processes, keep select processes running (auto-restart), and much more.

## Features

* ProBalance dynamic priority optimization
* Persistent (sticky) priorities and CPU affinities
* Instance count limits
* Disallowed processes
* Keep processes running (auto-restart)
* Unique system responsiveness graph
* Prevent PC sleep for designated processes
* Differentiate between svchost.exe instances
* Extremely low resource use
* Stand-alone process management engine (uses as little as 1MB of RAM)
* Event logging

## Package parameters

To pass parameters, use `--params "''"` (e.g. `choco install packageID [other options] --params="'/ITEM:value /ITEM2:value2 /FLAG_BOOLEAN'"`).
To have choco remember parameters on upgrade, be sure to set `choco feature enable -n=useRememberedArgumentsForUpgrades`.

* `/language:` - This indicates the language to use. - defaults to "English"
* `/gui_start_type:` - This indicates whether to start the GUI at login for ALL users (all), for only the current user (current), or neither (manual). The current user is the user context in which the installer is running. - defaults to "all,uac"
* `/governor_start_type:` - This indicates whether to start the core engine (processgovernor) at login for ALL users (all), for only the current user (current), or neither (manual). The current user is the user context in which the installer is running. - defaults to "all,uac"
* `/launch_gui` - This indicates whether or not to launch the GUI after installation. Even when the GUI is launched, it remains minimized to the system tray. - if not passed defaults to "false"
* `/logfolder:` - This indicates to use a global log folder for ALL users on the system. By default, each user has his or her own log folder in their respective application data directory. However, it is sometimes desirable to consolidate all log events into a single log folder. Be sure that this log folder is writable by all users on the system. - defaults to "%appdata%\\ProcessLasso\\logs"
* `/configfolder:` - This indicates to use a global configuration folder for ALL users on the system. By default, each user has his or her own configuration in their respective application data directory. However,it is sometimes desirable to use the same configuration for all users, and is required when the governor is run as a service. Be sure that this configuration folder is at least readable by all users, and writable by those who you wish to allow configuration changes. - defaults to "%appdata%\\ProcessLasso\\config"

## Notes

* This will always install the latest version of Process Lasso, regardless of the version specified in the package.

* When using a user-defined config and log path, we recommend storing the config in a sub-folder, e.g. “C:\\ProcessLasso\\Config” and the logs in another sub-folder “C:\\ProcessLasso\\Logs”. The reason we suggest this is because, otherwise, every time the log is written to, it will trigger a file system change notification event on that folder and cause the configuration file to be checked to see if it changed. It won’t be reloaded, so not much overhead, but a little. The granularity of file system change notifications in Windows is limited to folders, thus putting the config in it’s own folder makes sure that only writes to it cause a change notification event.

* There is an option for `/governor_start_type:` option as a service, but at the current time this package does not support the option to start the governor as a service.

![screenshot](https://raw.githubusercontent.com/JourneyOver/chocolatey-packages/master/readme_imgs/plasso.png)
