local builtin = require("telescope.builtin")
local ts = require("telescope")
local conf = require('telescope.config').values
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

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

local function search_all_buffers()
    -- Get all open buffers
    local buffers = vim.api.nvim_list_bufs()
    local lines = {}

    -- Collect content from all loaded buffers
    for _, buf in ipairs(buffers) do
        if vim.api.nvim_buf_is_loaded(buf) then
            local buf_name = vim.api.nvim_buf_get_name(buf)
            local buf_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
            for i, line in ipairs(buf_lines) do
                table.insert(lines, {
                    buf = buf,
                    lnum = i,
                    text = line,
                    filename = buf_name,
                })
            end
        end
    end

    -- Create a Telescope picker
    pickers.new({}, {
        prompt_title = "Search All Open Buffers",
        finder = finders.new_table {
            results = lines,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry.filename .. ":" .. entry.lnum .. " " .. entry.text,
                    ordinal = entry.text,
                    lnum = entry.lnum,
                    filename = entry.filename,
                    buf = entry.buf,
                }
            end,
        },
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                vim.api.nvim_set_current_buf(selection.value.buf)
                vim.api.nvim_win_set_cursor(0, {selection.lnum, 0})
            end)
            return true
        end,
    }):find()
end


vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})


local home = os.getenv('HOME') or vim.fn.expand('~')
vim.keymap.set('n', '<leader>nf', function()
  require('telescope.builtin').live_grep({ cwd = home .. "/Note" })
end, { desc = 'Search string in Note' })

vim.keymap.set('n', '<leader>nb', search_all_buffers, { desc = 'Search all open buffers' })
