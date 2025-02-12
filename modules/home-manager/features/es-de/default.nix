{config, ...}: {
  home.file = {
    "ES-DE/custom_systems/es_find_rules.xml".source = config.home {
      template = builtins.readFile ./es_find_rules.xml.mustache;
      extension = ".xml";
    };
  };
}
