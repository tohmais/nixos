{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git
    eza
    curl
    wget
  ];

  hm.homePackages = with pkgs; [
    ripgrep
    bat
    zellij
    dua
    btop
    lazygit
    fd
    ouch

    uutils-coreutils-noprefix
  ];
}
