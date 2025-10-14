# Copied from https://git.atagen.co/atagen/nix/src/commit/353499a037fd01ebfa373ba3047e92083eb4bdb8/util/create.nix
# The original licence is included in the file LICENCE at the root of this project.
let
  lock = builtins.fromJSON (builtins.readFile ../flake.lock);
  node = lock.nodes.root.inputs.flake-compat;
  inherit (lock.nodes.${node}.locked) narHash rev url;
  flake-compat = builtins.fetchTarball {
    url = "${url}/archive/${rev}.tar.gz";
    sha256 = narHash;
  };
  flake = import flake-compat {
    src = ../.;
    copySourceTreeToStore = false;
    useBuiltinsFetchTree = true;
  };
in
  flake.inputs
