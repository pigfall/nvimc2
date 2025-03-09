call plug#begin('~/.vim/plugged')
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'scrooloose/nerdtree'
Plug 'L3MON4D3/LuaSnip'
Plug 'folke/tokyonight.nvim'
Plug 'rcarriga/nvim-notify'
if executable('node')
  " Load coc.nvim if Node.js is installed
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif
Plug 'Mofiqul/vscode.nvim'
call plug#end()
