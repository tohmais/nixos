{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git
    eza
    curl
    wget
  ];

  documentation.man.cache.enable = false;
  hm.home.packages = with pkgs; [
    ripgrep
    bat
    zellij
    dua
    btop
    lazygit
    fd
    ouch
    fzf
    tealdeer
    p7zip

    uutils-coreutils-noprefix
  ];
}
