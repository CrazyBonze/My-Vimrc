" Tell vim to keep a backup file
set backup

" Move temp files
set directory-=$HOME/tmp
set directory^=$HOME/tmp//
set backupdir-=$HOME/tmp
set backupdir^=$HOME/tmp//

" Fixes color issue when vim is used in tmux
" https://unix.stackexchange.com/a/363374
set background=dark

" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" puts insert message at bottom of screen when inserting
set showmode

autocmd FileType cpp,h,javascript,css,php,rb,py set textwidth=79
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=4
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile *.py set softtabstop=4

filetype plugin indent on    " required
" Needed for Syntax Highlighting and stuff
filetype on
filetype plugin on
syntax enable
set grepprg=grep\ -nH\ $*

" Who doesn't like autoindent?
set autoindent

" Spaces are better than a tab character
set expandtab
set smarttab

" Show the cursor position all the time
set ruler

" Fix the auto indent issue when pasting
" https://gitlab.com/gnachman/iterm2/-/wikis/Paste-Bracketing
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
        set pastetoggle=<Esc>[201~
        set paste
        return ""
endfunction

" redefine ^J ^H ^K ^L to move between windows (used w/split screens)
nn ^K ^Wk
nn ^H ^Wh
nn ^L ^Wl
nn <C-J> ^Wj

" Swap ; and :  Convenient.
nnoremap ; :
nnoremap : ;

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Necesary  for lots of cool vim things
set nocompatible

" This shows what you are typing as a command.
set showcmd

" Folding Stuffs
set foldmethod=marker

" Cool tab completion stuff
set wildmenu
set wildmode=list:longest,full

" Enable mouse support in console
set mouse=a

" Use system clipboard
set clipboard=unnamedplus

" Got backspace?
set backspace=2

" Line Numbers PWN!
set number

" Ignoring case is a fun trick
set ignorecase

" And so is Artificial Intellegence!
set smartcase

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap jj <Esc>
nnoremap JJJJ <Nop>

" Incremental searching is sexy
set incsearch

" Highlight things that we find with the search
" figure out a good way to clear this
set hlsearch

"Status line gnarliness
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]

" Restore cursor position to where it was before
augroup JumpCursorOnEdit
au!
autocmd BufReadPost *
\ if expand("<afile>:p:h") !=? $TEMP |
\   if line("'\"") > 1 && line("'\"") <= line("$") |
\     let JumpCursorOnEdit_foo = line("'\"") |
\     let b:doopenfold = 1 |
\     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
\        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
\        let b:doopenfold = 2 |
\     endif |
\     exe JumpCursorOnEdit_foo |
\   endif |
\ endif
" Need to postpone using "zv" until after reading the modelines.
autocmd BufWinEnter *
\ if exists("b:doopenfold") |
\   exe "normal zv" |
\   if(b:doopenfold > 1) |
\       exe  "+".1 |
\   endif |
\   unlet b:doopenfold |
\ endif
augroup END
