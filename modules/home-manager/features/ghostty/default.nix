{
  pkgs,
  config,
  ...
}: {
  xdg.configFile = {
    "ghostty/config".source = config.lib.file.mkOutOfStoreSymlink ./config;
  };
  home.packages = with pkgs; [
    ghostty
  ];
}
