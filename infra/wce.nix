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
      b2 = {
        source = "Backblaze/b2";
        version = "0.10.0";
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

    "b2_bucket"."media" = {
      bucket_name = "wce-media-backup";
      bucket_type = "allPrivate";
      lifecycle_rules = {
        file_name_prefix = "";
        days_from_uploading_to_hiding = 1;
        days_from_hiding_to_deleting = 1;
      };
    };
  };
}
