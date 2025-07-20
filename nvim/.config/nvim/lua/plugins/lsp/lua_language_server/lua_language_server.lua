return {
	-- Dockerコンテナ内のLSPサーバーにTCPで接続
	cmd = { "nc", "localhost", "8888" },

	-- `lua_ls` 固有の設定
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = { library = vim.api.nvim_get_runtime_file("", true) },
		},
	},
}
