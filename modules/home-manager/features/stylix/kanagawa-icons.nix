{pkgs}: {
  pkgs.stdenv.mkDerivation {
    name = "kanagawa-icon-theme";
    version = "0-unstable-2023-07-03";

    src = fetchFromGitHub {
      owner = "Fausto-Korpsvart";
      repo = "Kanagawa-GKT-Theme";
      rev = "35936a1e3bbd329339991b29725fc1f67f192c1e";
      hash = "sha256-BZRmjVas8q6zsYbXFk4bCk5Ec/3liy9PQ8fqFGHAXe0=";
    };

    installPhase = ''
      mkdir -p $out/share/icons
      cp -a icons/* $out/share/icons
    ''; 
  }
}