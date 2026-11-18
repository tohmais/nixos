{pkgs, ...}: {
  hm = {
    home.packages = with pkgs; [
      # neovide TODO: fix when https://github.com/NixOS/nixpkgs/pull/583658 is in nixos-unstable
      nodejs
      zls
    ];
  };
}
