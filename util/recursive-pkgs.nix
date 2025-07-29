{ lib }:
let
  getFiles =
    path:
    builtins.filter (i: lib.hasSuffix ".nix" (builtins.toString i)) (
      lib.filesystem.listFilesRecursive path
    );
  getPkgsAttrs =
    path:
    let
      prefix = builtins.toString path;
    in
    map (
      file:
      let
        name = lib.pipe file [
          builtins.toString
          (lib.removePrefix (prefix + "/"))
          (lib.removeSuffix ".nix")
        ];
      in
      {
        "${name}" = file;
      }
    ) (getFiles path);
  getAllPkgs = path: lib.mergeAttrsList (getPkgsAttrs path);
in
getAllPkgs
