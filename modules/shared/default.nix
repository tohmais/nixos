{
  myLib,
  config,
  inputs,
  ...
}: let
  opts = myLib.filesIn ./options;
in {
  imports =
    []
    ++ opts;

  config = {
    nixpkgs = {
      overlays = [
        (final: _prev: {
          # unstable overlay
          unstable = import inputs.nixpkgs-unstable {
            system = final.system;
            config.allowUnfree = true;
          };
        })
      ];

      config.allowUnfree = true;
    };
  };
}
