{ ... }:
{
	xdg.configFile."kitty/kitty.conf".force = true;

	programs.kitty = {
		enable = true;
		settings = {
			confirm_os_window_close = 0;
			background_opacity = "0.50";
		};
		extraConfig = ''
			include /home/vimyoung/.config/kitty/colors.conf
		'';
	};
}
