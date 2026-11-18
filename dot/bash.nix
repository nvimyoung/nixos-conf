{ ... }:
{
	# Bash plus shortcuts; `switch` rebuilds this flake.
	programs.bash = {
		enable = true;
		shellAliases = {
			switch = "nh os switch . --hostname vimyoung";
			ff = "clear && fastfetch";
		};
	};

	# Smarter `cd` and fuzzy command/history search.
	programs.zoxide.enable = true;
	programs.fzf.enable = true;

	# Per-project development shells.
	programs.direnv = {
		enable = true;
		nix-direnv.enable = true;
	};

	# Modern replacements for `cat` and `ls`.
	programs.bat.enable = true;
	programs.eza.enable = true;

	# Git and file manager TUIs.
	programs.lazygit.enable = true;
	programs.yazi.enable = true;
}
