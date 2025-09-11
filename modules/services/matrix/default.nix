{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/services/matrix/tuwunel.nix"
  ];

  environment.systemPackages = [
    pkgs.unstable.fluffychat-web
  ];

  sops.secrets."matrix/registration_token" = {
    owner = "tuwunel";
  };

  services.matrix-tuwunel = {
    enable = true;
    package = pkgs.unstable.matrix-tuwunel;
    stateDirectory = "tuwunel";
    settings = {
      global = {
        server_name = "psychal.link";
        new_user_displayname_suffix = "";
        unix_socket_path = "/run/tuwunel/tuwunel.sock";
        unix_socket_perms = 660;
        allow_registration = true;
        registration_token_file = config.sops.secrets."matrix/registration_token".path;
        allow_encryption = true;
        allow_federation = true;
        require_auth_for_profile_requests = true; # no user enumeration
        trusted_servers = ["matrix.org"];
      };
    };
  };

  networking.firewall.allowedTCPPorts = [8448];

  users.users.caddy.extraGroups = ["tuwunel"];

  services.caddy = {
    enable = true;
    virtualHosts = {
      "psychal.link, psychal.link:8448".extraConfig = ''
        reverse_proxy unix//run/tuwunel/tuwunel.sock
      '';
      "chat.psychal.link".extraConfig = ''
        root * ${pkgs.unstable.fluffychat-web}
        file_server
      '';
    };
  };
}
