return {
  -- Dockerコンテナ内のJDTLSにTCPで接続
  cmd = { "nc", "localhost", "2087" },

  -- このLSPをJavaファイルで有効にする
  filetypes = { "java" },

  -- プロジェクトのルートディレクトリを特定するパターン
  root_dir = require("lspconfig.util").root_pattern("pom.xml", "build.gradle", "build.gradle.kts", ".git"),

  -- JDTLSに渡す設定
  settings = {
    java = {
      -- Javaのバージョンやフォーマット設定などをここに記述
      -- 例:
      -- format = {
      --   settings = {
      --     url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
      --     profile = "GoogleStyle",
      --   },
      -- },
      -- signatureHelp = { enabled = true },
      -- contentProvider = { preferred = 'fernflower' },
      -- completion = {
      --   favoriteStaticMembers = {
      --     "org.hamcrest.MatcherAssert.assertThat",
      --     "org.hamcrest.Matchers.*",
      --     "org.junit.Assert.*"
      --   }
      -- },
      -- sources = {
      --   organizeImports = {
      --     starThreshold = 9999,
      --     staticStarThreshold = 9999,
      --   },
      -- },
      -- codeGeneration = {
      --   toString = {
      --     template = "${member.name()}=${member.value()}"
      --   }
      -- }
    }
  },

  -- サーバーがアタッチされた時のコールバック
  on_attach = function(client, bufnr)
    -- ここにキーマッピングなどの設定を追加できます
    -- 例:
    -- local opts = { noremap=true, silent=true }
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  end,
}