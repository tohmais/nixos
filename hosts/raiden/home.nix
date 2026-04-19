{
  lib,
  mainUser,
  ...
}: {
  hm = {
    stylix.image = ../../assets/wallhaven-9omr8k.png;

    home = {
      username = mainUser;
      homeDirectory = lib.mkDefault "/home/${mainUser}";
      stateVersion = "24.11";
    };
  };
}
