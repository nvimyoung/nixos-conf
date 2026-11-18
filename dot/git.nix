{ ... }:
{
	# Git identity and defaults.
	programs.git = {
		enable = true;

		settings = {
			user = {
				name = "nvimyoung";
				email = "40500524+nvimyoung@users.noreply.github.com";
			};

			# `main` branch, Neovim as the editor.
			init.defaultBranch = "main";
			core.editor = "nvim";

			# Rebase on pull, push new branches automatically, prune refs.
			pull.rebase = true;
			push.autoSetupRemote = true;
			fetch.prune = true;

			# Short aliases for everyday commands.
			alias = {
				st = "status";
				co = "checkout";
				br = "branch";
				lg = "log --oneline --graph --decorate";
			};
		};
	};

	# GitHub CLI (`gh`).
	programs.gh.enable = true;
}
