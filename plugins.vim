call plug#begin('~/.vim/plugged')
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'scrooloose/nerdtree'
Plug 'L3MON4D3/LuaSnip'
Plug 'folke/tokyonight.nvim'
Plug 'rcarriga/nvim-notify'
let home = $HOME != '' ? $HOME : expand('~')
let dedicatedNodejs = home . '/' . 'tools/' . 'nodejs-coc/bin/node'
if executable('node')
  " Load coc.nvim if Node.js is installed
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
elseif filereadable(dedicatedNodejs) == 1
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif
Plug 'Mofiqul/vscode.nvim'
call plug#end()
