{ ... }:
{
	# OpenCode terminal client.
	programs.opencode = {
		enable = true;

		# OpenCode rewrites cli.json from the TUI, so keep mutable settings and
		# put declarative values in a separate home-manager-cli.json layer.
		mutableSettings = true;

		cli.theme = {
			name = "system";
			mode = "system";
		};
	};
}
