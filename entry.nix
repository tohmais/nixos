let
  create = import ./util/create.nix;
in
{
  nixosConfigurations = create.systems {
    phos = {
      user = "callum";
      imports = [
        ./base
        ./graphical
        ./opt/gaming
        ./hosts/phos
      ];
      system = "x86_64-linux";
    };
    homesick = {
      user = "callum";
      imports = [
        ./base
        ./graphical
        ./hosts/homesick
      ];
      system = "x86_64-linux";
    };
  };
}
