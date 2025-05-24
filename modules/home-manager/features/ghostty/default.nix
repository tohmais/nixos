{
  pkgs,
  config,
  ...
}: {
  xdg.configFile = {
    "ghostty/config".source = ./config;
  };
  home.packages = with pkgs; [
    ghostty
  ];
}
