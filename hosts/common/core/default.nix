{
  inputs,
  outputs,
  config,
  lib,
  pkgs,
  isDarwin,
  ...
}: let
  platform =
    if isDarwin
    then "darwin"
    else "nixos";
  platformModules = "${platform}Modules";
in {
  system.stateVersion = "24.05";

  imports = lib.flatten [
    inputs.home-manager.${platformModules}.home-manager
    inputs.sops-nix.${platformModules}.sops

    (map lib.custom.relativeToRoot [
      "hosts/common/core/${platform}.nix"
      "hosts/common/core/shell.nix"
      "hosts/common/core/sops.nix"
      "hosts/common/core/ssh.nix"
      "hosts/common/core/editor.nix"
      "hosts/common/core/fonts.nix"
      "hosts/common/core/sudo.nix"
      "hosts/common/core/nebula.nix"
      "hosts/common/core/avahi.nix"
      "hosts/common/core/dns.nix"
      "hosts/common/users/primary"
      "hosts/common/users/primary/${platform}.nix"
      "modules/common"
    ])
  ];

  hostSpec = {
    username = lib.mkDefault "crow";
    handle = lib.mkDefault "TheWanderingCrow";
  };

  networking.hostName = config.hostSpec.hostName;

  environment.systemPackages = [
    pkgs.openssh
    pkgs.file
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "bk";

  nixpkgs = {
    overlays = [
      outputs.overlays.default
    ];
    config = {
      allowUnfree = true;
    };
  };

  virtualisation.oci-containers.backend = lib.mkDefault "podman";

  nix.settings = {
    connect-timeout = 5;
    log-lines = 25;
    min-free = 128000000;
    max-free = 1000000000;

    experimental-features = ["nix-command" "flakes"];

    fallback = true;
    auto-optimise-store = true;

    trusted-users = ["@wheel"];
  };
}
