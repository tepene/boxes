# Proton Apps - Distrobox

This image provides the following selected [Proton Apps](https://protonapps.com/):

- [Proton Mail](https://proton.me/mail)
- [Proton Pass](https://proton.me/pass)

## Installation

To setup the Proton Apps distrobox run:

```sh
distrobox create -i ghcr.io/tepene/protonapps:latest -n protonapps && distrobox-enter --name protonapps -- /opt/utils/box.sh
```

This will create the Distrobox `protonapps` for you, [export](https://github.com/89luca89/distrobox/blob/main/docs/usage/distrobox-export.md)
the applications to your host system and create a [systemd quadlet](https://docs.podman.io/en/latest/markdown/podman-systemd.unit.5.html)
which makes sure that the image stays up to date.

## Image Verification

This image is signed with sisgstore's [cosign](https://docs.sigstore.dev/cosign/overview/).
You can verify the signature by downloading the `cosign.pub` key from this repo
and running the following command:

```sh
cosign verify --key cosign.pub ghcr.io/tepene/protonapps:latest`
```
