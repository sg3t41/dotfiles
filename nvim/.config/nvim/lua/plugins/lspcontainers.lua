-- ~/.config/nvim/lua/plugins/lspcontainers.lua
return {
	"lspcontainers/lspcontainers.nvim",
	config = function()
		-- .devcontainer/devcontainer.json があれば、自動的に読み込まれる
		-- ここを修正しました: setup関数の引数をテーブル({})で囲み、閉じ括弧も修正
		require("lspcontainers").setup({
			servers = {
				jdtls = {
					-- ここに、今ビルドしたDockerイメージの名前とタグを指定します
					-- あなたのdocker imagesの出力から「jdtls」と「latest」を指定
					image = "jdtls:latest",
					-- 必要に応じて、追加の Docker オプションを指定できます
					-- options = {
					--   "--platform=linux/amd64", -- M1 Macなどで必要になる場合がある
					-- },
				},
				-- 他のLSPサーバーの設定もここに追加可能
			},
			-- オプション: デバッグログを有効にする (問題が発生した場合に役立ちます)
			-- log_level = vim.log.levels.DEBUG,
		})

		-- ここにあった lspconfig.jdtls.setup の部分は削除します。
		-- これは lspconfig.lua に記述されているはずです。
	end,
}
