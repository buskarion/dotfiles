return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'make',
			enabled = true,
		},
		{
			'nvim-telescope/telescope-file-browser.nvim',
			enabled = true,
		},
	},
	config = function()
		local telescope = require("telescope")
		--		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		local opts = { noremap = true, silent = true }
		local map = vim.keymap.set

		--TODO: mapping to add files to quickfix

		map('n', '<leader><leader>', builtin.find_files, opts)
		map('n', '<leader>bf', builtin.buffers)
		map('n', '<leader>qf', builtin.quickfix)
		map('n', '<leader>fs', builtin.live_grep)

		telescope.load_extension("fzf")
		telescope.load_extension("file_browser")

		map("n", "-", ":Telescope file_browser<CR>")
		map("n", "<leader>tt", builtin.treesitter, opts)
		map("n", "<leader>sp", builtin.spell_suggest, opts)
	end
}
