vim.notify = require("notify")

-- Safely call coc#config('coc.enabled', 1)
  local ok, err = pcall(vim.fn['coc#config'], 'coc.enabled', 1)
  if ok then
    if vim.fn.exists('*coc#refresh') == 1 then
      local keyset = vim.keymap.set
      keyset("i", "<c-o>", "coc#refresh()", {silent = true, expr = true})
      keyset("n", "<c-]>", "<Plug>(coc-definition)", {silent = true})
      keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
      keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
      keyset("n", "gr", "<Plug>(coc-references)", {silent = true})
      -- Set nvim-notify as the notification handler
  vim.notify = require("notify")

  -- Configure coc.nvim notifications
  vim.fn['coc#config']('notification', {
    enabled = true,    -- Enable notifications
    progress = true    -- Show progress updates
  })

  -- Set log level to info for LSP startup details
  vim.fn['coc#config']('coc.preferences.logLevel', 'debug')

  -- Optional: Ensure coc.nvim is enabled
  vim.fn['coc#config']('coc.enabled', true)
      return
    end
  end

local autocmd = vim.api.nvim_create_autocmd
autocmd("FileType", {
    pattern = "go",
    once = true,
    nested = true,
    callback = function()
        local lsp_init_notify = {}
        local setting_up_workspace_title = "Setting up workspace"
        autocmd("LspProgress", {
          callback = function(arg)
            local title = arg.data.params.value.title
            local kind = arg.data.params.value.kind
            vim.print(title,kind)
            if title == setting_up_workspace_title and kind == "begin" then
              lsp_init_notify = vim.notify(setting_up_workspace_title,vim.log.levels.INFO,{timeout=false,title="Initing Language Server"})
              return
            end
            if title == setting_up_workspace_title and kind == "end" then
              vim.notify("Done",vim.log.levels.INFO,{timeout=5000, title="LSP Initialization Is Compleleted",replace=lsp_init_notify})
              return
            end
            vim.print(arg.data.params.value)
            if title == "Indexing" and kind == "end" then
              vim.notify("Done",vim.log.levels.INFO,{timeout=5000, title="LSP Initialization Is Compleleted",replace=lsp_init_notify})
              return
            end
            if title == "Indexing" then
              vim.notify(arg.data.params.value.message,vim.log.levels.INFO,{timeout=false, title="Initing Language Server",replace=lsp_init_notify})
            end
        end,
      })


        local root_dir = vim.fs.dirname(
            vim.fs.find({ 'go.mod', 'go.work', '.git' }, { upward = false })[1]
        )
        local client = vim.lsp.start({
            name = 'gopls',
            cmd = { 'gopls' },
            -- cmd = function(...)
            --   return vim.lsp.rpc.connect("127.0.0.1",8080)(...)
            -- end,
            root_dir = root_dir,
            on_attach = on_attach,
            settings = {
              gopls={
              hints = {
                rangeVariableTypes = true,
                parameterNames = true,
                constantValues = true,
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                functionTypeParameters = true,
              },
              },
            },
        })
        vim.lsp.buf_attach_client(0, client)
        vim.lsp.inlay_hint.enable()
        autocmd("FileType",{
          pattern = "go",
          callback = function()
            vim.lsp.buf_attach_client(0, client)
          end,
        })
    end
})


autocmd("FileType", {
    pattern = "rust",
    callback = function()
        local root_dir = vim.fs.dirname(
            vim.fs.find({"Cargo.toml"}, { upward = false })[1]
        )
        local client = vim.lsp.start({
            name = 'rust-analyzer',
            cmd = { 'rust-analyzer' },
            -- cmd = function(...)
            --   return vim.lsp.rpc.connect("127.0.0.1",8080)(...)
            -- end,
            root_dir = root_dir,
            -- init_options={["rust-analyzer.cargo.target"] = "i686-linux-android"},
            init_options={
              ["cargo"] = {
                  target= "i686-linux-android"
              },
            },
            on_attach = on_attach,
        })
        vim.lsp.buf_attach_client(0, client)
    end
})

function on_attach(client,bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', '<c-]>', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<space>f', function()
    vim.lsp.buf.format { async = true }
  end, opts)
end
