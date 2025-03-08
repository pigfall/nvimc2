local builtin = require("telescope.builtin")
local ts = require("telescope")

ts.setup{ 
  defaults = { 
    file_ignore_patterns = { 
      "target" ,
      ".git",
      "node_modules",
      "out"
    }
  }
}
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
