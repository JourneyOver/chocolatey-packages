# [<img src="https://cdn.jsdelivr.net/gh/JourneyOver/chocolatey-packages@2abe074087be5f4c921b6ab1ad0bc6ccd959bbfa/icons/jackett.png" height="48" width="48" /> ![Jackett](https://img.shields.io/chocolatey/v/jackett.svg?label=Jackett&style=for-the-badge)](https://chocolatey.org/packages/jackett)

Jackett works as a proxy server: it translates queries from apps ([Sonarr](https://github.com/Sonarr/Sonarr), [Radarr](https://github.com/Radarr/Radarr), [SickRage](https://sickrage.github.io/), [CouchPotato](https://couchpota.to/), [Mylar](https://github.com/evilhero/mylar), etc) into tracker-site-specific http queries, parses the html response, then sends results back to the requesting software. This allows for getting recent uploads (like RSS) and performing searches. Jackett is a single repository of maintained indexer scraping and translation logic - removing the burden from other apps.

## Features

- [Supported Public Trackers](https://github.com/Jackett/Jackett/blob/master/README.md#supported-public-trackers)
- [Supported Semi-Private Trackers](https://github.com/Jackett/Jackett/blob/master/README.md#supported-semi-private-trackers)
- [Supported Private Trackers](https://github.com/Jackett/Jackett/blob/master/README.md#supported-private-trackers)

## Notes

Installs as a service, to get to Jackett open any web browser and go [here](http://localhost:9117/UI/Dashboard) or go to http://<your-ip>:9117/UI/Dashboard
