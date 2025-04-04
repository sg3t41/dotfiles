local Plugin = { "neovim/nvim-lspconfig" }
Plugin.enabled = true
local user = {}
Plugin.dependencies = {
	{ "williamboman/mason.nvim" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "jay-babu/mason-null-ls.nvim" },
	{ "nvimtools/none-ls.nvim" },
	{ 'nvim-lua/plenary.nvim' }
}
Plugin.cmd = { "LspInfo", "LspInstall", "LspUnInstall" }
Plugin.event = { "BufReadPre", "BufNewFile" }

function Plugin.init()
	vim.diagnostic.config({
		-- virtual_text = true,
		virtual_text = {
			severity = { min = vim.diagnostic.severity.ERROR },
		},
		severity_sort = false,
		underline = true,
		float = {
			border = "rounded",
			source = true,
		},
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = "x",
				[vim.diagnostic.severity.WARN] = "!",
				[vim.diagnostic.severity.HINT] = "?",
				[vim.diagnostic.severity.INFO] = "i",
			},
		},
	})

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
end

function Plugin.config()
	local lspconfig = require("lspconfig")
	local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
	local null_ls = require("null-ls")
	local group = vim.api.nvim_create_augroup("lsp_cmds", { clear = true })

	vim.api.nvim_create_autocmd("LspAttach", {
		group = group,
		desc = "LSP actions",
		callback = user.on_attach,
	})

	require("mason").setup()

	require("mason-lspconfig").setup({
		ensure_installed = { "lua_ls", "vtsls", "gopls" },
		handlers = {
			function(server)
				lspconfig[server].setup({
					capabilities = lsp_capabilities,
				})
			end,
		},
	})

	null_ls.setup({
		sources = {
			null_ls.builtins.formatting.prettier.with({
				extra_filetypes = { "typesctipt", "javascript", "css", "html" },
			}),

			require("plugins.lsp.lua_ls").setup({})
		},
	})

	require("mason-null-ls").setup({
		ensure_installed = {
			"prettier",
			"eslint-lsp",
			"css-lsp",
			"emmet-ls",
		},
		automatic_installation = false,
		handlers = {},
	})

	-- アンダーラインを波線にする設定
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#ff0000" })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#ffa500" })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "#00ff00" })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = "#0000ff" })
end

function user.on_attach(event)
	local bufmap = function(mode, lhs, rhs, desc)
		local opts = { buffer = event.buf, desc = desc }
		vim.keymap.set(mode, lhs, rhs, opts)
	end

	bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover documentation")
	bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to definition")
	bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to declaration")
	bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", "Go to implementation")
	bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Go to type definition")
	bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", "Go to reference")
	bufmap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Show function signature")
	bufmap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename symbol")
	bufmap({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format buffer")
	bufmap("n", "ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Execute code action")
	bufmap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", "Show line diagnostic")
	bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Previous diagnostic")
	bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next diagnostic")
end

return Plugin
