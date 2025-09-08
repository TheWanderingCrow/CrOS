{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/services/matrix/tuwunel.nix"
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
        allow_registration = false;
        registration_token_file = config.sops.secrets."matrix/registration_token".path;
        allow_encryption = true;
        allow_federation = true;
        require_auth_for_profile_requests = true; # no user enumeration
        trusted_servers = ["matrix.org"];
      };
    };
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts = {
      "psychal.link" = {
        forceSSL = true;
        useACMEHost = "psychal.link";
        locations."/" = {
          proxyPass = "http://unix:/run/tuwunel/tuwunel.sock";
          proxyWebsockets = true;
        };
      };
    };
  };
}
