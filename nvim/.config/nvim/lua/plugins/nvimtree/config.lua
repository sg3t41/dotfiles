-- nvim-tree設定を分離
local config = {}

-- 定数
config.FLOAT_SIZE = {
	height_ratio = 0.8,
	width_ratio = 0.9,
}

-- フローティングウィンドウの設定を生成
function config.get_float_config()
	local screen_w = vim.opt.columns:get()
	local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
	local window_w = screen_w * config.FLOAT_SIZE.width_ratio
	local window_h = screen_h * config.FLOAT_SIZE.height_ratio
	local window_w_int = math.floor(window_w)
	local window_h_int = math.floor(window_h)
	local center_x = (screen_w - window_w) / 2
	local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()

	return {
		border = 'rounded',
		relative = 'editor',
		row = center_y,
		col = center_x,
		width = window_w_int,
		height = window_h_int,
	}
end

-- ルートフォルダのラベル生成
function config.generate_label()
	local git_utils = require('utils.git')

	local cwd = vim.fn.getcwd()
	local current_dir = cwd:match("^.+/(.+)$") or cwd
	local str = current_dir

	local current_branch = git_utils.get_current_branch()
	if current_branch then
		str = str .. " (" .. current_branch .. ")"
	end

	if git_utils.has_uncommitted_changes() then
		str = str .. "*"
	end

	return str
end

return config
