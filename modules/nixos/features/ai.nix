{...}: {
  services.ollama = {
    enable = true;
    loadModels = [phi4];
    environmentVariables = {
      OLLAMA_ORIGINS = "moz-extension://b764208e-0a98-436d-a599-c1baa044f829";
    };
  };
}
