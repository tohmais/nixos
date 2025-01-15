{pkgs, ...}: {
  programs = {
    foot = {
      enable = true;
      enableZshIntegration = true;
      server.enable = false;
      settings = {
        main = {
          app-id = "foot";
          title = "foot";

          locked-title = "no";
        };
        tweak = {
          font-monospace-warn = "no";
        };
        cursor = {
          style = "beam";
        };
        mouse = {
          hide-when-typing = "yes";
        };
      };
    };
    zsh.interactiveShellInit = ". ${./zshrc} # enable shell integration for foot terminal";
  };

  home.packages = with pkgs; [libsixel];
}
