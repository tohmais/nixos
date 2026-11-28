{inputs, ...}: {
  imports = [inputs.tack.nixosModules.default];
  programs.tack.enable = true;
  disabledModules = ["programs/tack.nix"];
}
