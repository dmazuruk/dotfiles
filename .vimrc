"  __     _____ __  __ ____   ____
"  \ \   / /_ _|  \/  |  _ \ / ___|
"   \ \ / / | || |\/| | |_) | |
"    \ V /  | || |  | |  _ <| |___
"     \_/  |___|_|  |_|_| \_\\____|
"

" Setup {{{

" Use Vim settings, rather then Vi settings (much better!).

" This must be first, because it changes other options as a side effect.
set nocompatible

filetype plugin on

" Enable syntax highlighting.
syntax on

" set colorscheme
colorscheme Monokai

" remap leader key to space
let mapleader = "\<Space>"

" allow to use alt key
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw
" Allow to use escape while recording macro, source:
"https://stackoverflow.com/questions/41308915/vim-recording-a-macro-with-an-escape-key-press-does-not-work-correctly
inoremap <Esc> <C-c>

" Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" mark the 121th column with a warning
highlight ColorColumn ctermbg=yellow
call matchadd('ColorColumn', '\%121v', 100)

" }}}
" Options {{{

set cpoptions+=$
set encoding=utf-8
" Ignore case when searching
set ignorecase "ic
" Search as you type
set incsearch "is
set laststatus=2 title hlsearch
" Use the same symbols as Textmate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬
set modeline
set modelines=5
set nu
" Show line number, cursor position.
set ruler
set splitbelow splitright
set showbreak=↪
set smartcase
" automatic indent. Note that the behavior of this setting is dependent
" on the particular programming language being used.
set smartindent
set timeout ttimeoutlen=50
set wildmenu

" Tabs should be converted to a group of 4 spaces.
" This is the official Python convention
" http://www.python.org/dev/peps/pep-0008/
" I didn't find a good reason to not use it everywhere.
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab

" Settings for folding
set foldlevel=99
" Remember previous folding
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview
" for any file other than .vimrc use foldmethod indent
au BufRead,BufNewFile !.vimrc set foldmethod=indent

" Make calcurse notes markdown compatible:
autocmd BufRead,BufNewFile /tmp/calcurse* set filetype=markdown
autocmd BufRead,BufNewFile ~/.calcurse/notes/* set filetype=markdown

" Automatically deletes all trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" }}}
" Plugins {{{

call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'echuraev/translate-shell.vim'
Plug 'flazz/vim-colorschemes'
Plug 'scrooloose/nerdtree'
" Plug 'scrooloose/syntastic'
Plug 'w0rp/ale'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'nixon/vim-vmath'
Plug 'vim-scripts/vis'
Plug 'shinokada/dragvisuals.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'vimwiki/vimwiki'
Plug 'suan/vim-instant-markdown'
Plug 'wellle/targets.vim'
Plug 'chiel92/vim-autoformat'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
call plug#end()

" }}}
" Plugin Settings {{{

" fzf
map <leader>f :GFiles<CR>
map <leader>F :Files<CR>
map <leader>b :Buffers<CR>
map <leader>a :Ag<CR>

" default translation
let g:trans_default_direction = ":pl"

" open NERDTree
map <leader>n :NERDTreeToggle<CR>
map <leader>m :NERDTreeFind<CR>

" vim-vmath configuration
vmap <expr>  ++  VMATH_YankAndAnalyse()
nmap         ++  vip++

" dragvisuals configuration
vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()

" Remove any introduced trailing whitespace after moving...
let g:DVB_TrimWS = 1

" vimwiki
nmap <Leader>wf <Plug>VimwikiFollowLink
" vimwiki with markdown support
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
" vim-instant-markdown - Instant Markdown previews from Vim
" https://github.com/suan/vim-instant-markdown
let g:instant_markdown_autostart = 0	" disable autostart
map <leader>md :InstantMarkdownPreview<CR>

let g:goyo_width = 120

" }}}
" Key Mappings {{{

:imap jk <Esc>

" To save, ctrl-s
nmap <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>a
" To quit, ctrl-q
nmap <C-q> :q<CR>
imap <C-q> <Esc>:q<CR>

" Shortcut to rapidly toggle 'set list'
nmap <leader>l :set list!<CR>

" insert a new-line after the current line by pressing Enter (Shift-Enter for inserting a line before the current line)
nmap <C-e> O<Esc>
nmap <CR> o<Esc>

" insert break a line in normal mode
nmap <A-i> i<CR><Esc>
nmap <A-o> a<CR><Esc>
nmap <A-p> i<CR><Right>

" provide hjkl movements in Insert mode via the <Alt> modifier key
inoremap <A-h> <Left>
inoremap <A-j> <Down>
inoremap <A-k> <Up>
inoremap <A-l> <Right>

" go to the end of line
imap <C-a> <Esc>A

" navigate using <C-b> and <C-f> in INSERT mode as well
inoremap <C-b> <C-\><C-o><C-b>
inoremap <C-f> <C-\><C-o><C-f>

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+Y
vnoremap <leader>Y "+Y
nnoremap <leader>yy "+yy

nnoremap <leader>p "+p
vnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>P "+P
inoremap <C-p> <Esc>"+pi

" Shortcuts for moving between tabs.
" Ctrl-j to move to the tab to the left
noremap <C-j> gT
" Ctrl-k to move to the tab to the right
noremap <C-k> gt

" ordered list
inoremap #<cr> <esc>0yt o<esc>p^<c-a>A
" unordered list
inoremap -<cr> <esc>^ly0o<esc>p^A

nnoremap <Tab> %

noremap <silent> <leader>/ :noh<cr>:call clearmatches()<cr>

" Keep search matches in the middle of the window and pulse the line when moving to them
nnoremap n nzzzv
nnoremap N Nzzzv

" Reverse word's case
inoremap <A-u> <esc>mzg~iw`za
"Better VIM version
"inoremap <C-u> <esc>mz^f;bv`z:s/\%V;/_/g<cr>`z:noh<cr>a<esc>mzg~iw`za
"Version compatible with ideavim
inoremap <C-u> <esc>mza<cr><esc>`z^f;bv`z:s/;/_/g<cr>J`z:noh<cr>a<esc>mzg~iw`za

" Spell-check set to F6
map <F6> :setlocal spell! spelllang=en_us<CR>

" Fix spelling of the last misspelled word
function! FixLastSpellingError()
    normal! mm[s1z=`m
endfunction
nnoremap <leader>sp :call FixLastSpellingError()<cr>

" Source current file
nnoremap <leader>sop :source %<cr>

" Remove variable/schema e.g. schema.table => table
inoremap <C-y> <esc>3b2dwea

" Select line without whitespace at the beginning and without new line
noremap <leader>v ^vg_

" Use urlview to choose and open a url
noremap <leader>u :w<Home>silent <End> !urlview<CR>

" comment line with #
imap <C-_> <esc><Plug>NERDCommenterToggleli
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterTogglegv

" }}}
" Highlight Word {{{
"
" From Steve Losh (https://bitbucket.org/sjl/dotfiles/src/tip/vim/vimrc)
"
" This mini-plugin provides a few mappings for highlighting words temporarily.
"
" Sometimes you're looking at a hairy piece of code and would like a certain
" word or two to stand out temporarily.  You can search for it, but that only
" gives you one color of highlighting.  Now you can use <leader>N where N is
" a number from 1-6 to highlight the current word in a specific color.

function! HiInterestingWord(n) " {{{
    " Save our location.
    normal! mz

    " Yank the current word into the z register.
    normal! "zyiw

    " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
    let mid = 86750 + a:n

    " Clear existing matches, but don't worry if they don't exist.
    silent! call matchdelete(mid)

    " Construct a literal pattern that has to match at boundaries.
    let pat = '\V\<' . escape(@z, '\') . '\>'

    " Actually match the words.
    call matchadd("InterestingWord" . a:n, pat, 1, mid)

    " Move back to our original location.
    normal! `z
endfunction " }}}

" Mappings {{{

nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>

" }}}
" Default Highlights {{{

hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195

" }}}
" }}}
" Graveyard {{{

" set clipboard=unnamedplus
" nnoremap <leader>d "+d
" xnoremap <leader>d "+d
" nnoremap d "_d
" xnoremap d "_d
" nnoremap <leader>c "+c
" xnoremap <leader>c "+c
" nnoremap x "_x
" xnoremap x "_x
" nnoremap <leader>x "+x
" xnoremap <leader>x "+x
" nnoremap s "_s
" xnoremap s "_s
" nnoremap <leader>s "+s
" xnoremap <leader>s "+s
" nnoremap c "_c
" xnoremap c "_c

" nnoremap y "+y
" vnoremap y "+y
" nnoremap Y "+Y
" vnoremap Y "+Y
" nnoremap yy "+yy
" nnoremap <leader>y y
" vnoremap <leader>y y
" nnoremap <leader>Y Y
" vnoremap <leader>Y Y
"
" nnoremap p "+p
" vnoremap p "+p
" nnoremap P "+P
" vnoremap P "+P
" nnoremap <leader>p p
" vnoremap <leader>p p
" nnoremap <leader>P P
" vnoremap <leader>P P
" inoremap <C-p> <Esc>"+pa

" nmap <C-a> A
" nmap <C-e> <C-o>$
" imap <C-e> <C-o>$

" Status line
" set laststatus=2
" set statusline=
" set statusline+=%-3.3n\ " buffer number
" set statusline+=%f\ " filename
" set statusline+=%h%m%r%w " status flags
" set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
" set statusline+=%= " right align remainder
" set statusline+=0x%-8B " character value
" set statusline+=%-14(%l,%c%V%) " line, character
" set statusline+=%<%P " file position

" " syntastic configuration
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
"
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0


" }}}
