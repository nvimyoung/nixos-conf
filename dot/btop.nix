{ ... }:
{
	# System monitor: TTY colors, transparent background, vim keys.
	programs.btop = {
		enable = true;
		settings = {
			color_theme = "TTY";
			theme_background = false;
			vim_keys = true;
		};
	};
}
