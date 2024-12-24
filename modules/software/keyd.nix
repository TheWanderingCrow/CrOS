{
  config.services.keyd = {
    enable = true;
    keyboards.default = {
      ids = ["*"];
      extraConfig = ''
        [global]

        default_layout = main

        [main:layout]

        capslock = layer(standardL2)

        [standardL2]

        w = up
        s = down
        a = left
        d = right

        b = C-b

        space = playpause
        . = nextsong
        , = previoussong

        [ = delete
        ] = end
        escape = ~

        home = end
      '';
    };
  };
}
