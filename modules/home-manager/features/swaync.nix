{...}: {
  services.swaync = {
    enable = true;
    settings = {
      notification-window-width = 400;
    };

    style = ''
      .notification-background {
        padding-right:5px;
      }

      .image {
        padding-right:5px;
        border-radius:5px;
      }

    '';
  };
}
