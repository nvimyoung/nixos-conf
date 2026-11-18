{ ... }:
{
  # niri configuration, converted to Nix settings for Home Manager.
  # Docs: https://niri-wm.github.io/niri/Configuration:-Introduction
  # HM module: wayland.windowManager.niri (lib.hm.generators.toKDL)
  wayland.windowManager.niri = {
    enable = true;
    # niri is enabled and packaged system-wide; only generate config here.
    package = null;
    systemd.enable = false;
    portalPackage = null;
    xwaylandSatellitePackage = null;

    settings = {
      # Input devices: keyboard layout and touchpad behavior.
      input = {
        keyboard.xkb = {
          # US + RU layouts, switch with Alt+Shift.
          layout = "us,ru";
          options = "grp:alt_shift_toggle";
        };
        # keyboard.numlock = { }; # Enable NumLock on startup (disabled in original).

        touchpad = {
          # Tap to click and natural (inverted) scrolling.
          tap = { };
          natural-scroll = { };
        };
      };

      # Window layout: gaps, column presets and focus ring.
      layout = {
        gaps = 24;
        center-focused-column = "never";

        # Column widths cycled by Mod+R.
        preset-column-widths._children = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 1.0; }
          { fixed = 1920; }
        ];

        # New windows open at half the output width.
        default-column-width.proportion = 0.5;

        focus-ring = {
          width = 4;
          active-color = "#000000";
          inactive-color = "#505050";
        };
      };

      # Hide the "Important Hotkeys" popup at startup.
      hotkey-overlay.skip-at-startup = { };

      # Ask clients to omit client-side decorations.
      prefer-no-csd = { };

      # Key bindings. "Mod" is Super on a TTY.
      binds = {
        # Show the hotkey overlay.
        "Mod+Shift+Slash".show-hotkey-overlay = { };

        # Launch applications: terminal, browser, Steam, launcher, settings, lock.
        "Mod+Q" = {
          _props.hotkey-overlay-title = "Open a Terminal: kitty";
          spawn = [ "kitty" ];
        };
        "Mod+B" = {
          _props.hotkey-overlay-title = "Run Browser: firefox";
          spawn = [ "firefox" ];
        };
        "Mod+S" = {
          _props.hotkey-overlay-title = "Run Steam";
          spawn = [ "steam" ];
        };
        "Mod+Space" = {
          _props.hotkey-overlay-title = "Open a Launcher";
          spawn-sh = [ "serpantinum msg toggle launcher" ];
        };
        "Mod+Alt+W" = {
          _props.hotkey-overlay-title = "Open a Settings";
          spawn-sh = [ "serpantinum settings" ];
        };
        "Mod+Alt+L" = {
          _props.hotkey-overlay-title = "Lock the Screen";
          spawn-sh = [ "serpantinum lock" ];
        };

        # Volume keys (work when the screen is locked).
        "XF86AudioRaiseVolume" = {
          _props.allow-when-locked = true;
          spawn-sh = [ "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.0" ];
        };
        "XF86AudioLowerVolume" = {
          _props.allow-when-locked = true;
          spawn-sh = [ "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-" ];
        };
        "XF86AudioMute" = {
          _props.allow-when-locked = true;
          spawn-sh = [ "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" ];
        };
        "XF86AudioMicMute" = {
          _props.allow-when-locked = true;
          spawn-sh = [ "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle" ];
        };

        # Media keys via playerctl (MPRIS).
        "XF86AudioPlay" = {
          _props.allow-when-locked = true;
          spawn-sh = [ "playerctl play-pause" ];
        };
        "XF86AudioStop" = {
          _props.allow-when-locked = true;
          spawn-sh = [ "playerctl stop" ];
        };
        "XF86AudioPrev" = {
          _props.allow-when-locked = true;
          spawn-sh = [ "playerctl previous" ];
        };
        "XF86AudioNext" = {
          _props.allow-when-locked = true;
          spawn-sh = [ "playerctl next" ];
        };

        # Brightness keys.
        "XF86MonBrightnessUp" = {
          _props.allow-when-locked = true;
          spawn = [
            "brightnessctl"
            "--class=backlight"
            "set"
            "+5%"
          ];
        };
        "XF86MonBrightnessDown" = {
          _props.allow-when-locked = true;
          spawn = [
            "brightnessctl"
            "--class=backlight"
            "set"
            "5%-"
          ];
        };

        # Overview and closing the focused window.
        "Mod+O" = {
          _props.repeat = false;
          toggle-overview = { };
        };
        "Mod+C" = {
          _props.repeat = false;
          close-window = { };
        };

        # Focus columns/windows: arrows and vim keys.
        "Mod+Left".focus-column-left = { };
        "Mod+Down".focus-window-down = { };
        "Mod+Up".focus-window-up = { };
        "Mod+Right".focus-column-right = { };
        "Mod+H".focus-column-left = { };
        "Mod+J".focus-window-down = { };
        "Mod+K".focus-window-up = { };
        "Mod+L".focus-column-right = { };

        # Move the focused column/window: arrows and vim keys.
        "Mod+Shift+Left".move-column-left = { };
        "Mod+Shift+Down".move-window-down = { };
        "Mod+Shift+Up".move-window-up = { };
        "Mod+Shift+Right".move-column-right = { };
        "Mod+Shift+H".move-column-left = { };
        "Mod+Shift+J".move-window-down = { };
        "Mod+Shift+K".move-window-up = { };
        "Mod+Shift+L".move-column-right = { };

        # First/last column.
        "Mod+Home".focus-column-first = { };
        "Mod+End".focus-column-last = { };
        "Mod+Ctrl+Home".move-column-to-first = { };
        "Mod+Ctrl+End".move-column-to-last = { };

        # Move the focused column to another monitor.
        "Mod+Shift+Ctrl+Left".move-column-to-monitor-left = { };
        "Mod+Shift+Ctrl+Down".move-column-to-monitor-down = { };
        "Mod+Shift+Ctrl+Up".move-column-to-monitor-up = { };
        "Mod+Shift+Ctrl+Right".move-column-to-monitor-right = { };
        "Mod+Shift+Ctrl+H".move-column-to-monitor-left = { };
        "Mod+Shift+Ctrl+J".move-column-to-monitor-down = { };
        "Mod+Shift+Ctrl+K".move-column-to-monitor-up = { };
        "Mod+Shift+Ctrl+L".move-column-to-monitor-right = { };

        # Focus and move columns between workspaces.
        "Mod+Page_Down".focus-workspace-down = { };
        "Mod+Page_Up".focus-workspace-up = { };
        "Mod+U".focus-workspace-down = { };
        "Mod+I".focus-workspace-up = { };
        "Mod+Ctrl+Page_Down".move-column-to-workspace-down = { };
        "Mod+Ctrl+Page_Up".move-column-to-workspace-up = { };
        "Mod+Ctrl+U".move-column-to-workspace-down = { };
        "Mod+Ctrl+I".move-column-to-workspace-up = { };

        # Move whole workspaces up/down.
        "Mod+Shift+Page_Down".move-workspace-down = { };
        "Mod+Shift+Page_Up".move-workspace-up = { };
        "Mod+Shift+U".move-workspace-down = { };
        "Mod+Shift+I".move-workspace-up = { };

        # Mouse wheel: switch workspaces vertically, move columns with Ctrl.
        "Mod+WheelScrollDown" = {
          _props.cooldown-ms = 150;
          focus-workspace-down = { };
        };
        "Mod+WheelScrollUp" = {
          _props.cooldown-ms = 150;
          focus-workspace-up = { };
        };
        "Mod+Ctrl+WheelScrollDown" = {
          _props.cooldown-ms = 150;
          move-column-to-workspace-down = { };
        };
        "Mod+Ctrl+WheelScrollUp" = {
          _props.cooldown-ms = 150;
          move-column-to-workspace-up = { };
        };

        # Mouse wheel: scroll columns horizontally.
        "Mod+WheelScrollRight".focus-column-right = { };
        "Mod+WheelScrollLeft".focus-column-left = { };
        "Mod+Ctrl+WheelScrollRight".move-column-right = { };
        "Mod+Ctrl+WheelScrollLeft".move-column-left = { };

        # Mouse wheel with Shift: horizontal column navigation/movement.
        "Mod+Shift+WheelScrollDown".focus-column-right = { };
        "Mod+Shift+WheelScrollUp".focus-column-left = { };
        "Mod+Ctrl+Shift+WheelScrollDown".move-column-right = { };
        "Mod+Ctrl+Shift+WheelScrollUp".move-column-left = { };

        # Switch to workspace N.
        "Mod+1".focus-workspace = 1;
        "Mod+2".focus-workspace = 2;
        "Mod+3".focus-workspace = 3;
        "Mod+4".focus-workspace = 4;
        "Mod+5".focus-workspace = 5;
        "Mod+6".focus-workspace = 6;
        "Mod+7".focus-workspace = 7;
        "Mod+8".focus-workspace = 8;
        "Mod+9".focus-workspace = 9;

        # Move the focused column to workspace N.
        "Mod+Shift+1".move-column-to-workspace = 1;
        "Mod+Shift+2".move-column-to-workspace = 2;
        "Mod+Shift+3".move-column-to-workspace = 3;
        "Mod+Shift+4".move-column-to-workspace = 4;
        "Mod+Shift+5".move-column-to-workspace = 5;
        "Mod+Shift+6".move-column-to-workspace = 6;
        "Mod+Shift+7".move-column-to-workspace = 7;
        "Mod+Shift+8".move-column-to-workspace = 8;
        "Mod+Shift+9".move-column-to-workspace = 9;

        # Consume/expel windows to or from the neighboring column.
        "Mod+BracketLeft".consume-or-expel-window-left = { };
        "Mod+BracketRight".consume-or-expel-window-right = { };

        # Merge the window from the right into the column / expel the bottom one.
        "Mod+Comma".consume-window-into-column = { };
        "Mod+Period".expel-window-from-column = { };

        # Cycle preset column widths.
        "Mod+R".switch-preset-column-width = { };
        "Mod+Shift+R".switch-preset-column-width-back = { };

        # Preset window heights and reset.
        "Mod+Ctrl+Shift+R".switch-preset-window-height = { };
        "Mod+Ctrl+R".reset-window-height = { };

        # Maximize column / fullscreen window.
        "Mod+F".maximize-column = { };
        "Mod+Shift+F".fullscreen-window = { };

        # Maximize window to screen edges (normal maximize).
        "Mod+M".maximize-window-to-edges = { };

        # Expand the column to all available width.
        "Mod+Ctrl+F".expand-column-to-available-width = { };

        # Center all visible columns.
        "Mod+Ctrl+C".center-visible-columns = { };

        # Fine-tune column width.
        "Mod+Minus".set-column-width = "-10%";
        "Mod+Equal".set-column-width = "+10%";

        # Fine-tune window height inside a column.
        "Mod+Shift+Minus".set-window-height = "-10%";
        "Mod+Shift+Equal".set-window-height = "+10%";

        # Toggle floating and switch focus between floating/tiling.
        "Mod+V".toggle-window-floating = { };
        "Mod+Shift+V".switch-focus-between-floating-and-tiling = { };

        # Show the focused column as vertical tabs.
        "Mod+W".toggle-column-tabbed-display = { };

        # Take a screenshot with serpantinum.
        "Mod+P".spawn-sh = [ "serpantinum screenshot" ];

        # Toggle keyboard shortcut inhibition (for remote desktop / KVM).
        "Mod+Escape" = {
          _props.allow-inhibiting = false;
          toggle-keyboard-shortcuts-inhibit = { };
        };

        # Quit niri (with confirmation) and poweroff.
        "Mod+Shift+Delete".quit = { };
        "Mod+Alt+Delete".spawn-sh = [ "poweroff" ];

        # Power off the monitors; any input turns them back on.
        "Mod+Shift+O".power-off-monitors = { };
      };

      _children = [
        # Built-in laptop display: 1920x1080@60Hz at 120% scale.
        {
          output = {
            _args = [ "eDP-1" ];
            mode = "1920x1080@60.014";
            scale = 1.2;
            transform = "normal";
            position._props = {
              x = 0;
              y = 0;
            };
          };
        }

        # Open Firefox picture-in-picture as a floating window.
        {
          window-rule._children = [
            {
              match._props = {
                app-id = "firefox$";
                title = "^Picture-in-Picture$";
              };
            }
            { open-floating = true; }
          ];
        }
      ];
    };
  };
}
