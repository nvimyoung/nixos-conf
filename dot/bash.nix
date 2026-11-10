{ ... }:
{
	programs.bash = {
		enable = true;
		shellAliases = {
			switch = "nh os switch . --hostname vimyoung";
			ff = "clear && fastfetch";
		};
	};

	programs.zoxide = {
		enable = true;
		enableBashIntegration = true;
	};

	programs.fzf = {
		enable = true;
		enableBashIntegration = true;
	};

	programs.direnv = {
		enable = true;
		enableBashIntegration = true;
		nix-direnv.enable = true;
	};

	programs.bat.enable = true;

	programs.eza = {
		enable = true;
		enableBashIntegration = true;
	};

	programs.lazygit.enable = true;

	programs.yazi = {
		enable = true;
		enableBashIntegration = true;
	};
}
