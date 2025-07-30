{pkgs, ...}: {
  hm = {
    home.packages = with pkgs; [
      neovide
      nodejs
    ];
  };
}
