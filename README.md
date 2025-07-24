# CrOS (Crow's NixOS Configuration Repo)

## Directory Structure

- `flake.nix` - Entrypoint for hosts and user home configurations. Also exposes
  a devshell for manual bootstrapping tasks (`nix develop`).
- `hosts` - NixOS configurations accessible via
  `sudo nixos-rebuild switch --flake .#<host>`.
  - `common` - Shared configurations consumed by the machine specific ones.
    - `core` - Configurations present across all hosts. This is a hard rule! If
      something isn't core, it is optional.
    - `disks` - Declarative disk partition and format specifications via disko.
    - `optional` - Optional configurations present across more than one host.
    - `users` - Host level user configurations present across at least one host.
      - `<user>/keys` - Public keys for the user that are symlinked to ~/.ssh
  - `dariwn` - machine specific configurations for darwin-based hosts
    - Currently not using any darwin hosts
  - `nixos` - machine specific configurations for NixOS-based hosts
    - `Parzival` - Primary Box - Ryzen 5 7600 - RX 7800 XT - 32GB DDR5
    - `Incarceron` - Work issued framework 13 - AMD Ryzen 7 7840U - 32GB DDR5
    - `Nyx` - My X1 Carbon, personal laptop - i7-8650U - 16GB DDR4
    - `HandlerOne` - Lenovo m710q - i5-7500T - 16GB DDR4
    - `Mote` - Some dinky little datto appliance that does my bidding now
    - `Michishirube` - Nebula lighthouse node hosted on Digital Ocean
  - `droid` - nix-on-droid configurations
- `home/<user>` - Home-manager configurations, built automatically during host
  rebuilds.
  - `common` - Shared home-manager configurations consumed the user's machine
    specific ones.
    - `core` - Home-manager configurations present for user across all machines.
      This is a hard rule! If something isn't core, it is optional.
    - `optional` - Optional home-manager configurations that can be added for
      specific machines. These can be added by category (e.g. options/media) or
      individually (e.g. options/media/vlc.nix) as needed. The home-manager core
      and options are defined in host-specific .nix files housed in
      `home/<user>`.
- `lib` - Custom library used throughout the nix-config to make import paths
  more readable. Accessible via `lib.custom`.
  - Currently am not extending lib.
- `modules` - Custom modules to enable special functionality and options.
  - `common` - Custom modules that will work on either nixos or dariwn but that
    aren't specific to home-manager
  - `darwin` - Custom modules specific to dariwn-based hosts
  - `home` - Custom modules to home-manager
  - `nixos` - Custom modules specific to nixos-based hosts
  - `services` - Definitions for hosted services
- `overlays` - Custom modifications to upstream packages.
- `pkgs` - Custom packages meant to be shared or upstreamed.
  - `common` - Custom packages that will work on either nixos or dariwn
  - `darwin` - Custom packages specific to dariwn-based hosts
  - `nixos` - Custom packages specific to nixos-based hosts
- `devshells` - Custom development shells and environments
- `assets` - Storage for things like wallpapers

# Credits

Inspired by many others, but especially:

- https://github.com/EmergentMind/
- https://github.com/vimjoyer/
- https://github.com/Misterio77/nix-starter-configs
- https://github.com/numtide/blueprint
