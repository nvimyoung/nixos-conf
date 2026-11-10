{ pkgs, ... }:
{
	home.packages = with pkgs; [
		brightnessctl
		fd
		tree
		unar
		cava
		libreoffice
		#libresprite
		python3
		telegram-desktop
		vesktop
		wine
		#osu-lazer
		nh
		nvd
		nix-output-monitor
		playerctl
	];
}
