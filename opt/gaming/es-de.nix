{mainUser, ...}: let
  # renderMustache = inputs.tohmutils.lib.renderMustache;
in {
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
}
