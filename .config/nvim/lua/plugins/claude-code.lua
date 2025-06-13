local Plugin = { "greggh/claude-code.nvim" }

Plugin.dependencies = {
  "nvim-lua/plenary.nvim", -- すでにインストール済み
}

Plugin.lazy = true
Plugin.cmd = { "ClaudeCode" }

Plugin.keys = {
  { "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Claude Codeをトグル" },
  { "<C-,>", "<cmd>ClaudeCode<cr>", desc = "Claude Codeをトグル", mode = { "n", "t" } },
}

Plugin.opts = {
  -- ターミナルウィンドウ設定
  window = {
    split_ratio = 0.3,        -- 画面の30%をターミナルに
    position = "botright",    -- 右下に表示
    enter_insert = true,      -- 開いたら即座にインサートモード
    hide_numbers = true,      -- 行番号を隠す
    hide_signcolumn = true,   -- サインカラムを隠す
  },
  
  -- ファイル更新設定
  refresh = {
    enable = true,            -- ファイル変更検出を有効
    updatetime = 100,         -- 更新頻度（ミリ秒）
    timer_interval = 1000,    -- チェック間隔（ミリ秒）
    show_notifications = true, -- リロード通知を表示
  },
  
  -- Git設定
  git = {
    use_git_root = true,      -- Gitルートディレクトリを使用
  },
  
  -- コマンド設定
  command = "claude",         -- Claude Code CLIコマンド
  
  -- キーマップ設定
  keymaps = {
    toggle = {
      normal = "<C-,>",       -- ノーマルモードでのトグル
      terminal = "<C-,>",     -- ターミナルモードでのトグル
    },
    window_navigation = true, -- ウィンドウナビゲーション有効
    scrolling = true,         -- スクロール有効
  }
}

function Plugin.config(opts)
  require("claude-code").setup(opts)
end

return Plugin
