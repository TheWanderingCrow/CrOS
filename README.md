# Crow's NixOS configuration project

## Proxmox/LXC target

`nix run github:nix-community/nixos-generators -- --format proxmox-lxc`

## Building the Live ISO

`nixos-generate --format install-iso --flake .#Parzival-Live -o result`

## Formatting disks with disko

`sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount <disk config path>`

## Deploying to the remote

Note: If you need to specify the ssh key, you may inject extra cli options to
the ssh command via the NIX_SSHOPTS environment variable

- Anywhere from local:
  `nixos-rebuild switch --flake .#<host> --target-host root@<ipaddr> --use-remote-sudo`

## Vendor Specific Idiosyncrasies

### Digital Ocean

You will need to import the following module to be able to build NixOS on DO:
`"${nixpkgs}/nixos/modules/virtualisation/digital-ocean-image.nix"`

Digital Ocean assigns IPs through cloud init so we need to not use DHCP

```
networking.useDHCP = nixpkgs.lib.mkForce false;
services.cloud-init = {
    enable = true;
    network.enable = true;
};
```

### AWS

You will need to import the following module to be able to build NixOS on EC2:
`"${nixpkgs}/nixos/modules/virtualisation/amazon-image.nix"`
