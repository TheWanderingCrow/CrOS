{lib, ...}: {
  services.avahi = lib.mkDefault {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      domain = true;
    };
  };
}
