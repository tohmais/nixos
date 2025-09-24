let
  create = import ./util/create.nix;
in {
  nixosConfigurations = create.systems {
    phos = {
      user = "callum";
      imports = [
        ./base
        ./workstation
        ./hosts/phos

        ./hardware/cpu/amd
        ./hardware/gpu/amd

        ./opt/wm/wayland
        ./opt/wm/hyprland

        ./opt/leisure
        ./opt/gaming
        ./opt/downloader
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
        ./hardware/laptop

        ./opt/wm/wayland
        ./opt/wm/hyprland

        ./opt/leisure
      ];
      system = "x86_64-linux";
    };
  };
}
