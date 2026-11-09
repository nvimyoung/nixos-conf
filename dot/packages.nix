{ pkgs, ... }:
{
	home.packages = with pkgs; [
		fastfetch
		btop
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
		opencode
		#osu-lazer
		nh
		nvd
		nix-output-monitor
	];
}
