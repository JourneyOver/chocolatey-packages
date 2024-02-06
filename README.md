# Chocolatey Packages

## Automatic Updating

[![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/JourneyOver/chocolatey-packages/package-updater.yml)](https://github.com/JourneyOver/chocolatey-packages/actions/workflows/package-updater.yml)
[![Update Status](https://img.shields.io/badge/Update-Status-blue.svg)](https://gist.github.com/JourneyOver/508bb89c4cc35b67842940c60310532b)
[![Force Test Status](https://img.shields.io/badge/Update-Force%20Test%20Status-red.svg)](https://gist.github.com/JourneyOver/13f08beca5db513521762b5c4ce53d58)
[![chocolatey/JourneyOver](https://img.shields.io/badge/Chocolatey-JourneyOver-008b85.svg)](https://chocolatey.org/profiles/JourneyOver)
[![Open Source Helpers](https://www.codetriage.com/journeyover/chocolatey-packages/badges/users.svg)](https://www.codetriage.com/journeyover/chocolatey-packages)

## Description

This repository contains chocolatey packages created and maintained by [JourneyOver](https://chocolatey.org/profiles/JourneyOver), updated daily.

## Guidelines

### Reporting broken/outdated packages

If packages fail to install or a new version is released, please report it in any of the following ways:

- [GitHub issue](https://github.com/JourneyOver/chocolatey-packages/issues/new)

#### Broken packages

If the package fails to install or uninstall via choco, include debug information from the console:

```shell
choco install PKGID --yes --verbose --debug
```

#### Outdated packages

If the package is not up-to-date, include the following if possible:

- Latest version number
- Release date
- URL to the install binary

### Contributing

1. Whenever possible, use the [AU module](https://github.com/majkinetor/au) for automatic packages.
2. If allowed, include the packaged software directly in the `.nupkg` archive instead of downloading it at install time. Only tools allowing redistribution in their license can be embedded, and such packages must include `VERIFICATION.txt` and `License.txt` in the `tools` directory.
3. Prioritize readable code without sacrificing efficiency. Code should be understandable by others.
4. Fill up metadata attributes in the package as much as possible. Empty metadata tags indicate unavailable information. If metadata is not publicly available, attempt to contact the software publisher.
