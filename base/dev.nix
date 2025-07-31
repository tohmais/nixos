{pkgs, ...}: {
  hm = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
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
