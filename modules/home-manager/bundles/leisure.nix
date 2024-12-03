{ pkgs, lib, ... }: {
  myHomeManager = {
    spicetify.enable = lib.mkDefault true;
  };
  
  home.packages = with pkgs; [
    ncspot
    cava
    sptlrx

    nicotine-plus
    picard
    ani-cli

    aria2
  ];
}
