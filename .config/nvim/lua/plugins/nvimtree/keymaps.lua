-- nvim-treeのキーマップ定義
local keymaps = {}

function keymaps.setup()
  return {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "ファイラの開閉" },
    
    { "<leader>f", function()
      local view = require('nvim-tree.view')
      
      if view.is_visible() then
        view.close()
      else
        vim.cmd(":NvimTreeFindFile")
      end
    end, desc = "現在開いているファイルの場所でファイラを表示" },
  }
end

return keymaps
