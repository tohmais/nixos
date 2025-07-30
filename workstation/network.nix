{mainUser, ...}: {
  networking.networkmanager.enable = true;
  users.users.${mainUser}.extraGroups = ["networkmanager"];
}
