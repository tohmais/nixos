{pkgs, ...}: {
  hm = {
    programs.direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
        package = pkgs.lixPackageSets.git.nix-direnv;
      };
    };

    home.packages = with pkgs; [
      gh

      nix-prefetch-scripts
      nixd
      alejandra
      nix-search-cli
    ];
  };
}
