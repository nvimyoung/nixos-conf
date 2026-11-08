{ ... }:
{
	programs.neovim = {
		enable = true;
		initLua = ''
			vim.opt.termguicolors = true
			vim.opt.background = "dark"

			vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "FoldColumn", { bg = "NONE" })
		'';
	};
}
