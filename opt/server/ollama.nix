{...}: {
  services.ollama = {
    enable = true;
    loadModels = ["llama3:8b"];
    environmentVariables = {
      OLLAMA_ORIGINS = "moz-extension://*";
    };
  };
}
