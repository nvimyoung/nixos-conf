{ ... }:
{
	xdg.configFile."kitty/colors.conf" = {
		text = builtins.readFile ./kitty-colors.conf;
		force = true;
	};

	programs.kitty = {
		enable = true;
		settings = {
			confirm_os_window_close = 0;
			background_opacity = "0.50";
		};
		extraConfig = ''
			include ~/.config/kitty/colors.conf
		'';
	};
}
