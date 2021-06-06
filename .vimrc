set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-dadbod'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-heroku'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-pathogen'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-rbenv'
Plugin 'tpope/vim-rake'
Plugin 'preservim/nerdtree'
Plugin 'tommcdo/vim-exchange'
Plugin 'thoughtbot/vim-rspec'
Plugin 'christoomey/vim-rfactory'
call vundle#end()            " required
filetype plugin indent on    " required

set nowrap
set relativenumber
set nu

" Remove Trailing Spaces
autocmd! BufWritePre * :%s/\s\+$//e

" 2-space Indentation
set softtabstop=0
set expandtab
set smarttab
set shiftwidth=2

" **** RSpec Launchers ****
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" **** RSpec helpers ****
" maybe put 'it' and 'specify' here too.
nnoremap <C-f>  ?\(describe\\|context\) <CR>/do<CR><Left>i, :focus<Esc><C-o><C-o>
nnoremap <C-p>  ?\(describe\\|context\) <CR>/do<CR><Left>i, :pending<Esc><C-o><C-o>
nnoremap <C-j>  ?\(describe\\|context\) <CR>/do<CR><Left>i, :js<Esc><C-o><C-o>
nnoremap <C-c>  ?, \(:focus\\|:pending\)<CR>:s/, \(:focus\\|:pending\)//g<CR><C-o><C-o>
