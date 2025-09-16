# Copied from https://git.atagen.co/atagen/nix/src/commit/353499a037fd01ebfa373ba3047e92083eb4bdb8/util/recursively-import.nix
# The original licence is included in the file LICENCE at the root of this project.
{lib}: let
  recurseIntoFolders = elem:
    if lib.isPath elem && lib.pathIsDirectory elem
    then lib.filesystem.listFilesRecursive elem
    else
      # If it's not a folder, return it unchanged. This handles single-files and
      # literal modules (written with {} syntax)
      lib.singleton elem;

  filterNixFiles = paths:
    builtins.filter
    # filter the files for `.nix` files. if it's not a file, it can stay.
    (path: !builtins.isPath path || lib.hasSuffix ".nix" path)
    # Expand any folders into all the files within them. Note that this comes
    # BEFORE the filtering that's happening above
    (builtins.concatMap recurseIntoFolders paths);
in
  filterNixFiles
