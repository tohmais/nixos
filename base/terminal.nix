{
  pkgs,
  config,
  ...
}: {
  programs.fish = {
    enable = true;
    useBabelfish = true;
    shellAliases = {
      "ls" = "eza --icons";
    };
  };

  programs.zoxide = {
    enable = true;
    flags = ["--cmd cd"];
  };

  hm = {
    programs = {
      oh-my-posh = {
        enable = true;
        settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (with config.hm.lib.stylix.colors.withHashtag; ''
          {
            "disable_notice": true,
            "auto_upgrade": false,
            "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
            "palette": {
              "os": "${base05}",
              "purple": "${base0E}",
              "pink": "${base0F}",
              "blue":  "${base0D}",
              "wight": "#FFFFFF",
              "text": "${base02}"
            },
            "blocks": [
              {
                "alignment": "left",
                "segments": [
                  {
                    "background": "p:blue",
                    "foreground": "p:wight",
                    "powerline_symbol": "\ue0b4",
                    "leading_diamond": "\ue0b6",
                    "style": "diamond",
                    "template": "{{.Icon}} ",
                    "type": "os"
                  },
                  {
                    "background": "p:blue",
                    "foreground": "p:text",
                    "powerline_symbol": "\ue0b4",
                    "style": "diamond",
                    "template": "{{.UserName}}@{{.HostName}}",
                    "type": "session"
                  },
                  {
                    "background": "p:pink",
                    "foreground": "p:text",
                    "powerline_symbol": "\ue0b4",
                    "style": "powerline",
                    "template": " {{.Path}}",
                    "type": "path"
                  },
                  {
                    "background": "p:purple",
                    "foreground": "p:text",
                    "style": "powerline",
                    "properties": {
                      "branch_icon": "\ue725 ",
                      "cherry_pick_icon": "\ue29b ",
                      "commit_icon": "\uf417 ",
                      "fetch_status": false,
                      "fetch_upstream_icon": false,
                      "merge_icon": "\ue727 ",
                      "no_commits_icon": "\uf0c3 ",
                      "rebase_icon": "\ue728 ",
                      "revert_icon": "\uf0e2 ",
                      "tag_icon": "\uf412 "
                    },
                    "powerline_symbol": "\ue0b4",
                    "template": " {{.HEAD}}",
                    "type": "git"
                  }
                ],
                "type": "prompt"
              }
            ],
            "final_space": true,
            "version": 3
          }


        ''));
      };
      fish.enable = true;
    };
    home.shell.enableFishIntegration = true;
  };

  environment.shells = [pkgs.fish];
  users.defaultUserShell = pkgs.fish;
}
