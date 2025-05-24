{pkgs, ...}: {
  home.packages = with pkgs; [
    obs-studio
    krita
    kdePackages.kdenlive
    # davinci-resolve
  ];
}
