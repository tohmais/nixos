{ pkgs, lib, ... }: {
  myHomeManager = {
    spicetify.enable = lib.mkDefault true;
    cava.enable = lib.mkDefault true;
    ncspot.enable = lib.mkDefault true;
  };
  
  home.packages = with pkgs; [
    sptlrx

    nicotine-plus
    picard
    ani-cli

    aria2
  ];
}
