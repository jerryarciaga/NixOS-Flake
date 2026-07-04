{ pkgs, ... }:

{

  # Login manager
  programs.regreet = {
    enable = true;
    theme = {
      name = "Gruvbox";
      package = pkgs.gruvbox-dark-gtk;
    };
    settings = {
      GTK = {
        application_prefer_dark_theme = true;
        cursor_blink = true;
        font_name = "Cantarell 16";
      };
      background = {
        path = ./background/gruv-abstract-maze.png;
        fit = "Fill";
      };
      commands = {
        reboot = ["systemctl" "reboot"];
        poweroff = ["systemctl" "poweroff"];
      };
    };
  };
  

  # Niri window manager
  programs.niri.enable = true;

  systemd.user.services.niri.enableDefaultPath = false;

  # Niri dependencies
  environment.systemPackages = with pkgs; [
    brightnessctl
  ];

}
