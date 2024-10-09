local Plugin = { "hrsh7th/nvim-cmp" }
Plugin.enabled = true
Plugin.dependencies = {
	{ "zbirenbaum/copilot.lua" },
	{ "rinx/cmp-skkeleton" },

	-- Completion sources
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "hrsh7th/cmp-nvim-lsp" },

	-- Snippets
	{ "L3MON4D3/LuaSnip" },
	{ "rafamadriz/friendly-snippets" },
}

Plugin.event = "InsertEnter"

function Plugin.config()
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	local types = require("cmp.types")
	require("luasnip.loaders.from_vscode").lazy_load()

	local select_opts = { behavior = cmp.SelectBehavior.Select }

	cmp.setup({
		view = {
			entries = "native",
		},
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		sources = {
			{
				name = 'skkeleton',
				--				entry_filter = function(entry, ctx)
				--					local kind = types.lsp.CompletionItemKind[entry:get_kind()]
				--					if kind == "Text" then return false end
				--				end,
				keyword_length = 0
			},
			{ name = "path" },
			{ name = "nvim_lsp" },
			{ name = "buffer",  keyword_length = 3 },
			{ name = "luasnip", keyword_length = 2 },
		},
		window = {
			--	completion = cmp.config.window.bordered(),
			--	documentation = cmp.config.window.bordered(),

			completion = {
				winhighlight = "Normal:CmpNormal",
			},
			documentation = {
				winhighlight = "Normal:CmpNormal",
			},
		},

		-- See :help cmp-mapping
		mapping = {
			["<Up>"] = cmp.mapping.select_prev_item(select_opts),
			["<Down>"] = cmp.mapping.select_next_item(select_opts),

			["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
			["<C-n>"] = cmp.mapping.select_next_item(select_opts),

			["<Tab>"] = cmp.mapping(function(fallback)
				local col = vim.fn.col(".") - 1
				if cmp.visible() then
					cmp.select_next_item(select_opts)
				elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
					fallback()
				else
					cmp.complete()
				end
			end, { "i", "s" }),

			["<S-Tab>"] = cmp.mapping.select_prev_item(select_opts),

			['<CR>'] = cmp.mapping.confirm({
				select = true,
			}),

			['Space'] = cmp.mapping.select_prev_item(select_opts),
		},

		formatting = {
			format = function(entry, vim_item)
				vim_item.menu = ({
					skkeleton = "[skkelton]",
					nvim_lsp = "",
					path = "",
					buffer = "",
					luasnip = "[luasnip]",
				})[entry.source.name]
				return vim_item
			end,
		},
	})
end

return Plugin
