{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    distrobox

    pipx
    cargo-binstall
  ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  environment.localBinInPath = true;
  # I want to get shit done
  # (shoutout to this goated reddit comment https://www.reddit.com/r/NixOS/comments/1g4g1mp/comment/ls3kmzj)
  services.envfs.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      (pkgs.runCommand "steamrun-lib" {} "mkdir $out; ln -s ${pkgs.steam-run.fhsenv}/usr/lib64 $out/lib")
    ];
  };
}
