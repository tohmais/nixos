{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.gBar.homeManagerModules.${pkgs.system}.default];

  programs.gBar = {
    enable = true;
    config = {
      Location = "T";
      EnableSNI = true;
      SNIIconSize = {
        Discord = 26;
        OBS = 23;
      };
    };
    extraConfig = "
        ShutdownIcon: \s
        ";
    extraCSS = "";
  };
}
