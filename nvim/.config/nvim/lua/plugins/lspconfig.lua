local Plugin = { "neovim/nvim-lspconfig" }
Plugin.enabled = true
Plugin.dependencies = {
	"hrsh7th/cmp-nvim-lsp",
	"lspcontainers/lspcontainers.nvim",
}
Plugin.cmd = { "LspInfo" }
Plugin.event = { "BufReadPre", "BufNewFile" }
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

function user.on_attach(client, bufnr)
	local bufmap = function(mode, lhs, rhs, desc)
		local opts = { buffer = bufnr, desc = "LSP: " .. desc }
		vim.keymap.set(mode, lhs, rhs, opts)
	end
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
	bufmap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", "Show line diagnostic")
	bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Go to previous diagnostic")
	bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", "Go to next diagnostic")
end

function Plugin.config()
	local lspconfig = require("lspconfig")
	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local common_capabilities = cmp_nvim_lsp.default_capabilities()
	local lspcontainers = require("lspcontainers")

	-- デバッグ用：LSPログレベルを設定
	vim.lsp.set_log_level("DEBUG")

	-- HTML LSP --
	lspconfig.html.setup {
		before_init = function(params)
			params.processId = vim.NIL
		end,
		on_attach = user.on_attach,
		capabilities = common_capabilities,
		cmd = lspcontainers.command('html', {
			image = "lspcontainers/html-language-server:latest",
			cmd = function(runtime, volume, image)
				return {
					runtime,
					"container",
					"run",
					"--interactive",
					"--rm",
					"--volume",
					volume,
					image
				}
			end,
		}),
		root_dir = require 'lspconfig/util'.root_pattern(".git", vim.fn.getcwd()),
	}

	-- LUA LSP --
	lspconfig.lua_ls.setup {
		cmd = require 'lspcontainers'.command('lua_ls'),
		on_attach = user.on_attach,
		capabilities = common_capabilities,
		root_dir = require 'lspconfig/util'.root_pattern(".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", ".git", vim.fn.getcwd()),
	}

	-- GO LSP --
	lspconfig.gopls.setup {
		cmd = lspcontainers.command('gopls', {
			container_runtime = "podman",
		}),
		on_attach = user.on_attach,
		capabilities = common_capabilities,
		root_dir = require 'lspconfig/util'.root_pattern(".git", vim.fn.getcwd(), "go.mod"),
	}

	-- Docker --
	require 'lspconfig'.dockerls.setup {
		before_init = function(params)
			params.processId = vim.NIL
		end,
		cmd = require 'lspcontainers'.command('dockerls'),
		on_attach = user.on_attach,
		capabilities = common_capabilities,
		root_dir = require 'lspconfig/util'.root_pattern(".git", vim.fn.getcwd()),
	}

	-- bash --
	require 'lspconfig'.bashls.setup {
		before_init = function(params)
			params.processId = vim.NIL
		end,
		cmd = require 'lspcontainers'.command('bashls'),
		root_dir = require 'lspconfig/util'.root_pattern(".git", vim.fn.getcwd()),
		on_attach = user.on_attach,
		capabilities = common_capabilities,
	}

	-- ts --
	require 'lspconfig'.tsserver.setup {
		before_init = function(params)
			params.processId = vim.NIL
		end,
		cmd = require 'lspcontainers'.command('tsserver'),
		filetypes = { "ts", "js", "tsx", "jsx" },
		root_dir = require 'lspconfig/util'.root_pattern(".git", vim.fn.getcwd(), "package.json", ".npm_modules"),
		on_attach = user.on_attach,
		capabilities = common_capabilities,
	}

	-- tailwind --
	require 'lspconfig'.tailwindcss.setup {
		before_init = function(params)
			params.processId = vim.NIL
		end,
		cmd = require 'lspcontainers'.command('tailwindcss'),
		filetypes = { "django-html", "htmldjango", "gohtml", "html", "markdown", "php", "css", "postcss", "sass", "scss", "stylus", "javascript", "javascriptreact", "rescript", "typescript", "typescriptreact", "vue", "svelte" },
		root_dir = require 'lspconfig/util'.root_pattern("tailwind.config.js", "tailwind.config.ts", "postcss.config.js", "postcss.config.ts", "package.json", "node_modules", ".git", vim.fn.getcwd()),
		on_attach = user.on_attach,
		capabilities = common_capabilities,
	}

	-- C --
	require 'lspconfig'.clangd.setup {
		before_init = function(params)
			params.processId = vim.NIL
		end,
		cmd = require 'lspcontainers'.command('clangd'),
		filetypes = { "c", "h", },
		root_dir = require 'lspconfig/util'.root_pattern(".git", vim.fn.getcwd()),
		on_attach = user.on_attach,
		capabilities = common_capabilities,
	}

	-- Rust --
	require 'lspconfig'.rust_analyzer.setup {
		cmd = require 'lspcontainers'.command('rust_analyzer'),
		filetypes = { "rust", "rs", },
		root_dir = require 'lspconfig/util'.root_pattern(".git", vim.fn.getcwd()),
		on_attach = user.on_attach,
		capabilities = common_capabilities,
	}
end

return Plugin
