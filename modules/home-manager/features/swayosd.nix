{pkgs, ...}: {
  services.swayosd = {
    enable = true;
    package = pkgs.unstable.swayosd;
  };
}
