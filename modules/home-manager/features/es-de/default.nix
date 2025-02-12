{config, ...}: {
  home.file = {
    "ES-DE/custom_systems/es_find_rules.xml".text = ''
      <ruleList>
            <core name="RETROARCH">
                <rule type="corepath">
                    <!-- NixOS / Nixpkgs -->
                    <entry>/run/current-system/sw/lib/retroarch/cores</entry>
                    <entry>/etc/profiles/per-user/${config.home.username}/lib/retroarch/cores</entry>
                </rule>
            </core>
        </ruleList>
    '';
  };
}
