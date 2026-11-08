{ config, pkgs, serpantinum, ... }:
{
	imports = [
		serpantinum.homeManagerModules.default
		./dot/packages.nix
		./dot/bash.nix
		./dot/kitty.nix
		./dot/niri.nix
		./dot/serpantinum.nix
		./dot/neovim.nix
		./dot/firefox.nix
		./dot/gh.nix
		./dot/git.nix
	];

	home = {
		username = "vimyoung";
		homeDirectory = "/home/vimyoung";
		stateVersion = "26.05";
	};

	home.pointerCursor = {
		enable = true;
		package = pkgs.bibata-cursors;
		name = "Bibata-Modern-Classic";
		size = 22;

		gtk.enable = true;
		x11.enable = true;
	};
}
