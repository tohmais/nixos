let
  create = import ./util/create.nix;
in {
  nixosConfigurations = create.systems {
    phos = {
      user = "callum";
      imports = [
        ./base
        ./workstation
        ./hardware/gpu/amd
        ./hardware/cpu/amd
        ./opt/gaming
        ./opt/wm/wayland
        ./opt/wm/hyprland
        ./opt/leisure
        ./opt/downloader
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
        ./hardware/cpu/intel
        ./hardware/gpu/nvidia/optimus
        ./opt/wm/wayland
        ./opt/wm/hyprland
        ./opt/leisure
      ];
      system = "x86_64-linux";
    };
  };
}
