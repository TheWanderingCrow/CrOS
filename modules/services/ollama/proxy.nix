{inputs, ...}: {
  services.caddy = {
    enable = true;
    virtualHosts."chat.wanderingcrow.net".extraConfig = ''
      remote_ip ${inputs.nix-secrets.network.primary.publicIP}
      @denined not remote_ip private_ranges
      abort @denied
      reverse_proxy http://192.168.0.72:3000
    '';
  };
}
