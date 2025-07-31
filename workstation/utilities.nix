{pkgs, ...}: {
  hm = {home.packages = with pkgs; [
    dua
    btop
    mission-center
    
    bottles
  ];
  };
}