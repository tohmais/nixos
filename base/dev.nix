{pkgs, ...}: {
  hm = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    home.packages = with pkgs; [
      git
      gh
      wget

      uutils-coreutils-noprefix
      p7zip

      nix-prefetch-scripts
      nixd
      alejandra
      nix-search-cli
    ];
  };
}
