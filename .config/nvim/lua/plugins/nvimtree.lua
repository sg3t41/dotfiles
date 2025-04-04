local Plugin = { "nvim-tree/nvim-tree.lua" }

local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.9

--[[ Git管理されているかを確認する ]]
local function is_git_repo()
	local handle = io.popen('git rev-parse --is-inside-work-tree 2>/dev/null')
	local result = handle:read("*a")
	handle:close()

	return result:match("true") ~= nil
end

--[[ 未コミットの変更があるか確認する]]
local function has_uncommitted_changes()
	if not is_git_repo() then
		return false
	end

	local handle = io.popen('git status --porcelain 2>/dev/null')
	local git_status = handle:read("*a")
	handle:close()

	return git_status ~= ""
end

--[[ 現在のブランチ名を取得する ]]
local function get_current_branch()
	if not is_git_repo() then
		return nil
	end

	local handle = io.popen('git rev-parse --abbrev-ref HEAD 2>/dev/null')
	local branch_name = handle:read("*a"):gsub("%s+", "")
	handle:close()

	if branch_name == "" then
		return nil
	end

	return branch_name
end

-- [[ラベルを生成する]]
local function label(path)
	local str = ""
	local cwd = vim.fn.getcwd()
	local current_dir = cwd:match("^.+/(.+)$") or cwd

	local current_branch = get_current_branch()
	if current_branch then
		str = current_dir .. " (" .. current_branch .. ")"
	else
		str = current_dir
	end

	if has_uncommitted_changes() then
		str = str .. "*"
	end

	return str
end

Plugin.opts = {
	view = {
		float = {
			enable = true,
			open_win_config = function()
				local screen_w = vim.opt.columns:get()
				local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
				local window_w = screen_w * WIDTH_RATIO
				local window_h = screen_h * HEIGHT_RATIO
				local window_w_int = math.floor(window_w)
				local window_h_int = math.floor(window_h)
				local center_x = (screen_w - window_w) / 2
				local center_y = ((vim.opt.lines:get() - window_h) / 2)
						- vim.opt.cmdheight:get()
				return {
					border = 'rounded',
					relative = 'editor',
					row = center_y,
					col = center_x,
					width = window_w_int,
					height = window_h_int,
				}
			end,
		},
		width = function()
			return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
		end,
	},

	renderer = {
		root_folder_label = label,
		-- group_empty = label,
		-- root_folder_label = true,
		-- root_folder_modifier = ':t',
		icons = {
			web_devicons = {
				file = {
					enable = false,
					color = false,
				},
				folder = {
					enable = false,
					color = false,
				},
			},
			git_placement = "after",
			modified_placement = "after",
			show = {
				file = false,
				folder = false,
				folder_arrow = true,
				git = true,
				modified = true,
				hidden = false,
				diagnostics = true,
				bookmarks = false,
			},
			glyphs = {
				default = "",
				symlink = "",
				bookmark = "",
				modified = "[+]",
				hidden = "",
				folder = {
					arrow_closed = "",
					arrow_open = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = "*",
					staged = "↑",
					unmerged = "?",
					renamed = "",
					untracked = "↓",
					deleted = "-",
					ignored = ".",
				},
			},
		},


	},

	diagnostics = {
		enable = true,
		show_on_dirs = false,
		show_on_open_dirs = true,
		debounce_delay = 50,
		severity = {
			min = vim.diagnostic.severity.HINT,
			max = vim.diagnostic.severity.ERROR,
		},
		icons = {
			hint = "?",
			info = "i",
			warning = "!",
			error = "x",
		},
	},
	modified = {
		enable = true,
		show_on_dirs = false,
		show_on_open_dirs = true,
	},

	hijack_directories = {
		enable = true,
		auto_open = true,
	},
	filters = {
		dotfiles = false,
		git_ignored = false,
		custom = {},
	},

}

function Plugin.init()
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1
end

Plugin.keys = {
	{ "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "ファイラの開閉" } },

	-- 現在開いているファイルにフォーカスしてファイラの開閉を行う
	{ "<leader>f", function()
		local view = require 'nvim-tree.view'

		if view.is_visible() then
			-- nvim-treeが開いている場合は閉じる
			view.close()
		else
			-- nvim-treeが閉じている場合は開いて、現在のファイルにフォーカスする
			vim.cmd(":NvimTreeFindFile")
		end
	end,
		{ desc = "現在開いているファイルの場所でファイラを表示" }
	},

	-- タブの可視化トグル
	{ "<leader>z", function()
		if vim.o.showtabline == 0 then
			vim.cmd("set showtabline=2")
		else
			vim.cmd("set showtabline=0")
		end
	end, { silent = true, noremap = true, desc = "タブの可視/不可視" } }
}

Plugin.config = function()
	require('nvim-tree').setup(Plugin.opts)
end

return Plugin
