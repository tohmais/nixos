{config, ...}: let
  homeUser = builtins.head (builtins.attrNames config.myNixOS.home-users);
in {
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/${homeUser}/nixos";
  };
}
