{pkgs, ...}: {
  hm.home.packages = with pkgs; [
    gimp3
    obs-studio
    krita
    kdePackages.kdenlive
    pinta
  ];
}
