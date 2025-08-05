{...}: {
  hm.services.swaync = {
    enable = true;
    settings = {
      control-center-margin-top = 5;
      control-center-margin-bottom = 5;
      control-center-margin-right = 5;

      notification-window-width = 400;
      image-visibility = "when-available";
      widgets = ["mpris" "volume" "dnd" "title" "notifications"];
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
