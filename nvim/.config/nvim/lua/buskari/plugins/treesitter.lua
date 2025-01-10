return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		--		vim.api.nvim_create_autocmd("FileType", {
		--			pattern = { "markdown" },
		--			callback = function()
		--				require("treesitter-context").disable()
		--			end
		--		})

		-- configure treesitter
		treesitter.setup({ -- enable syntax highlighting
			highlight = {
				enable = true,
				disable = { "csv" },
			},
			-- enable indentation
			indent = { enable = true },
			-- enable autotagging (w/ nvim-ts-autotag plugin)
			autotag = {
				enable = true,
			},
			textobjects = { select = { enable = true, lookahead = true } },
			-- ensure these language parsers are installed
			ensure_installed = {
				"bash",
				"c",
				"csv",
				"dockerfile",
				"gitignore",
				"go",
				"gomod",
				"gosum",
				"gowork",
				"java",
				"javascript",
				"json",
				"kotlin",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"sql",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = false,
					node_incremental = false,
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})
	end,
}
