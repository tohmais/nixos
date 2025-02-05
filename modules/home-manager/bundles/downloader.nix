{pkgs, ...}: {
  myHomeManager = {
    bundles.leisure.enable = true;
  };

  home.packages = with pkgs; [
    qbittorrent
    nicotine-plus
    picard
    ani-cli

    aria2


  ];
}