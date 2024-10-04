local Plugin = { "rcarriga/nvim-notify" }

-- 画面使用時は遅延読込させない
-- Plugin.lazy = vim.fn.argc(-1) == 0

Plugin.opts = {
	render = "wrapped-compact",
	-- 	stages = "fade",

	--時間表示無し
	time_formats = {
		notification = "",
		notification_history = ""
	},
}

function Plugin.config()
	local notify = require("notify")
	notify.setup(Plugin.opts)
	vim.notify = notify

	-- LSP 起動完了時に通知を表示
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			-- 起動した LSP クライアント名を取得
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			local client_name = client and client.name or "Unknown LSP"

			-- 通知を表示
			notify(client_name .. " has been set up", "info", {
				title = "LSP",
				timeout = 1000 * 5, -- 表示時間（ミリ秒）
			})
		end,
	})

	-- [[Diagnosticの診断結果を表示したいけどこのままだとバッファを閉じる時に残像が残る]]
	--	vim.api.nvim_create_autocmd("DiagnosticChanged", {
	--		callback = function()
	--			local diagnostics = vim.diagnostic.get(0) -- 現在のバッファの診断情報を取得
	--			for _, diagnostic in ipairs(diagnostics) do
	--				if diagnostic.severity == vim.diagnostic.severity.ERROR then
	--					-- エラーメッセージを行番号付きで通知
	--					notify("Error on line " .. diagnostic.lnum + 1 .. ": " .. diagnostic.message, "error", {
	--						title = "LSP Error",
	--						timeout = 1000 * 10,
	--					})
	--				elseif diagnostic.severity == vim.diagnostic.severity.WARN then
	--					-- 警告メッセージを行番号付きで通知
	--					notify("Warning on line " .. diagnostic.lnum + 1 .. ": " .. diagnostic.message, "warn", {
	--						title = "LSP Warning",
	--						timeout = 1000 * 10,
	--					})
	--				end
	--			end
	--		end,
	--	})
end

return Plugin

