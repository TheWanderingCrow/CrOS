{config, ...}: {
  programs.starship = let
    raisin_black = "#262932";
    blood_red = "#710000";
    rich_lemon = "#FDF500";
    keppel = "#1AC5B0";
    electric_blue = "#36EBF3";
    blushing_purple = "#9370DB";
    frostbite = "#E455AE";
    steel_pink = "#CB1DCD";
    pale_silver = "#D1C5C0";
  in {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    settings = {
      format = "[ ](${rich_lemon})[ CrOS](bg:${rich_lemon} fg:${raisin_black})$username$hostname[ ](fg:${rich_lemon} bg:${blushing_purple})$directory[ ](fg:${blushing_purple} bg:${frostbite})$git_branch$git_status[ ](fg:${frostbite} bg:${steel_pink})$nix_shell[ ](${steel_pink})";
      right_format = "[ ](${rich_lemon})$time[ ](${rich_lemon})";

      # Left Modules
      username = {
        disabled = false;
        format = "[  $user]($style)";
        style_user = "fg:${keppel} bg:${rich_lemon}";
        style_root = "fg:${blood_red} bg:${rich_lemon}";
      };
      hostname = {
        disabled = false;
        format = "[@$hostname ]($style)";
        style = "fg:${keppel} bg:${rich_lemon}";
        ssh_only = false;
        ssh_symbol = "";
      };
      directory = {
        disabled = false;
        format = "[ $path ]($style)";
        style = "bg:${blushing_purple} fg:${raisin_black}";
        truncation_length = 3;
        truncation_symbol = "…/";
      };
      git_branch = {
        disabled = false;
        format = "[ $symbol $branch ]($style)";
        symbol = "";
        style = "fg:${raisin_black} bg:${frostbite}";
      };
      git_status = {
        disabled = false;
        format = "[$all_status$ahead_behind]($style)";
        style = "fg:${raisin_black} bg:${frostbite}";
      };
      nix_shell = {
        disabled = false;
        format = "[$symbol $name]($style)";
        style = "bg:${steel_pink} fg:${electric_blue}";
        symbol = "";
      };

      # Right Modules
      time = {
        disabled = false;
        format = "[$time]($style)";
        style = "fg:${raisin_black} bg:${rich_lemon}";
      };
    };
  };
}
