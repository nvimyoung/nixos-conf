{ pkgs, ... }:
{
	home.packages = with pkgs; [
		fastfetch
		cava
		yazi
		libreoffice
		#libresprite
		python3
		telegram-desktop
		vesktop
		opencode
		#osu-lazer
	];
}
