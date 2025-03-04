{
  lib,
  config,
  ...
}:
lib.mkIf config.user.overseer.enable {
  services.frigate = {
    enable = true;
    hostname = "frigate.wanderingcrow.net";
    settings = {
      go2rtc = {
        streams = {
          wce-0001 = [
            "ffmpeg:#input=-timeout 30000000 -i rtsp://thingino:thingino@192.168.0.173:554/ch0"
            "ffmpeg:wce-0001#audio=opus"
          ];
          wce-0001_sub = "ffmpeg:#input=-timeout 30000000 -i rtsp://thingino:thingino@192.168.0.173:554/ch1";
          wce-0002 = [
            "ffmpeg:#input=-timeout 30000000 -i rtsp://thingino:thingino@192.168.0.26:554/ch0"
            "ffmpeg:wce-0002#audio=opus"
          ];
          wce-0002_sub = "ffmpeg:#input=-timeout 30000000 -i rtsp://thingino:thingino@192.168.0.26:554/ch1";
        };
      };
      cameras = {
        wce-0001 = {
          ffmpeg = {
            inputs = [
              {
                path = "rtsp://127.0.0.1:8554/wce-0001?timeout=30";
                input_args = "preset-rtsp-restream-low-latency";
                roles = ["record"];
              }
              {
                path = "rtsp://127.0.0.1:8554/wce-0001_sub?timeout=30";
                input_args = "preset-rtsp-restream-low-latency";
                roles = ["detect" "audio"];
              }
            ];
          };
          motion = {
            mask = [
              "0.005,0.006,0.005,0.041,0.195,0.041,0.196,0.008"
              "0.904,0.007,0.903,0.042,0.994,0.042,0.994,0.006"
            ];
          };
          live.stream_name = "wce-0001";
        };
        wce-0002 = {
          ffmpeg = {
            inputs = [
              {
                path = "rtsp://127.0.0.1:8554/wce-0002?timeout=30";
                input_args = "preset-rtsp-restream-low-latency";
                roles = ["record"];
              }
              {
                path = "rtsp://127.0.0.1:8554/wce-0002_sub?timeout=30";
                input_args = "preset-rtsp-restream-low-latency";
                roles = ["detect" "audio"];
              }
            ];
          };
          motion = {
            mask = [
              "0.005,0.006,0.005,0.041,0.195,0.041,0.196,0.008"
              "0.904,0.007,0.903,0.042,0.994,0.042,0.994,0.006"
            ];
          };
          live.stream_name = "wce-0002";
        };
      };
    };
  };
}
