{inputs, ...}: {
  services.caddy = {
    enable = true;
    virtualHosts."chat.wanderingcrow.net".extraConfig = ''
      @block not remote_ip ${inputs.nix-secrets.network.primary.publicIP} private_ranges
      abort @block
      reverse_proxy http://192.168.0.72:3000
    '';
  };
}
