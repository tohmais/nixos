# Copied from https://git.atagen.co/atagen/nix/src/commit/353499a037fd01ebfa373ba3047e92083eb4bdb8/common/users.nix.
{mainUser, ...}: {
  nix.settings.trusted-users = [mainUser];
  users.users.${mainUser} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];
  };

  hm.config.home = {
    username = mainUser;
    homeDirectory = "/home/${mainUser}";
  };
}
