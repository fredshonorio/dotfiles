# Home Manager Notes

## NixOS release versions

Releases follow a `YY.MM` cadence (e.g. `25.05`, `25.11`, `26.05`).

- Available nixpkgs releases: https://github.com/NixOS/nixpkgs/branches (filter by `release-*`)
- Available home-manager releases: https://github.com/nix-community/home-manager/branches

Home Manager and nixpkgs versions must match.

## Updating packages within the current release

Picks up backported security fixes; does not change package versions significantly.

```sh
nix-channel --update
home-manager switch
```

## Upgrading to a new release

Updates all packages to the versions shipped with the new release.

1. Update `NIXPKGS_VERSION` in `init.sh`
2. Update the nixpkgs channel to match:
   ```sh
   nix-channel --add https://nixos.org/channels/nixos-<VERSION> nixpkgs
   nix-channel --remove home-manager
   nix-channel --add https://github.com/nix-community/home-manager/archive/release-<VERSION>.tar.gz home-manager
   nix-channel --update
   home-manager switch
   ```
