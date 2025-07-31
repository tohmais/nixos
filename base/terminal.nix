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
    options = ["--cmd cd"];
  };

  environment.shells = [pkgs.fish];
  users.defaultUserShell = pkgs.fish;
}
