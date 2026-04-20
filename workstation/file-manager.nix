{
  config,
  pkgs,
  ...
}: {
  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
    };
    xfconf.enable = true;
  };
  hm.xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator=${config.hm.home.sessionVariables."TERMINAL"}
    TerminalEmulatorDismissed=true
  '';
  xdg.mime.defaultApplications = {
    "inode/directory" = ["thunar.desktop"];
    "x-scheme-handler/terminal" = ["${config.hm.home.sessionVariables."TERMINAL"}.desktop"];
  };
  environment.systemPackages = with pkgs; [
    file-roller
  ];
  hm.home.packages = with pkgs; [
    yazi
  ];
  services = {
    gvfs.enable = true;
    tumbler.enable = true;
  };
}
