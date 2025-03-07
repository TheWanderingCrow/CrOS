let
  volumePath = "/overseer/services";
in
  {
    pkgs,
    lib,
    config,
    ...
  }: let
    frigateConfig = pkgs.writeText "config.yaml" (lib.generators.toYAML {} {
      tls.enabled = false; # off because we're doing ssl through nginx
      mqtt = {
        # TODO: add mqtt broker
        enabled = false;
      };
      ###################
      # go2rtc restream #
      ###################
      go2rtc = {
        streams = {
          wce-0001 = [
            "rtsp://thingino:thingino@192.168.0.173:554/ch0"
          ];
          wce-0001_sub = [
            "rtsp://thingino:thingino@192.168.0.173:554/ch1"
          ];
          wce-0002 = [
            "rtsp://thingino:thingino@192.168.0.26:554/ch0"
          ];
          wce-0002_sub = [
            "rtsp://thingino:thingino@192.168.0.26:554/ch1"
          ];
        };
      };
      #################
      # Camera config #
      #################
      cameras = {
        wce-0001 = {
          ffmpeg = {
            inputs = [
              {
                path = "rtsp://127.0.0.1:8554/wce-0001";
                roles = ["record"];
              }
              {
                path = "rtsp://127.0.0.1:8554/wce-0001_sub";
                roles = ["detect"];
              }
            ];
          };
          motion = {
            mask = [
              "0,0,0,0.04,0.201,0.043,0.199,0.005"
              "0.864,0,0.865,0.043,1,0.043,1,0"
            ];
          };
          live.stream_name = "wce-0001_sub";
          detect.enabled = false;
        };
        wce-0002 = {
          ffmpeg = {
            inputs = [
              {
                path = "rtsp://127.0.0.1:8554/wce-0002";
                roles = ["record"];
              }
              {
                path = "rtsp://127.0.0.1:8554/wce-0002_sub";
                roles = ["detect"];
              }
            ];
          };
          motion = {
            mask = [
              "0,0,0,0.04,0.201,0.043,0.199,0.005"
              "0.864,0,0.865,0.043,1,0.043,1,0"
            ];
          };
          live.stream_name = "wce-0002_sub";
          detect.enabled = false;
        };
      };
    });
  in
    lib.mkIf config.user.overseer.enable {
      systemd.tmpfiles.rules = [
        "d ${volumePath}/frigate"
        "d ${volumePath}/frigate/config"
        "d ${volumePath}/frigate/media/frigate"
      ];
      ###########
      # Service #
      ###########

      virtualisation.oci-containers = {
        backend = "podman";
        containers = {
          "frigate" = {
            image = "ghcr.io/blakeblackshear/frigate:stable";
            volumes = [
              "/etc/localtime:/etc/localtime:ro"
              "${volumePath}/frigate/media/frigate:/media/frigate"
              "${frigateConfig}:/config/config.yaml:ro"
            ];
            extraOptions = [
              "--shm-size=612m"
              "--ip=10.88.0.10"
            ];
          };
        };
      };

      services.nginx = {
        enable = true;
        recommendedProxySettings = true;
        virtualHosts = {
          "frigate.wanderingcrow.net" = {
            forceSSL = true;
            useACMEHost = "frigate.wanderingcrow.net";
            locations."/" = {
              proxyPass = "http://10.88.0.10:8971";
              proxyWebsockets = true;
            };
          };
        };
      };
    }
