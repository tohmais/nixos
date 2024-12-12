{ pkgs, ... }: {
  home.packages = with pkgs; [
    obs-studio
    krita
    kdenlive
    davinci-resolve
  ]
}