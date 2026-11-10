{ pkgs, ... }:
{
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		extraPackages = [ pkgs.wl-clipboard ];
		initLua = ''
			vim.opt.termguicolors = true
			vim.opt.background = "dark"
			vim.opt.clipboard = "unnamedplus"

			vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "FoldColumn", { bg = "NONE" })

			local map = vim.keymap.set
			map("n", "<C-S-c>", '"+yy', { desc = "Copy line to system clipboard" })
			map("v", "<C-S-c>", '"+y', { desc = "Copy selection to system clipboard" })
			map({ "n", "v" }, "<C-S-v>", '"+p', { desc = "Paste from system clipboard" })
			map("i", "<C-S-v>", "<C-r>+", { desc = "Paste from system clipboard" })
			map("c", "<C-S-v>", "<C-r>+", { desc = "Paste from system clipboard" })

			local kitty_set = vim.api.nvim_create_augroup("KittySetVarVimEnter", { clear = true })
			vim.api.nvim_create_autocmd({ "VimEnter", "VimResume", "UIEnter" }, {
				group = kitty_set,
				callback = function()
					local seq = "\27]1337;SetUserVar=in_editor=MQ==\7"
					if vim.api.nvim_ui_send then
						vim.api.nvim_ui_send(seq)
					else
						io.stdout:write(seq)
					end
				end,
			})

			local kitty_unset = vim.api.nvim_create_augroup("KittyUnsetVarVimLeave", { clear = true })
			vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
				group = kitty_unset,
				callback = function()
					local seq = "\27]1337;SetUserVar=in_editor\7"
					if vim.api.nvim_ui_send then
						vim.api.nvim_ui_send(seq)
					else
						io.stdout:write(seq)
					end
				end,
			})
		'';
	};

	programs.kitty.extraConfig = ''
		map --when-focus-on var:in_editor ctrl+shift+c
		map --when-focus-on var:in_editor ctrl+shift+v
	'';
}
