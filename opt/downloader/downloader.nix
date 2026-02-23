{pkgs, ...}: {
  hm.home.packages = with pkgs; [
    qbittorrent
    nicotine-plus
    picard
    ani-cli
    hydralauncher

    aria2

    webtorrent_desktop

    # get FUCKED jdownloader
    gopeed
  ];
}
