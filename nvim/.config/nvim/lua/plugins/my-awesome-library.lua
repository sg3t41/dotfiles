return {
	-- プラグインの場所を指定
	"my-awesome-library/my-awesome-library.nvim",
	dir = vim.fn.stdpath('config') .. '/lua/libs/my-awesome-library',

	-- このキーが押された時に、初めてこのプラグインが読み込まれる
	keys = {
		{
			"<leader>h", -- 押すキー
			function()
				-- キーが押された後に実行される関数
				-- この時点ではプラグインは読み込み済みなので、安全にrequireできる
				require("my-awesome-library").hello()
			end,
			desc = "Say Hello from My Library" -- キーマップの説明
		},
	},

	-- このコマンドが実行された時に、初めてこのプラグインが読み込まれる
	cmd = "SayHello",

	-- プラグインが読み込まれた直後に実行したい設定（オプション）
	config = function()
		-- ここでユーザーコマンドの本体を定義する
		vim.api.nvim_create_user_command(
			'SayHello',
			function()
				require('my-awesome-library').hello()
			end,
			{}
		)
	end,
}
