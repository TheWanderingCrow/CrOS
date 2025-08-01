{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages =
    if config.hostSpec.isMinimal
    then [
      inputs.nvix.packages.${pkgs.system}.mini
    ]
    else [
      inputs.nvix.packages.${pkgs.system}.default
    ];
}
