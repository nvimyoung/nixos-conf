{ pkgs, ... }:
{
	# Neovim with a transparent dark UI and the system clipboard.
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		# wl-clipboard provides the Wayland clipboard provider (+y / +p).
		extraPackages = [ pkgs.wl-clipboard ];
		initLua = ''
			-- Editor options.
			vim.opt.termguicolors = true
			vim.opt.background = "dark"
			vim.opt.clipboard = "unnamedplus"

			-- Remove the background from UI elements (use the terminal color).
			for _, group in ipairs({
				"Normal", "NormalNC", "SignColumn", "EndOfBuffer", "LineNr", "FoldColumn",
			}) do
				vim.api.nvim_set_hl(0, group, { bg = "NONE" })
			end

			-- Ctrl+Shift+C copies, Ctrl+Shift+V pastes.
			local map = vim.keymap.set
			map("n", "<C-S-c>", '"+yy', { desc = "Copy line to system clipboard" })
			map("v", "<C-S-c>", '"+y', { desc = "Copy selection to system clipboard" })
			map({ "n", "v" }, "<C-S-v>", '"+p', { desc = "Paste from system clipboard" })
			map({ "i", "c" }, "<C-S-v>", "<C-r>+", { desc = "Paste from system clipboard" })

			-- Tell kitty that an editor is focused, so it passes Ctrl+Shift+C/V
			-- through instead of copying/pasting the terminal selection.
			if vim.env.KITTY_WINDOW_ID and vim.api.nvim_ui_send then
				local function in_editor(on)
					local value = on and "=MQ==" or ""
					pcall(vim.api.nvim_ui_send, "\27]1337;SetUserVar=in_editor" .. value .. "\7")
				end

				vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter", "VimResume" }, {
					callback = function() in_editor(true) end,
				})
				vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
					callback = function() in_editor(false) end,
				})
			end
		'';
	};

	# Kitty: send explicit CSI-u sequences to Neovim while it is focused.
	# `--allow-fallback=ascii` keeps the shortcuts working on the Russian layout.
	programs.kitty.extraConfig = ''
		map --when-focus-on var:in_editor --allow-fallback=ascii ctrl+shift+c send_text all \e[99;6u
		map --when-focus-on var:in_editor --allow-fallback=ascii ctrl+shift+v send_text all \e[118;6u
	'';
}
