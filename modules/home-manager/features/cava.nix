{ config, ... }: 

with config.lib.stylix.colors.withHashtag;

{
  programs.cava = {
    enable = true;
    settings = {
      input.method = "pipewire";
      color = {
        gradient = 1;
        gradient_color_1 = "'${base0C}'";
	gradient_color_2 = "'${base0D}'";
	gradient_color_3 = "'${base0D}'";
        gradient_color_4 = "'${base0E}'";
        gradient_color_5 = "'${base0E}'";
        gradient_color_6 = "'${base0E}'";
        gradient_color_7 = "'${base08}'";
	gradient_color_8 = "'${base09}'";
      };
    };
  };
}
