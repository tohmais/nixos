# Copyright (c) 2023 Yurii M
# Modified by Callum Wishart
{pkgs ? import ./nixpkgs.nix {}}: {
  default = pkgs.mkShell {
    NIX_CONFIG = "experimental-features = nix-command flakes";
    
    nativeBuildInputs = with pkgs; [nix nh home-manager git neovim];
  };
}
