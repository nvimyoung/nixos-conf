{ config, ... }:
{
	programs.serpantinum = {
		enable = true;
		systemd.enable = true;

		settings = {
			wallpaperDir = "${config.home.homeDirectory}/wall";

			general = {
				language = "ru";
				weatherUnit = "metric";
				weatherInterval = 30;
			};

			display.monitors."eDP-1".scale = 1.2;

			bar = {
				position = "top";
				style = "solid";
				width = 58;
				height = 38;
				opacity = 100;
				autohide = false;
				autohideTimeout = 1000;
				workspaceCount = 5;
				distinctPills = false;
				centerByEdges = true;
				mediaInfoMode = "duration";
				groupColors = {
					g_kb = "#c9bfff";
				};
				time.format = "HH:mm:ss";
				modules = {
					left = [ "workspaces" "media" ];
					center = [ "time" "sysmon" ];
					right = [ "tray" [ "kb" "wifi" "bt" "vol" ] ];
				};
			};

			launcher.position = "bottom";

			theme = {
				fontFamily = "Adwaita Mono";
				borderRadius = 12;
				matugen = true;
			};

			notifications = {
				dnd = false;
				position = "top right";
				sound = true;
			};
		};
	};
}
