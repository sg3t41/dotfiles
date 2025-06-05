local Plugin = { "nvim-tree/nvim-tree.lua" }

local config = require('plugins.nvimtree.config')
local keymaps = require('plugins.nvimtree.keymaps')

function Plugin.init()
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
end

Plugin.keys = keymaps.setup()

Plugin.opts = {
  view = {
    float = {
      enable = true,
      open_win_config = config.get_float_config,
    },
    width = function()
      return math.floor(vim.opt.columns:get() * config.FLOAT_SIZE.width_ratio)
    end,
  },

  renderer = {
    root_folder_label = config.generate_label,
    icons = {
      web_devicons = {
        file = { enable = false, color = false },
        folder = { enable = false, color = false },
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
          arrow_closed = "",
          arrow_open = "",
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

function Plugin.config()
  require('nvim-tree').setup(Plugin.opts)
end

return Plugin
