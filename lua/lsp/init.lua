local autocmd = vim.api.nvim_create_autocmd
autocmd("FileType", {
    pattern = "go",
    callback = function()
        local root_dir = vim.fs.dirname(
            vim.fs.find({ 'go.mod', 'go.work', '.git' }, { upward = true })[1]
        )
        local client = vim.lsp.start({
            name = 'gopls',
            cmd = { 'gopls' },
            -- cmd = function(...)
            --   return vim.lsp.rpc.connect("127.0.0.1",8080)(...)
            -- end,
            root_dir = root_dir,
            on_attach = on_attach

        })
        vim.lsp.buf_attach_client(0, client)
    end
})

autocmd("LspProgress", {
  callback = function(arg)
    vim.print(arg.data.params.value)
    if arg.data.params.value.title == "Indexing" and arg.data.params.value.kind == "end" then
      vim.print("init done ")
    end
  end,
}
)

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
