"call pathogen#infect()

let loaded_matchparen = 1
set ts=4
set ai
set noexpandtab
set enc=utf-8
set fencs=ucs-bom,utf-8,euc-jp,shift_jis,iso-2022-jp

au BufRead,BufNewFile *.go set ts=4
au BufRead,BufNewFile *.pm set ts=4
au BufRead,BufNewFile *.pl set ts=4
au BufRead,BufNewFile *.yml set ts=2 expandtab
au BufRead,BufNewFile *.yaml set ts=2 expandtab
au BufRead,BufNewFile *.py set ts=2 expandtab

filetype on
"nnoremap <silent> <F8> :TlistOpen<CR>
"nnoremap <silent> <F8> :TlistToggle<CR>

set wildmenu
set incsearch
set ignorecase
set smartcase
set nohlsearch
"set laststatus=2
"set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

highlight NoneText cterm=NONE ctermfg=black ctermbg=black
"highlight i:StatusLine

set term=builtin_linux
set ttytype=builtin_linux
"colorscheme torte
syntax on

map <F12> <ESC>gt
map <F11> <ESC>gT

autocmd FileType * setlocal formatoptions-=ro

