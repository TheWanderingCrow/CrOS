{config, ...}: let
  inherit (config.lib.topology) mkInternet mkRouter mkConnection;
in {
  topology.self = {
    hardware.info = "Primary Desktop";
    interfaces = {
      wlan0 = {
        addresses = ["192.168.141.1"];
        network = "home";
        physicalConnections = [(mkConnection "router" "wlan0")];
      };
    };
  };
}
