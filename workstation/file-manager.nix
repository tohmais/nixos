{
  config,
  pkgs,
  lib,
  ...
}: {
  options.internal-config.thunar = {
    enable = lib.mkEnableOption "enable thunar config stuff" // {default = true;};
  };

  config = lib.mkMerge [
    {
      hm.programs.yazi = {
        enable = true;
        shellWrapperName = "y";
        enableFishIntegration = true;
        plugins = {
          mount = pkgs.yaziPlugins.mount;
        };
        keymap = {
          mgr.prepend_keymap = [
            {
              run = ["shell -- for path in %s; do echo \"file://$path\"; done | wl-copy -t text/uri-list" "yank"];
              on = ["y"];
            }
            {
              on = ["M"];
              run = "plugin mount";
            }
          ];
        };
      };

      services.udisks2.enable = true;
    }

    (lib.mkIf config.internal-config.thunar.enable {
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
      services = {
        gvfs.enable = true;
        tumbler.enable = true;
      };
    })
  ];
}
