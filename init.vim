" {{ quick access config file
" set -es to edit VIMRC
lua << EOF
	local first_runtime_path_index = string.find(vim.o["runtimepath"],",") - 1
	local first_runtime_path =  string.sub(vim.o["runtimepath"],0,first_runtime_path_index)
  vim.cmd(string.format("source %s/plugins.vim", first_runtime_path))
	vim.cmd(string.format("nnoremap -e :e %s/init.vim <CR>",first_runtime_path))
	local init_vim_filepath = string.format("%s/init.vim",first_runtime_path)
	vim.cmd(string.format("nnoremap -es :e %s/init.vim <CR>",first_runtime_path))
	vim.cmd(string.format("nnoremap -ss :source %s/init.vim <CR>",first_runtime_path))
	vim.cmd(string.format("let g:init_vim='%s'",init_vim_filepath))
EOF

let mapleader = "'" 

lua << EOF
local lspconfig = require('lspconfig')
lspconfig.gopls.setup {}
require("tzz-init")
EOF


" { တ common_option
" {{ ident
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
" }}
" {{ case
set ignorecase
set smartcase
" }}
" {{ mouse
set mouse=
" }}
" }

inoremap <cr> <Cmd> call TzzEnter()<Cr>
inoremap <c-e> <ESC>A
inoremap <c-a> <ESC>_i
inoremap <c-u> <Down>
inoremap <c-d> <ESC><Right>xi
inoremap <c-j> <ESC>o
inoremap <c-f> <Right>
inoremap <M-f> <ESC>ea
inoremap <c-b> <Left>
inoremap <M-b> <ESC>bi
inoremap <c-k> <ESC><Right>Da
" To see <c-n> binded to which command
" :verbose inoremap <c-n>
inoremap <cr> <Cmd> call TzzEnter()<Cr>
inoremap ) <Cmd> call  TzzFeedLeftParenthese()<CR>
inoremap { {}<left>
inoremap ( ()<left>
inoremap <Leader>w <ESC>:wa<CR>

nnoremap <s-u> :e#<CR> 
nnoremap <Leader>w :wa<CR>
nnoremap <Leader>tt :tabnew<CR>:terminal<CR>
nnoremap <Leader>tc :terminal<CR>
nnoremap <Leader>tp :lua require("utils").term_in_cur_file_dir()<CR>
nnoremap <Leader>ts :vs<CR><c-w>l:terminal<CR>
nnoremap <Leader>vs :vs<CR>
nnoremap <Leader>q :q<CR>
nmap <Leader>0f :tabnew<CR>:tcd ~/Note<CR><Leader>f

tnoremap <c-j> <c-\><c-n> 
