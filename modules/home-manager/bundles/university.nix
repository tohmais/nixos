{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    zoom-us
    jdk
  ];
}