{ pkgs, lib, ... }: {
  myHomeManager = {
    spicetify.enable = lib.mkDefault true;
    cava.enable = lib.mkDefault true;
    ncspot.enable = lib.mkDefault true;
    sptlrx.enable = lib.mkDefault true;
    rescrobbled.enable = lib.mkDefault true;
  };
  
  home.packages = with pkgs; [
    cbonsai

    nicotine-plus
    picard
    ani-cli

    aria2
  ];
}
