{config, ...}: {
  programs.nh = builtins.mapAttrs (name: user: {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/${name}/nixos";
  }) (config.myNixOS.home-users);
}
