let
  create = import ./util/create.nix;
in {
  nixosConfigurations = create.systems {
    phos = {
      user = "callum";
      imports = [
        ./base
        ./workstation
        ./opt/gaming
        ./hosts/phos
      ];
      system = "x86_64-linux";
    };
    homesick = {
      user = "callum";
      imports = [
        ./base
        ./workstation
        ./hosts/homesick
      ];
      system = "x86_64-linux";
    };
  };
}
