{inputs, ...}: {
  hm = {
    /*
       imports = [
      inputs.nix-index-database.homeModules.nix-index
    ];
    */
    programs.nix-index = {
      enable = true;
    };
  };
}
