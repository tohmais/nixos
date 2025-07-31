{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git
    eza
    curl
    wget
  ];

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

    uutils-coreutils-noprefix
  ];
}
