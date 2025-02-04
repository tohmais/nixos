{
  pkgs,
  lib,
  config,
  ...
}: {
  myHomeManager = {
    bundles.general.enable = lib.mkDefault true;

    kitty.enable = lib.mkDefault true;
    hyprland.enable = lib.mkDefault config.sharedOptions.isWayland;
    rofi.enable = lib.mkDefault true;
    firefox.enable = lib.mkDefault true;
    chromium.enable = lib.mkDefault false;
    waybar.enable = lib.mkDefault config.sharedOptions.isWayland;
    emacs.enable = lib.mkDefault true;
    stylix.enable = lib.mkDefault true;
    ghostty.enable = lib.mkDefault true;
    vscodium.enable = lib.mkDefault true;
    foot.enable = lib.mkDefault config.sharedOptions.isWayland;
    fuzzel.enable = lib.mkDefault config.sharedOptions.isWayland;
  };

  gtk.enable = true;

  qt.enable = true;

  services.flatpak.packages = [
    "it.mijorus.gearlever"
    "com.github.tchx84.Flatseal"
  ];

  home.sessionVariables = {
    TERM = "${config.myHomeManager.terminal.name}";
    TERMINAL = "${config.myHomeManager.terminal.name}";
  };

  xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator=${config.myHomeManager.terminal.name}
    TerminalEmulatorDismissed=true
  '';

  services.mpris-proxy.enable = true;

  home.packages = with pkgs; [
    qownnotes
    libreoffice

    pwvucontrol
    mpv

    bottles
    zed-editor
    electron-mail
  ];
}
