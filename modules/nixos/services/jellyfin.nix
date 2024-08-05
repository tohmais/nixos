{config, pkgs, ...}: {
  services.jellyfin = {
    enable = true;
    user = "callum";
    openFirewall = true;
  };

  environment.systemPackages = (with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ])
}
