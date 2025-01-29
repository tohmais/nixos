{...}: {
  services.ollama = {
    enable = true;
    loadModels = ["deepseek-r1:14b"];
    environmentVariables = {
      OLLAMA_ORIGINS = "moz-extension://*";
    };
  };
}
