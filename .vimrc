" Inspired by
" http://dougireton.com/blog/2013/02/23/layout-your-vimrc-like-a-boss/
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" http://nvie.com/posts/how-i-boosted-my-vim/
" --------------------------------------------------------------------------- "
" --------------------------------------------------------------------------- "
"                                 OPTIONS
" --------------------------------------------------------------------------- "
" --------------------------------------------------------------------------- "
"  important
" --------------------------------------------------------------------------- "

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" --------------------------------------------------------------------------- "
"  moving around, searching and patterns
" --------------------------------------------------------------------------- "

set nostartofline            " keep cursor in same column for long movements
set ignorecase               " Do case insensitive matching...
set smartcase                " ... except when pattern contains uppercase
set incsearch                " Incremental search

" --------------------------------------------------------------------------- "
"  displaying text
" --------------------------------------------------------------------------- "

set scrolloff=3              " Keep some lines around current line
let &showbreak = '+++ '      " Explicitly mark line continuations with +++
set linebreak                " Only break lines at word boundaries
set number                   " Turn on line numbering
set list                     " Show whitespace using characters ...
set listchars=tab:>-,trail:. " ... tabs and trailing spaces

" --------------------------------------------------------------------------- "
"  highlighting and colors
" --------------------------------------------------------------------------- "

set background=dark          " Adjust colors for dark terminal background
set hlsearch                 " Highlight all matches of previous search

" --------------------------------------------------------------------------- "
"  multiple windows
" --------------------------------------------------------------------------- "

set laststatus=2             " Windows always have status lines
set winheight=15             " Current window shouldn't be too small
set winwidth=80              " or too narrow
set hidden                   " Hide buffers when they are abandoned
set switchbuf=useopen,split  " For quick fix lists, jump to file containing
                             " errors if already open, else split to open it
set splitbelow               " Put newly opened split windows below...
set splitright               " ... and to the right of current window

" --------------------------------------------------------------------------- "
" messages and info
" --------------------------------------------------------------------------- "

set ruler                    " Show row/column of cursor
set report=0                 " Always report number of lines altered
set vb t_vb=                 " No bell or visual bell
set showcmd                  " Show (partial) command in status line.

" --------------------------------------------------------------------------- "
" editing text
" --------------------------------------------------------------------------- "

set undolevels=4096          " Lots of undo
set textwidth=79             " Used to break comments (and text if enabled)
set backspace=2              " Can backspace over everything in insert mode
set formatoptions=croq       " Automatically wrap and 'gq' comments, and insert
                             " comment leaders on new lines
set formatoptions+=1         " Don't break after 1-letter words
set formatoptions+=n         " Autoformat numbered lists
set completeopt=menuone      " Always show popup menu for C-n completion...
set completeopt+=preview     " ... and show extra information about completion
set showmatch                " Show matching brackets.

" --------------------------------------------------------------------------- "
" tabs and indenting
" --------------------------------------------------------------------------- "

" These settings will likely be overridden by particular project / language
" style conventions. These are generic defaults basically to avoid doing any
" shocking automatic changes.
set tabstop=8                " Display tabs as 8 spaces
set expandtab                " Put expanded tabs (spaces) in the file when
                             " <Tab> pressed or when using autoindent, <<, >>
set shiftwidth=2             " Use 2 spaces worth for autoindent, <<, >>
set softtabstop=2            " Use 2 spaces worth for <Tab> and <Backspace>
set autoindent               " Automatically indent to match current line
                             " (will be overridden by filetype indents etc)
set copyindent               " match space/tab mix of prev line for autoindent
set preserveindent           " Preserve space/tab mix of line for <<, >>, etc


" --------------------------------------------------------------------------- "
" command line editing
" --------------------------------------------------------------------------- "

set history=128              " Remember last 128 commands
set wildmode=longest,list    " Tab complete file names bash-style
" Wildcards ignore lots of files we would never open in vim
set wildignore+=*.bak,*.swp,*.tmp,*~
set wildignore+=*.o,*.a,*.d,*.so,*.out
set wildignore+=*.class,*.gz,*.hi,*.pdf,*.dvi,*.aux,*.log

" --------------------------------------------------------------------------- "
" various
" --------------------------------------------------------------------------- "

set title                    " Change window title to include filename
set mouse=                   " Disable mouse
set nomodeline               " Mode lines are scary
set nowritebackup            " No backup files when overwriting
set noswapfile               " No swap files
set tags=tags;/              " Search up parent dir tree for tags
set viminfo='100             " Save registers, pattern/cmd history, and marks
                             " to viminfo file to be loaded on startup

" --------------------------------------------------------------------------- "
" --------------------------------------------------------------------------- "
"                      AUTOCOMMANDS AND EXTERNAL FILES
" --------------------------------------------------------------------------- "
" --------------------------------------------------------------------------- "
if has('autocmd')

" Jump to the last position when reopening a file.
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \ | exe "normal! g'\"" | endif

" Fix up some file extensions vim doesn't know about
au BufNewFile,BufRead *.rkt set filetype=scheme  " plt racket
au BufNewFile,BufRead *.flex set filetype=lex    " gnu flex
au BufNewFile,BufRead *.do set filetype=sh       " apenwarr redo
au BufNewFile,BufRead *.md set filetype=text     " markdown

" Automagically open quickfix / location window when running
" appropriate commands (:make, :grep, etc.)
au QuickFixCmdPost [^l]* nested cwindow
au QuickFixCmdPost    l* nested lwindow

filetype plugin indent on    " Detect filetypes, load plugin and indent files

endif

" --------------------------------------------------------------------------- "
"                                MAPPINGS
" --------------------------------------------------------------------------- "

" No arrow keys in insert, normal, visual, or operator mode
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" Use <Space> as map leader for custom fancy mappings
let mapleader=" "

" Quickly stop highlighting most recent search
nnoremap <Leader><Space> :nohlsearch<CR>
" Turn paste mode on and off
nnoremap <Leader>p :set paste!<CR>
" Turn line numbering on and off
" This doesn't quite work.
nnoremap <Leader>l :set number!<CR>

" Window splitting
nnoremap <Leader>s :split<CR>
nnoremap <Leader>v :vsplit<CR>
" Window navigation (stop mashing C-w C-w)
nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l

" Equalize splits for readability
nnoremap <Leader>= <C-w>=

" --------------------------------------------------------------------------- "
" --------------------------------------------------------------------------- "
"                                 COLORS
" --------------------------------------------------------------------------- "
" --------------------------------------------------------------------------- "

syntax enable                " Turn on syntax highlighting

" Highlight lines that are too long (80+ characters)
highlight link OverLength ErrorMsg
match OverLength /\%>79v.\+/


" Highlight end-of-line whitespace. If expanding tabs, highlight all tab
" characters. If not, highlight all spaces appearing before tabs
" (still want to allow spaces to align line continuations)
" Hideous autocmd is to avoid highlighting end-of-line space while still
" typing in insert mode.
highlight link ExtraWhitespace IncSearch
if &expandtab
	2match ExtraWhitespace /\s\+$\|\t\+/
	autocmd BufWinEnter * 2match ExtraWhitespace /\s\+$\|\t\+/
	autocmd InsertEnter * 2match ExtraWhitespace /\s\+\%#\@<!$\|\t\+/
	autocmd InsertLeave * 2match ExtraWhitespace /\s\+$\|\t\+/
else
	2match ExtraWhitespace /\s\+$\| \+\ze\t/
	autocmd BufWinEnter * 2match ExtraWhitespace /\s\+$\| \+\ze\t/
	autocmd InsertEnter * 2match ExtraWhitespace /\s\+\%#\@<!$\| \+\ze\t/
	autocmd InsertLeave * 2match ExtraWhitespace /\s\+$\| \+\ze\t/
endif
