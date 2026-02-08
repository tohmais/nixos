{
  mainUser,
  pkgs,
  ...
}: {
  hm = {
    home.file = {
      "ES-DE/custom_systems/es_find_rules.xml"
    
    # .source = renderMustache {
    #   template = ./es_find_rules.xml.mustache;
    #   data = { username = config.home.username;};
    # };
    
    .text = ''
        <ruleList>
            <core name="RETROARCH">
                <rule type="corepath">
                    <!-- NixOS / Nixpkgs -->
                    <entry>/run/current-system/sw/lib/retroarch/cores</entry>
                    <entry>/etc/profiles/per-user/${mainUser}/lib/retroarch/cores</entry>
                </rule>
            </core>
        </ruleList>
      '';
    };
    services.flatpak.packages = [
      "com.fightcade.Fightcade"
    ];
    home.packages = with pkgs; [
      dolphin-emu
      ryubing
      gopher64
      # parallel-launcher TODO: uncomment when https://github.com/NixOS/nixpkgs/pull/485839 is merged.
      rpcs3
      pcsx2
      xemu
      mesen

      ares

      (retroarch.withCores (
        cores:
          with libretro; [
            snes9x
            genesis-plus-gx
            beetle-saturn
            melonds
            mgba
            sameboy
          ]
      ))
    ];
  };
}
