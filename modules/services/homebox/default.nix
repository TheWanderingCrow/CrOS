{inputs, ...}: {
  services = {
    caddy = {
      enable = true;
      virtualHosts."homebox.wanderingcrow.net".extraConfig = ''
        remote_ip ${inputs.nix-secrets.network.primary.publicIP}
        @block not remote_ip private_ranges
        abort @block
        reverse_proxy http://localhost:7745
      '';
    };
    homebox = {
      enable = true;
      settings = {
        HBOX_OPTIONS_ALLOW_REGISTRATION = "true";
      };
    };
  };
}
