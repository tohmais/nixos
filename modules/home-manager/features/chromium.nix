{ pkgs, ...}: {
  programs.chromium.enable = true;
  programs.chromium.package = pkgs.ungoogled-chromium;
}