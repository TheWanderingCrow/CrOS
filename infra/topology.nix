{config, ...}: let
  inherit (config.lib.topology) mkInternet mkRouter mkConnection;
in {
  # Define networks/nodes here
  networks = {
    home = {
      name = "Home Network";
      cidrv4 = "192.168.0.0/16";
      style = {
        primaryColor = "#69398b";
        secondaryColor = "#9277ae";
        pattern = "solid";
      };
    };
    wce-networks = {
      name = "WCE AWS VPC";
      cidrv4 = "172.31.0.0/16";
      cidrv6 = "2600:1f18:22fc:c200::/56";
      style = {
        primaryColor = "#FF9900";
        secondaryColor = "#FF9900";
        pattern = "solid";
      };
    };
  };

  nodes.internet = mkInternet {
    connections = mkConnection "router" "wan1";
  };

  nodes.router = mkRouter "TP-Link" {
    info = "AX1450 Wi-Fi 6 Router";
    interfaceGroups = [
      ["wan1"]
      ["eth1" "eth2" "eth3" "eth4"]
      ["wlan0"]
    ];
  };
}
