{ config, ... }:
{
  # Desktop shell: wallpaper, bar, launcher, notifications and theming.
  programs.serpantinum = {
    enable = true;
    systemd.enable = true;

    settings = {
      # Wallpapers are chosen from ~/wall.
      wallpaperDir = "${config.home.homeDirectory}/wall";

      # Russian UI, metric weather, refresh every 30 minutes.
      general = {
        language = "ru";
        weatherUnit = "metric";
        weatherInterval = 30;
      };

      # Must match output "eDP-1" { scale ... } in dot/niri.nix.
      display.monitors."eDP-1".scale = 1.2;

      # Top bar layout.
      bar = {
        position = "top";
        style = "solid";
        width = 58;
        height = 38;
        opacity = 100;
        autohide = false;
        autohideTimeout = 1000;
        # Matches Mod+1..Mod+9 in dot/niri.nix.
        workspaceCount = 9;
        distinctPills = false;
        centerByEdges = true;
        mediaInfoMode = "duration";
        groupColors = {
          g_kb = "#c9bfff";
        };
        time.format = "HH:mm:ss";
        modules = {
          left = [
            "workspaces"
            "media"
          ];
          center = [
            "time"
            "sysmon"
          ];
          right = [
            "tray"
            [
              "kb"
              "wifi"
              "bt"
              "vol"
            ]
          ];
        };
      };

      # Application launcher at the bottom of the screen.
      launcher.position = "bottom";

      # Font, corner radius and matugen color generation.
      theme = {
        fontFamily = "Adwaita Mono";
        borderRadius = 12;
        matugen = true;
      };

      # Notifications in the top-right corner with sound.
      notifications = {
        dnd = false;
        position = "top right";
        sound = true;
      };
    };
  };
}
