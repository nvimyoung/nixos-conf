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
		./dot/git.nix
		./dot/fastfetch.nix
		./dot/btop.nix
		./dot/opencode.nix
	];

	home = {
		username = "vimyoung";
		homeDirectory = "/home/vimyoung";
		stateVersion = "26.05";
	};

	home.sessionVariables = {
		EDITOR = "nvim";
		VISUAL = "nvim";
		NIXOS_OZONE_WL = "1";
		MOZ_ENABLE_WAYLAND = "1";
	};

	qt = {
		enable = true;
		platformTheme.name = "gtk3";
	};

	home.file."wall/.keep".text = "";

	home.pointerCursor = {
		enable = true;
		package = pkgs.bibata-cursors;
		name = "Bibata-Modern-Classic";
		size = 22;

		gtk.enable = true;
		x11.enable = true;
	};
}
