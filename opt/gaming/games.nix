{
  userPkgs,
  pkgs,
  ...
}: {
  hm = {
    services.flatpak.packages = [
      "io.github.doukutsu_rs.doukutsu-rs"
      "org.sonic3air.Sonic3AIR"
    ];
  };
  environment = {
    systemPackages = with pkgs; [
      hidapi
      libudev-zero
      systemdLibs
      libudev0-shim
      (userPkgs.yarc-launcher)
      yarg
    ];
    sessionVariables = {
      DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = 1;
    };
  };
  boot.kernelModules = ["ntsync"];
  services.udev.packages = [
    (pkgs.writeTextDir "etc/udev/rules.d/69-hid.rules" ''
      KERNEL=="hidraw*", TAG+="uaccess"
    '')
    (pkgs.writeTextDir "etc/udev/rules.d/99-yarg-libusb.rules" ''
      SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="0291", MODE="0666"
      SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="02a9", MODE="0666"
      SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="0719", MODE="0666"
    '')
    (pkgs.writeTextDir "etc/udev/rules.d/68-santroller.rules" ''


      # Ardwiino
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="2882", MODE="666", TAG+="uaccess", TAG+="udev-acl"
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="2883", MODE="666", TAG+="uaccess", TAG+="udev-acl"
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="2886", MODE="666", TAG+="uaccess", TAG+="udev-acl"

      # Switch
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="0f0d", ATTRS{idProduct}=="0092", MODE="666", TAG+="uaccess", TAG+="udev-acl"

      # PS3
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="12ba", ATTRS{idProduct}=="0100", MODE="666", TAG+="uaccess", TAG+="udev-acl"
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="12ba", ATTRS{idProduct}=="0120", MODE="666", TAG+="uaccess", TAG+="udev-acl"
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="12ba", ATTRS{idProduct}=="0140", MODE="666", TAG+="uaccess", TAG+="udev-acl"
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="12ba", ATTRS{idProduct}=="0200", MODE="666", TAG+="uaccess", TAG+="udev-acl"
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="12ba", ATTRS{idProduct}=="0210", MODE="666", TAG+="uaccess", TAG+="udev-acl"
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="12ba", ATTRS{idProduct}=="074b", MODE="666", TAG+="uaccess", TAG+="udev-acl"

      # Wii
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="1bad", ATTRS{idProduct}=="0004", MODE="666", TAG+="uaccess", TAG+="udev-acl"
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="1bad", ATTRS{idProduct}=="0005", MODE="666", TAG+="uaccess", TAG+="udev-acl"
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="1bad", ATTRS{idProduct}=="3010", MODE="666", TAG+="uaccess", TAG+="udev-acl"
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="1bad", ATTRS{idProduct}=="3110", MODE="666", TAG+="uaccess", TAG+="udev-acl"

      # Broken ids from old fw
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="1bad", ATTRS{idProduct}=="074b", MODE="666", TAG+="uaccess", TAG+="udev-acl"
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="0112", ATTRS{idProduct}=="0f0d", MODE="666",TAG+="uaccess", TAG+="udev-acl"

      # Guitar Praise
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="0314", ATTRS{idProduct}=="0830", MODE="666",TAG+="uaccess", TAG+="udev-acl"

      # Atmel DFU
      ### ATmega16U2
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2fef", MODE="666",TAG+="uaccess", TAG+="udev-acl"
      ### ATmega32U2
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ff0", MODE="666",TAG+="uaccess", TAG+="udev-acl"
      ### ATmega16U4
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ff3", MODE="666",TAG+="uaccess", TAG+="udev-acl"
      ### ATmega32U4
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ff4", MODE="666",TAG+="uaccess", TAG+="udev-acl"
      ### AT90USB64
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ff9", MODE="666",TAG+="uaccess", TAG+="udev-acl"
      ### AT90USB162
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ffa", MODE="666",TAG+="uaccess", TAG+="udev-acl"
      ### AT90USB128
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ffb", MODE="666",TAG+="uaccess", TAG+="udev-acl"

      # Input Club
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="1c11", ATTRS{idProduct}=="b007", MODE="666",TAG+="uaccess", TAG+="udev-acl"

      # STM32duino
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="1eaf", ATTRS{idProduct}=="0003", MODE="666",TAG+="uaccess", TAG+="udev-acl"
      # STM32 DFU
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE="666",TAG+="uaccess", TAG+="udev-acl"

      # BootloadHID
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="05df", MODE="666",TAG+="uaccess", TAG+="udev-acl"

      # USBAspLoader
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="05dc", MODE="666",TAG+="uaccess", TAG+="udev-acl"

      # ModemManager should ignore the following devices
      # Atmel SAM-BA (Massdrop)
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="6124", MODE="666",TAG+="uaccess", TAG+="udev-acl", ENV{ID_MM_DEVICE_IGNORE}="1"

      # Caterina (Pro Micro)
      ## Spark Fun Electronics
      ### Pro Micro 3V3/8MHz
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="1b4f", ATTRS{idProduct}=="9203", MODE="666",TAG+="uaccess", TAG+="udev-acl", ENV{ID_MM_DEVICE_IGNORE}="1"
      ### Pro Micro 5V/16MHz
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="1b4f", ATTRS{idProduct}=="9205", MODE="666",TAG+="uaccess", TAG+="udev-acl", ENV{ID_MM_DEVICE_IGNORE}="1"
      ### LilyPad 3V3/8MHz (and some Pro Micro clones)
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="1b4f", ATTRS{idProduct}=="9207", MODE="666",TAG+="uaccess", TAG+="udev-acl", ENV{ID_MM_DEVICE_IGNORE}="1"
      ## Pololu Electronics
      ### A-Star 32U4
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="1ffb", ATTRS{idProduct}=="0101", MODE="666",TAG+="uaccess", TAG+="udev-acl", ENV{ID_MM_DEVICE_IGNORE}="1"
      ## Arduino SA
      ### Leonardo
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="2341", ATTRS{idProduct}=="0036", MODE="666",TAG+="uaccess", TAG+="udev-acl", ENV{ID_MM_DEVICE_IGNORE}="1"
      ### Micro
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="2341", ATTRS{idProduct}=="0037", MODE="666",TAG+="uaccess", TAG+="udev-acl", ENV{ID_MM_DEVICE_IGNORE}="1"
      ## Adafruit Industries LLC
      ### Feather 32U4
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="239a", ATTRS{idProduct}=="000c", MODE="666",TAG+="uaccess", TAG+="udev-acl", ENV{ID_MM_DEVICE_IGNORE}="1"
      ### ItsyBitsy 32U4 3V3/8MHz
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="239a", ATTRS{idProduct}=="000d", MODE="666",TAG+="uaccess", TAG+="udev-acl", ENV{ID_MM_DEVICE_IGNORE}="1"
      ### ItsyBitsy 32U4 5V/16MHz
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="239a", ATTRS{idProduct}=="000e", MODE="666",TAG+="uaccess", TAG+="udev-acl", ENV{ID_MM_DEVICE_IGNORE}="1"
      ## dog hunter AG
      ### Leonardo
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="2a03", ATTRS{idProduct}=="0036", MODE="666",TAG+="uaccess", TAG+="udev-acl", ENV{ID_MM_DEVICE_IGNORE}="1"
      ### Micro
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="2a03", ATTRS{idProduct}=="0037", MODE="666",TAG+="uaccess", TAG+="udev-acl", ENV{ID_MM_DEVICE_IGNORE}="1"

      # hid_listen
      KERNEL=="hidraw*", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
    '')
  ];
}
