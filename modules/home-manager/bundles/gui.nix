{ pkgs, lib, ... }: {
  myHomeManager = {
    gbar.enable = lib.mkDefault true;
    vesktop.enable = lib.mkDefault true;
    kitty.enable = lib.mkDefault true;
    hyprland.enable = lib.mkDefault true;
    spicetify.enable = lib.mkDefault true;
  };

  
  home.packages = with pkgs; [
    vscodium
    obs-studio
    ncspot
    cava
    pwvucontrol
  ]
}