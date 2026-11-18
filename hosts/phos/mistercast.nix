{
  userPkgs,
  mainUser,
  ...
}: {
  networking.firewall.interfaces.enp42s0.allowedUDPPorts = [53 67 32100];

  networking.networkmanager.ensureProfiles.profiles = {
    mister-direct = {
      connection = {
        id = "mister-direct";
        type = "ethernet";
        interface-name = "enp42s0";
        autoconnect = true;
      };
      ipv4.method = "shared";
      ipv6.method = "ignore";
    };
  };

  hm = {
    home.packages = [userPkgs.mistercast-linux];
    xdg.configFile."MiSTerCast/MiSTerCast/modelines.dat".source = ./modelines.dat;
  };
  hardware.uinput.enable = true;
  users.users.${mainUser}.extraGroups = ["uinput"];
}
