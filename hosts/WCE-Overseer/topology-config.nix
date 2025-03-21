{config, ...}: let
  inherit (config.lib.topology) mkInternet mkRouter mkConnection;
in {
  topology.self = {
    hardware.info = "ThinkCentre M710q";
    interfaces = {
      eth0 = {
        addresses = ["192.168.0.30"];
        network = "home";
        physicalConnections = [(mkConnection "router" "eth3")];
      };
    };
  };
}
