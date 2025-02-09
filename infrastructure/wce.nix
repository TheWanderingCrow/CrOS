{...}: {
  terraform = {
    required_providers = {
      digitalocean = {
        source = "digitalocean/digitalocean";
        version = "2.48.2";
      };
      aws = {
        source = "hashicorp/aws";
        version = "5.86.0";
      };
      cloudflare = {
        source = "cloudflare/cloudflare";
        version = "5.0.0";
      };
    };
    backend."s3" = {
      bucket = "wce-20250207201121178400000001";
      key = "terraform.tfstate";
      region = "us-east-1";
    };
  };

  provider."aws" = {
    region = "us-east-1";
    profile = "wce";
  };

  resource = {
    "aws_s3_bucket"."state" = {
      bucket_prefix = "wce-";
      tags = {
        Name = "WCE State Bucket";
      };
    };

    "cloudflare_r2_bucket"."cache" = {
      account_id = "68c4b3ab47c1a97037ab5a938f772d69";
      name = "wce-attic-cache";
      storage_class = "Standard";
    };

    #"digitalocean_droplet"."do-wce-lighthouse1" = {
    #  image = "177939596"; # nixos-digitalocean
    #  name = "WCE-Lighthouse1";
    #  region = "nyc3";
    #  size = "s-1vcpu-1gb";
    #  ssh_keys = ["45378200"];
    #};
  };
}
