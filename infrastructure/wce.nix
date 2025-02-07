{...}: {
  terraform.required_providers = {
    digitalocean = {
      source = "digitalocean/digitalocean";
      version = "2.48.2";
    };
  };

  resource."digitalocean_droplet"."do-wce-lighthouse1" = {
    image = "177939596"; # nixos-digitalocean
    name = "do-wce-lighthouse1";
    region = "nyc3";
    size = "s-1vcpu-1gb";
    ssh_keys = ["45378200"];
  };
}
