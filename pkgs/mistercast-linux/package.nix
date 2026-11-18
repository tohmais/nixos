{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  ninja,
  pkg-config,
  qt6,
  pipewire,
  lz4,
}:
stdenv.mkDerivation {
  pname = "mistercast-linux";
  version = "0-unstable-2026-10-17";

  src = fetchFromGitHub {
    owner = "asdgdg355235"; # fork with the Scaling selector and mpv controller support
    repo = "mistercast-linux";
    rev = "7e794f9260d236b90af524ed418d5a467353aa4a";
    hash = "sha256-+898A44me/5rXLijfHLNTiu6NJeAJflMOVPYa9IYKnc=";
  };

  patches = [
    # Adds a "Crop" option (4:3 / Match output mode / None) to the Framing group
    ./mistercast-aspect-crop.patch
    # Adds "Virtual gamepad for games" to the MiSTer controllers option: exposes the
    # MiSTer's controllers as Xbox 360-layout uinput pads for SDL, Wine/Proton and Steam.
    # Needs hardware.uinput.enable = true and the user in the "uinput" group.
    ./mistercast-virtual-gamepad.patch
    # Lets the video delivery reserve shrink to the measured requirement (about
    # 3 ms on a wired LAN instead of a fixed 6-8 ms), backing off on frame skips.
    ./mistercast-delivery-margin.patch
  ];

  nativeBuildInputs = [
    cmake
    ninja
    pkg-config
    qt6.wrapQtAppsHook # sets Qt plugin paths so the GUI starts on NixOS
  ];

  buildInputs = [
    qt6.qtbase
    qt6.qtwayland
    pipewire
    lz4
  ];

  cmakeFlags = ["-DCMAKE_BUILD_TYPE=Release"];

  # Upstream runs ctest. The controller tests use loopback sockets only, and the
  # virtual gamepad test fakes uinput, so they run inside the sandbox.
  doCheck = true;

  meta = {
    description = "Low-latency Wayland desktop and PipeWire audio streaming to the Groovy_MiSTer core";
    homepage = "https://github.com/asdgdg355235/mistercast-linux";
    license = lib.licenses.unlicense;
    platforms = lib.platforms.linux;
    mainProgram = "mistercast";
  };
}
