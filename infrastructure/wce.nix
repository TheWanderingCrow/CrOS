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

  resource."aws_s3_bucket"."state" = {
    bucket_prefix = "wce-";
    tags = {
      Name = "WCE State Bucket";
    };
  };

  #resource."digitalocean_droplet"."do-wce-lighthouse1" = {
  #  image = "177939596"; # nixos-digitalocean
  #  name = "do-wce-lighthouse1";
  #  region = "nyc3";
  #  size = "s-1vcpu-1gb";
  #  ssh_keys = ["45378200"];
  #};
}
