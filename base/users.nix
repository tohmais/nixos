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
