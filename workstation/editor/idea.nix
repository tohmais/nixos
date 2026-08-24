{pkgs, ...}: {
  hm.home.packages = [
    pkgs.jetbrains.idea
    pkgs.jdk
  ];
}
