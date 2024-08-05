{config, pkgs, ...}: {
  services.jellyfin = {
    enable = true;
    user = "callum";
    openFirewall = true;
  };
}
