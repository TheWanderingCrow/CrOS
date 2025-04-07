{
  programs.firefox = {
    enable = true;
    policies = {
      BlockAboutConfig = true;
      DisableFirefoxStudies = true;
      DisableFormHistory = true;
      DisablePasswordReveal = true;
      DisablePocket = true;
      DisableProfileImport = true;
      DontCheckDefaultBrowser = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      Homepage = {
        URL = "https://home.wanderingcrow.net";
        StartPage = "homepage";
      };
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
      ExtensionSettings = {
        #"*".installation_mode = "blocked";
        "*".blocked_install_message = "Please manage extensions through your NixOS config";
        # Bitwarden
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/{446900e4-71c2-419f-a6a7-df9c091e268b}/latest.xpl";
          default_area = "navbar";
        };
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/uBlock0@raymondhill.net/latest.xpl";
          default_area = "menupanel";
        };
        # Vimium
        "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/{d7742d87-e61d-4b78-b8a1-b469842139fa}/latest.xpl";
          default_area = "menupanel";
        };
        # Cookie CURL Dumper
        "{12cf650b-1822-40aa-bff0-996df6948878}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/{12cf650b-1822-40aa-bff0-996df6948878}/latest.xpl";
          default_area = "menupanel";
        };
        # Violentmonkey
        "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/{aecec67f-0d10-4fa7-b7c7-609a2db280cf}/latest.xpl";
          default_area = "menupanel";
        };
        "sponsorBlocker@ajay.app" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorBlocker@ajay.app/latest.xpl";
          default_area = "menupanel";
        };
      };
    };
  };
}
