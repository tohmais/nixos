# Copyright (c) 2023 Yurii M
# Modified by Callum Wishart

{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types;
in {
  options.myHomeManager.monitors = mkOption {
    type = types.attrsOf (types.submodule {
      options = {
        primary = mkOption {
          type = types.bool;
          default = false;
        };
        width = mkOption {
          type = types.int;
          example = 1920;
        };
        height = mkOption {
          type = types.int;
          example = 1080;
        };
        refreshRate = mkOption {
          type = types.float;
          default = 60;
        };
        x = mkOption {
          type = types.int;
          default = 0;
        };
        y = mkOption {
          type = types.int;
          default = 0;
        };
        enabled = mkOption {
          type = types.bool;
          default = true;
        };
        # workspace = mkOption {
        #   type = types.nullOr types.str;
        #   default = null;
        # };
      };
    });
    default = {};
  };
}
