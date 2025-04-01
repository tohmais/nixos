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

  services.flatpak.packages = [
    "chat.revolt.RevoltDesktop"
  ];

  home.packages = with pkgs; [
    cbonsai
    fastfetch
    pipes-rs
    neo

    pinta
    gimp

    vesktop
    element-desktop

    unstable.rescrobbled
    unstable.sptlrx
  ];
}
