# Boxes

This repository holds all my custom Distrobox images which I use to get apps
running on [bluefin-dx](https://projectbluefin.io/) where an official [Flatpak](https://flathub.org/)
version is missing. There might be community driven Flatpaks out there for these apps
but I really think Flatpaks for certain apps should be build by the application owners and
not by the community.

## Base Images

Since my computers are running [universal blue](https://universal-blue.org/) I rely on the
[uBlue OS Toolbox](https://github.com/ublue-os/toolboxes) images. A big shout out
to all [contributors](https://github.com/ublue-os/toolboxes/graphs/contributors)! Thank you!

## Applications

Whenever possible I try to package the applications from the same "vendor" in a single
container image.

The following images are available:

| Image                              | Description                                           | Documentation                             |
| ---------------------------------- | ----------------------------------------------------- | ----------------------------------------- |
| `ghcr.io/tepene/protonapps:latest` | A selection of [Proton Apps](https://protonapps.com/) | [README.md](./boxes/protonapps/README.md) |

These images are built daily to ensure that the latest base image and application updates
are included.

## Statistics

![Alt](https://repobeats.axiom.co/api/embed/fcf788d8e7d85fd0ecccf06a47381f4f97598d09.svg "Repobeats analytics image")
