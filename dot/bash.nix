{ ... }:
{
	programs.bash = {
		enable = true;
		shellAliases = {
			nix-build = "sudo nixos-rebuild switch";
			nix-hm = "home-manager switch";
			nix-flake = "sudo nixos-rebuild switch --flake .#vimyoung";
			ff = "clear && fastfetch";
		};
	};
}
