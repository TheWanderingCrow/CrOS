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
      auth.reset_admin_password = true; # roll the admin password every restart, depend on user accounts for long-lived access
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
            "rtsp://thingino:thingino@192.168.150.1:554/ch0"
          ];
          wce-0001_sub = [
            "rtsp://thingino:thingino@192.168.150.1:554/ch1"
          ];
        };
      };
      #############
      # Detectors #
      #############
      detectors = {
        ov_0 = {
          type = "openvino";
          device = "CPU";
        };
      };
      model = {
        width = 300;
        height = 300;
        input_tensor = "nhwc";
        input_pixel_format = "bgr";
        path = "/openvino-model/ssdlite_mobilenet_v2.xml";
        labelmap_path = "/openvino-model/coco_91cl_bkgr.txt";
      };
      objects = {
        track = [
          "person"
          "cat"
          "car"
          "dog"
        ];
      };
      review = {
        alerts = {
          labels = [
            "person"
          ];
        };
      };
      ####################
      # Data Persistence #
      ####################
      record = {
        enabled = true;
        retain.days = 0; # as per official documentation
        alerts = {
          retain.days = 14;
        };
        detections = {
          retain.days = 14;
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
          live.stream_name = "wce-0001_sub";
          motion = {
            enabled = true;
            mask = [
              "0,0,0.196,0.002,0.195,0.045,0,0.043" # timestamp
              "0.898,0,0.896,0.045,1,0.048,0.999,0.002" # uptime
            ];
          };
          detect.enabled = true;
        };
      };
    });
  in
    lib.mkIf config.user.overseer.enable {
      sops = {
        templates."frigate_env".content = ''
          FRIGATE_JWT_SECRET=${config.sops.placeholder."frigate/jwt"}
        '';
        secrets = {
          "frigate/jwt" = {};
        };
      };
      systemd.tmpfiles.rules = [
        "d ${volumePath}/frigate"
        "d ${volumePath}/frigate/media/frigate"
        "d ${volumePath}/frigate/db"
        "f ${volumePath}/frigate/db/frigate.db"
      ];
      ###########
      # Service #
      ###########

      virtualisation.oci-containers = {
        backend = "podman";
        containers = {
          "frigate" = {
            image = "ghcr.io/blakeblackshear/frigate:stable";
            environmentFiles = [config.sops.templates."frigate_env".path];
            volumes = [
              "/etc/localtime:/etc/localtime:ro"
              "${volumePath}/frigate/media/frigate:/media/frigate"
              "${frigateConfig}:/config/config.yaml:ro"
              "${volumePath}/frigate/db/frigate.db:/config/frigate.db"
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
