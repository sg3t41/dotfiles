-- nvim-treeのキーマップ定義
local keymaps = {}

function keymaps.setup()
  return {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "ファイラの開閉" },
    
    { "<leader>f", function()
      local api = require('nvim-tree.api')
      
      if api.tree.is_visible() then
        api.tree.close()
      else
        api.tree.find_file(true)
      end
    end, desc = "現在開いているファイルの場所でファイラを表示" },
    
    { "gi", function()
      local api = require('nvim-tree.api')
      api.tree.toggle_gitignore_filter()
    end, desc = "git無視ファイルの表示切り替え", mode = "n", buffer = 0 },
  }
end

return keymaps
