{
  lib,
  config,
  ...
}: {
  config.services.keyd = lib.mkIf config.software.keyd.enable {
    enable = true;
    keyboards.default = {
      ids = ["*"];
      settings = {
        main = {
          capslock = "layer(standardL2)";
        };
        standardL2 = {
          w = "up";
          s = "down";
          a = "left";
          d = "right";

          b = "C-b";

          space = "playpause";
          "." = "nextsong";
          "," = "previoussong";

          "[" = "delete";
          "]" = "end";
          escape = "~";

          home = "end";
        };
      };
    };
  };
}
