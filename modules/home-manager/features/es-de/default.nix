{
  config,
  mkMustache,
  ...
}: {
  home.file = {
    "ES-DE/custom_systems/es_find_rules.xml".source = mkMustache "es_find_rules.xml" ./es_find_rules.xml.mustache config.home;
  };
}
