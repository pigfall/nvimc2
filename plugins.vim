call plug#begin('~/.vim/plugged')
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'scrooloose/nerdtree'
Plug 'L3MON4D3/LuaSnip'
Plug 'folke/tokyonight.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'github/copilot.vim'
let home = $HOME != '' ? $HOME : expand('~')
let dedicatedNodejs = home . '/' . 'tools/' . 'nodejs-coc/bin/node'
if executable('node')
  " Load coc.nvim if Node.js is installed
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
elseif filereadable(dedicatedNodejs) == 1
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif
Plug 'Mofiqul/vscode.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'MeanderingProgrammer/render-markdown.nvim'
Plug 'Mathijs-Bakker/godotdev.nvim'
Plug 'nickjvandyke/opencode.nvim'
call plug#end()
