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
Plugin 'honza/vim-snippets'
Plugin 'github/copilot.vim'
call vundle#end()            " required
filetype plugin indent on    " required

" " Open in split window while keeping Netrw untouched
" function! OpenToRight()
"   :normal v
"   let g:path=expand('%:p')
"   :q!
"   execute 'belowright vnew' g:path
"   :normal k<C-l>
" endfunction
"
" " Open in split horiz split window while keeping Netrw untouched
" function! OpenBelow()
"   :normal v
"   let g:path=expand('%:p')
"   :q!
"   execute 'belowright new' g:path
"   :normal k<C-l>
" endfunction
"
" " Shortcuts for splits etc
" function! NetrwMappings()
"   noremap <buffer> <C-l> <C-w>l
"   noremap <silent> <C-e> :call ToggleNetrw()<CR>
"   noremap <buffer> V :call OpenToRight()<CR>
"   noremap <buffer> H :call OpenBelow()<CR>
" endfunction
"
" " Make shortcuts work
" augroup netrw_mappings
"   autocmd!
"   autocmd filetype netrw call NetrwMappings()
" augroup END

" " Open Tree when I open VIM
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :call ToggleNetrw()
" augroup END

" " Define a variable
" let g:NetrwIsOpen=0
" " Open tree if closed, close if opened
" function! ToggleNetrw()
"   if g:NetrwIsOpen
"     let i = bufnr("$")
"     while (i >= 1)
"       if (getbufvar(i, "&filetype") == "netrw")
"         silent exe "bwipeout " . i
"       endif
"       let i-= 1
"     endwhile
"     let g:NetrwIsOpen=0
"   else
"     let g:NetrwIsOpen=1
"     silent Lexplore
"   endif
" endfunction

" " Netrw (built-in file browser)
" let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
" let g:netrw_winsize = 20


" Basic Settings
set nowrap
set relativenumber
set nu
set tabpagemax=500

" Spelling
" set spelllang=en_us,ru_ru,uk
" set spell

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
nnoremap <C-f>  ?it llAhhi, :focus
nnoremap <C-p>  ?\(describe\\|context\) <CR>/do<CR><Left>i, :pending<Esc><C-o><C-o>
nnoremap <C-j>  ?\(describe\\|context\) <CR>/do<CR><Left>i, js: true<Esc><C-o><C-o>
nnoremap <C-c> ?:focu hhhlxxxxxxxx
nnoremap <Leader>j  ?, \(js: true\)<CR>:s/, \(js: true\)//g<CR><C-o><C-o>
