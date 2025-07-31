{pkgs, ...}: {
  programs.fish = {
    enable = true;
    useBabelfish = true;
    shellAliases = {
      "ls" = "eza --icons";
    };
  };

  programs.zoxide = {
    enable = true;
    flags = ["--cmd cd"];
  };

  environment.shells = [pkgs.fish];
  users.defaultUserShell = pkgs.fish;
  hm = {
    home.shell.enableFishIntegration = true;
    programs.fish.enable = true;
  };
}
