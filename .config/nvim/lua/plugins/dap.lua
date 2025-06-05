local Plugin = { "mfussenegger/nvim-dap" }
Plugin.enabled = false  -- 一時的に無効化（デバッグ使わないなら）

Plugin.ft = { "go" }

Plugin.dependencies = {
	{ "leoluz/nvim-dap-go" },
	{ "rcarriga/nvim-dap-ui" },
	{ "nvim-neotest/nvim-nio" },
}


Plugin.config = function()
	local dap = require("dap")
	local dap_go = require("dap-go")
	local dapui = require("dapui")

	-- nvim-dap-go のセットアップ
	dap_go.setup()

	-- nvim-dap-ui のセットアップ
	dapui.setup()

	-- DAP イベントが発生したときに自動で UI を開いたり閉じたりする設定
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end

	-- キーマッピング用の関数
	local function open_repl()
		dap.repl.open()
	end

	local function toggle_breakpoint()
		dap.toggle_breakpoint()
	end

	local function set_breakpoint()
		dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
	end

	-- キーマッピング
	vim.keymap.set("n", "<F5>", function() dap.continue() end, { desc = "デバッグの開始または再開" })
	vim.keymap.set("n", "<F10>", function() dap.step_over() end, { desc = "ステップオーバー: 関数の中に入らず次の行へ進む" })
	vim.keymap.set("n", "<F11>", function() dap.step_into() end, { desc = "ステップイン: 関数呼び出しの中に入って実行する" })
	vim.keymap.set("n", "<F12>", function() dap.step_out() end, { desc = "ステップアウト: 関数の処理を完了して呼び出し元に戻る" })
	vim.keymap.set("n", "<leader>b", toggle_breakpoint, { desc = "現在の行にブレークポイントを設定または解除する" })
	vim.keymap.set("n", "<leader>B", set_breakpoint, { desc = "条件付きブレークポイントを設定する (例: x > 5)" })
	vim.keymap.set("n", "<leader>dr", open_repl, { desc = "REPL (対話型デバッグ用コンソール) を開く" })
end

return Plugin
