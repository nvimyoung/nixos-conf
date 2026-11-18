{ pkgs, ... }:
{
	# User packages that are not tied to a specific module.
	home.packages = with pkgs; [
		# Brightness and media keys.
		brightnessctl
		playerctl

		# File search and archives.
		fd
		tree
		unar

		# Audio visualizer, office suite and scripting.
		cava
		libreoffice
		python3

		# Messengers and Windows compatibility.
		telegram-desktop
		vesktop
		wine

		# USB imaging and the NixOS rebuild helper.
		ventoy
		nh
	];
}
