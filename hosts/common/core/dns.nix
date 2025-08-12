{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.nextdns
  ];
  services.nextdns = {
    enable = true;
    arguments = ["-config" "cc2b9b"];
  };
}
