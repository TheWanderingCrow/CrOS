{
  pkgs,
  lib,
  config,
  ...
}: lib.mkIf config.user.live.enable {
  config.users.users.live = {
    isNormalUser = true;
    initialPassword = "live";
    extraGroups = ["wheel" "networkmanager" "audio" "plugdev"];
    openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCccZhYmAIdbBv0vuvhKvnD0sm6dphdngef1jFwDhcUexoEZq8sXB3N69gsQV+ievv++T5SfEwLPEJSgVEwtwYHTCwxnGscD+thYXOacoMr3++1toCKgFHLIWrbma8jSzSDp8ERuVcbeYo/xckxCL3+axlUmyQw6TXsDbOJTYhGuJdCMlHJNl0EftwgnJZ4e+WqW/5jmG9Nu3KDgpyjYVA4v6xtkjS+NCVA3jOdDs0JPFemhb2b5ItAGe60IH65PaX63QFysxMWil0+EF04L+23sYwRMMfz9F/AX62uonemzROTAIu78grUWgjHqGQ2yOhdnOwNT0wox1KhG+r/lvFX"
    ];
  };
}
