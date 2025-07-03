{
  pkgs,
  inputs,
  ...
}: {
  # imports = [inputs.lix-module.nixosModules.default];
  nix.package = pkgs.unstable.lix;
}
