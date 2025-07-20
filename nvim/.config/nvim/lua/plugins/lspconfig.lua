-- lua/plugins/lspconfig.lua

local Plugin = { "neovim/nvim-lspconfig" }

Plugin.enabled = true

Plugin.dependencies = {
	"hrsh7th/cmp-nvim-lsp", -- capabilitiesの提供に必要
}

Plugin.cmd = { "LspInfo" }
Plugin.event = { "BufReadPre", "BufNewFile" }

-- この user テーブルは on_attach 関数を格納するためにファイルスコープで定義します
local user = {}

function Plugin.init()
	vim.diagnostic.config({
		virtual_text = {
			severity = { min = vim.diagnostic.severity.ERROR },
		},
		severity_sort = false,
		underline = true,
		float = {
			border = "rounded",
			source = true,
		},
	})

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
end

-- LSPがバッファにアタッチされたときに呼ばれるコールバック関数
function user.on_attach(client, bufnr)
	local bufmap = function(mode, lhs, rhs, desc)
		local opts = { buffer = bufnr, desc = "LSP: " .. desc }
		vim.keymap.set(mode, lhs, rhs, opts)
	end

	-- ホバー、定義ジャンプなどの基本的なキーマップ
	bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover documentation")
	bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to definition")
	bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to declaration")
	bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", "Go to implementation")
	bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Go to type definition")
	bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", "Go to references")
	bufmap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Show signature")
	bufmap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename symbol")
	bufmap({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format buffer")
	bufmap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action")

	-- 診断情報（Diagnostic）関連のキーマップ
	bufmap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", "Show line diagnostic")
	bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Go to previous diagnostic")
	bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", "Go to next diagnostic")
end

function Plugin.config()
	local lspconfig = require("lspconfig")
	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local configs = require("lspconfig.configs") -- カスタムサーバー登録に必要

	-- 全てのLSPサーバーに適用する共通設定
	local common_capabilities = cmp_nvim_lsp.default_capabilities()
	local common_settings = {
		flags = {
			debounce_text_changes = 150,
		},
		on_attach = user.on_attach,
		capabilities = common_capabilities,
	}

	-- 1. lua_ls (ビルトイン)
	local lua_ls_config = require("plugins.lsp.lua_language_server.lua_language_server")
	lspconfig.lua_ls.setup(vim.tbl_deep_extend("force", {}, common_settings, lua_ls_config))

	-- 2. spring_boot_ls (カスタムサーバーとして登録し、Dockerに接続)
	local spring_boot_bundle
	local sb_status, sb = pcall(require, "spring-boot")
	if sb_status then
	  spring_boot_bundle = sb.bundle
	end

	-- カスタムサーバーの定義
	configs.spring_boot_ls = {
		default_config = {
			cmd = { "nc", "localhost", "8889" }, -- Dockerコンテナに直接接続
			filetypes = { "java" }, -- Javaファイルで起動
			root_dir = require("lspconfig.util").root_pattern("pom.xml", "build.gradle", "build.gradle.kts"),
			init_options = {
				bundles = { spring_boot_bundle }, -- spring-boot.nvimの拡張機能
			},
		},
	}

	-- カスタムサーバーをセットアップ
	lspconfig.spring_boot_ls.setup(common_settings)
end

return Plugin