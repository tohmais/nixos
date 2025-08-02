{pkgs, ...}: {
  hm.home.packages = with pkgs; [
    qbittorrent
    nicotine-plus
    picard
    ani-cli
    miru
    hydralauncher

    aria2

    # i wish jdownloader would stop lying about being FOSS
    # so use this and megabasterd
    motrix
  ];
}
