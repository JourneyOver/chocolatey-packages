# [<img src="https://cdn.jsdelivr.net/gh/JourneyOver/chocolatey-packages@7217602544a5334006b3145eaf2447c9eaaa8e4f/icons/sonarr.png" height="48" width="48" /> ![Sonarr](https://img.shields.io/chocolatey/v/sonarr.svg?label=Sonarr&style=for-the-badge)](https://chocolatey.org/packages/sonarr)

Sonarr (formerly NzbDrone) is a PVR for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new episodes of your favorite shows and will grab, sorts and renames them. It can also be configured to automatically upgrade the quality of files already downloaded when a better quality format becomes available.

## Features

* Support for major platforms: Windows, Linux, macOS, Raspberry Pi, etc.
* Automatically detects new episodes
* Can scan your existing library and download any missing episodes
* Can watch for better quality of the episodes you already have and do an automatic upgrade. eg. from DVD to Blu-Ray
* Automatic failed download handling will try another release if one fails
* Manual search so you can pick any release or to see why a release was not downloaded automatically
* Fully configurable episode renaming
* Full integration with SABnzbd and NZBGet
* Full integration with Kodi, Plex (notification, library update, metadata)
* Full support for specials and multi-episode releases
* And a beautiful UI

## Community

* [IRC](http://webchat.freenode.net/?channels=#sonarr)
* [Twitter](https://twitter.com/sonarrtv)
* [Reddit](https://www.reddit.com/r/sonarr)

## Notes

This is the pre-release versions of Sonarr V3 otherwise known as Phantom.

* Sonarr v2 migration
  * Sonarr v3 will automatically convert the existing Sonarr v2 installation. Sonarr v2 stored it's database in `C:\ProgramData\NzbDrone`, which will be automatically converted to `C:\ProgramData\Sonarr`. It's advisable to make a backup of the v2 data first.

Installs as a service, to get to Sonarr open browser and go [here](http://localhost:8989/) or go to http://<your-ip>:8989/
