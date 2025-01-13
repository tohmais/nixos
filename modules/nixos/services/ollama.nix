{...}: {
  services.ollama = {
    enable = true;
    loadModels = ["phi4"];
    environmentVariables = {
      OLLAMA_ORIGINS = "moz-extension://*";
    };
  };
}
