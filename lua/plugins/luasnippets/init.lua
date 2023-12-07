require("luasnip.loaders.from_snipmate").lazy_load()
local ls = require("luasnip")

vim.api.nvim_exec2(
[[
imap <silent><expr> <c-l> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
snoremap <silent> <c-l> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

]]
,{})
