return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"leoluz/nvim-dap-go",
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require "dap"
		local ui = require "dapui"

		require("dapui").setup()
		require("dap-go").setup()

		dap.listeners.before.attach.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			ui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			ui.close()
		end

		vim.keymap.set("n", "<leader>bb", dap.toggle_breakpoint)
		vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)

		-- Eval var under cursor
		vim.keymap.set("n", "<leader>?", function()
			require("dapui").eval(nil, { enter = true })
		end)

		vim.keymap.set("n", "<leader>dl", dap.continue)
		vim.keymap.set("n", "<leader>dk", dap.step_into)
		vim.keymap.set("n", "<leader>dj", dap.step_over)
		vim.keymap.set("n", "<leader>dh", dap.step_back)
		vim.keymap.set("n", "<leader>do", dap.step_out)
		vim.keymap.set("n", "<leader>dr", dap.restart)
		vim.keymap.set("n", '<leader>dx', function()
			require('dap').terminate(); require('dapui').close()
		end)
	end
}
