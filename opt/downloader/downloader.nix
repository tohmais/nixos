{pkgs, ...}: {
  hm.home.packages = with pkgs; [
    qbittorrent
    nicotine-plus
    picard
    ani-cli
    hydralauncher

    aria2

    # get FUCKED jdownloader
    gopeed
  ];
}
