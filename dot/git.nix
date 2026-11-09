{ ... }:
{
	programs.git = {
		enable = true;

		settings = {
			user = {
				name = "nvimyoung";
				email = "40500524+nvimyoung@users.noreply.github.com";
			};

			init.defaultBranch = "main";
			core.editor = "nvim";

			pull.rebase = true;
			push.autoSetupRemote = true;
			fetch.prune = true;

			alias = {
				st = "status";
				co = "checkout";
				br = "branch";
				lg = "log --oneline --graph --decorate";
			};
		};
	};

	programs.gh.enable = true;
}
