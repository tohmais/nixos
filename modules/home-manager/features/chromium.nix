# Copyright (c) 2023 Yurii M
# Modified by Callum Wishart
{pkgs, ...}: {
  programs.chromium.enable = true;
  programs.chromium.package = pkgs.ungoogled-chromium;
}
