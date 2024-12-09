{
  config,
  pkgs,
  ...
}: {
  services.suwayomi-server = {
    enable = true;
    settings = {
      server = {
        extensionRepos = [
          "https://raw.githubusercontent.com/keiyoushi/extensions/repo/index.min.json"
        ];
        webUIEnabled = true;
        webUIInterface = "browser";
        webUIFlavor = "WebUI";
      };
    };
  };
}
