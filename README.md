# Chocolatey Packages

### Automatic Updating

[![Build status](https://github.com/JourneyOver/chocolatey-packages/workflows/Update%20Packages/badge.svg)](https://github.com/JourneyOver/chocolatey-packages/actions?query=workflow%3A%22Update+Packages%22)
[![Update Status](https://img.shields.io/badge/Update-Status-blue.svg)](https://gist.github.com/JourneyOver/508bb89c4cc35b67842940c60310532b)
[![Force Test Status](https://img.shields.io/badge/Update-Force%20Test%20Status-red.svg)](https://gist.github.com/JourneyOver/13f08beca5db513521762b5c4ce53d58)
[![chocolatey/JourneyOver](https://img.shields.io/badge/Chocolatey-JourneyOver-008b85.svg)](https://chocolatey.org/profiles/JourneyOver)
[![Open Source Helpers](https://www.codetriage.com/journeyover/chocolatey-packages/badges/users.svg)](https://www.codetriage.com/journeyover/chocolatey-packages)

### Description

This repository contains chocolatey packages created and maintained by [JourneyOver](https://chocolatey.org/profiles/JourneyOver) that are updated daily

## Guidelines

### Reporting broken/outdated packages

If packages from this repository fail to install or a new version has been released by the software vendor for a particular package, please report it in any or all of the following ways:

Github issue: <https://github.com/JourneyOver/chocolatey-packages/issues/new>

### Broken packages

If the package fails to install or uninstall via choco, please include debug information from the console:
`choco install PKGID --yes --verbose --debug`

### Outdated packages

If the package is not up to date, please include the following if possible:
latest version number
release date
URL to the install binary

### Contributing

1. As much as possible, these packages are [automatic](https://chocolatey.org/docs/automatic-packages) and all automatic packages will use the [AU module](https://github.com/majkinetor/au).
2. If allowed, packages will include the packaged software directly in the `.nupkg` archive instead of downloading it from another site at the time of install. Only tools that allow redistribution in their license can be embedded and such packages must include two additional files in the `tools` directory - `VERIFICATION.txt` and `License.txt`.
3. Code is written for humans, not for computers (i.e. assembly). Thus, Make the code readable, but also efficient. The goal is not to obfuscate. If another person wants to help, they need to understand it too!
4. All the metadata attributes in the package needs to be filled up as much as possible. If a metadata tag is empty, it is because the information is not available. In case of the metadata not being publicly available, you could try to contact the publisher of the software.
