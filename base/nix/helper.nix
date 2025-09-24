{
  mainUser,
  config,
  ...
}: {
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };

  hm.home.sessionVariables = {
    NH_FILE = "/home/${mainUser}/nixos/entry.nix";
    NH_ATTRP = "nixosConfigurations.${config.networking.hostName}";
  };
}
