{
  pkgs,
  lib,
  inputs,
  ...
}: {
  myHomeManager = {
    bundles.gui.enable = lib.mkDefault true;

    spicetify.enable = lib.mkDefault true;
    cava.enable = lib.mkDefault true;
    ncspot.enable = lib.mkDefault true;
    discord.enable = lib.mkDefault true;
  };

  home.packages = with pkgs; [
    cbonsai
    fastfetch
    pipes-rs
    neo

    pinta
    gimp

    vesktop
    unstable.revolt-desktop
    element-desktop

    unstable.rescrobbled
    unstable.sptlrx
  ];
}
