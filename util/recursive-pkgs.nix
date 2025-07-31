# Copied from https://git.atagen.co/atagen/nix/src/commit/353499a037fd01ebfa373ba3047e92083eb4bdb8/util/recursive-pkgs.nix
{lib}: let
  getFiles = path:
    builtins.filter (i: lib.hasSuffix ".nix" (builtins.toString i)) (
      lib.filesystem.listFilesRecursive path
    );
  getPkgsAttrs = path: let
    prefix = builtins.toString path;
  in
    map (
      file: let
        name = lib.pipe file [
          builtins.toString
          (lib.removePrefix (prefix + "/"))
          (lib.removeSuffix ".nix")
        ];
      in {
        "${name}" = file;
      }
    ) (getFiles path);
  getAllPkgs = path: lib.mergeAttrsList (getPkgsAttrs path);
in
  getAllPkgs
