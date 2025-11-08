syntax on
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,latin1
set nospell
set nocompatible
set incsearch
set ignorecase
set smartcase
set hlsearch
set number

"abbreviations
abbrev funciton function
abbrev teh the
abbrev tempalte template
abbrev fitler filter
abbrev cosnt const
abbrev attribtue attribute
abbrev waht what
abbrev tehn then
abbrev attribuet attribute

"cursorline highlighting
set cursorline
highlight CursorLine                        guifg=NONE guibg=#110000
autocmd InsertEnter * highlight CursorLine  guifg=NONE guibg=#220000
autocmd InsertLeave * highlight CursorLine  guifg=NONE guibg=#110000

"cursor highlighting
highlight Sneak guifg=black guibg=red ctermfg=black ctermbg=red
highlight Comment cterm=italic term=italic gui=italic
highlight Normal ctermbg=none

set autoread
set history=1000

set noswapfile
set nobackup
set undodir=~/.local/share/nvim/undodir
set undofile

set wildmenu
set mouse=a

"cursor settings
set guicursor=n-ci-cr:block,r-o:hor20,i-ve:ver25,v:vCursor
set guicursor+=n-v-c:blinkon0

set backspace=indent,eol,start
set ignorecase
set smartcase
set hlsearch
set incsearch
set nolazyredraw
set magic
set noerrorbells
set visualbell
set t_vb=
set tm=500

"appearance settings
set number " show line numbers
"set wrap " turn on line wrapping
"set linebreak " set soft wrapping
set autoindent  " automatically set indent of new line
set diffopt+=vertical,iwhite,internal,algorithm:patience,hiddenoff
set laststatus=2 " show the status line all the time
set so=7 " set 7 lines to the cursors - when moving vertical
set hidden " current buffer can be put into background
set showcmd " show incomplete commands
set shell=$SHELL
set cmdheight=2 " command bar height
set title " set terminal title
set showmatch " show matching braces
set mat=2 " how many tenths of a second to blink
set updatetime=50
set shortmess+=c

"tab control
set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=4 " the visible width of tabs
set softtabstop=4 " edit as if the tabs are 4 characters wide
set shiftwidth=4 " number of spaces to use for indent and unindent
set shiftround " round indent to a multiple of 'shiftwidth'

"code folding settings
set foldmethod=syntax " fold based on indent
set foldlevelstart=99
set foldnestmax=10 " deepest fold is 10 levels
set nofoldenable " don't fold by default
set foldlevel=1

"toggle invisible characters
set list
set listchars=tab:→\ ,trail:⋅,extends:❯,precedes:❮
set t_Co=256

if &term =~ '256color'
" disable background color erase
set t_ut=
endif

"enable 24 bit color support if supported
if (has("termguicolors"))
    if (!(has("nvim")))
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif
    set termguicolors
endif

if executable('rg')
    let g:rg_derive_root='true'
endif

let loaded_matchparen = 1
let mapleader = " "

" AutoGroups {{{
    " file type specific settings
    augroup configgroup
        autocmd!

        " automatically resize panes on resize
        autocmd VimResized * exe 'normal! \<c-w>='
        autocmd BufWritePost .vimrc,.vimrc.local,init.vim source %
        autocmd BufWritePost .vimrc.local source %
        " save all files on focus lost, ignoring warnings about untitled buffers
        autocmd FocusLost * silent! wa

        " make quickfix windows take all the lower section of the screen
" when there are multiple windows open
        autocmd FileType qf wincmd J
        autocmd FileType qf nmap <buffer> q :q<cr>
    augroup END
" }}}



function! GotoJump()
  jumps
  let j = input("Please select your jump: ")
  if j != ''
    let pattern = '\v\c^\+'
    if j =~ pattern
      let j = substitute(j, pattern, '', 'g')
      execute "normal " . j . "\<c-i>"
    else
      execute "normal " . j . "\<c-o>"
    endif
  endif
endfunction

"don't change to directory when selecting a file
let g:startify_files_number = 5
let g:startify_change_to_dir = 0
let g:startify_custom_header = [ ]
let g:startify_relative_path = 1
let g:startify_use_env = 1


"custom startup list, only show MRU from current directory/project
let g:startify_lists = [
 \  { 'type': 'dir',       'header': [ 'Files '. getcwd() ] },
    \  { 'type': function('helpers#startify#listcommits'), 'header': [ 'Recent Commits' ] },
    \  { 'type': 'sessions',  'header': [ 'Sessions' ]       },
    \  { 'type': 'bookmarks', 'header': [ 'Bookmarks' ]      },
    \  { 'type': 'commands',  'header': [ 'Commands' ]       },
    \ ]

let g:startify_commands = [
    \   { 'up': [ 'Update Plugins', ':PlugUpdate' ] },
    \   { 'ug': [ 'Upgrade Plugin Manager', ':PlugUpgrade' ] },
    \ ]

let g:startify_bookmarks = [
    \ { 'c': '~/.config/nvim/init.vim' },
    \ { 'g': '~/.gitconfig' },
    \ { 'z': '~/.zshrc' }
    \ ]

let g:netrw_browse_split = 2
let g:vrfr_rg = 'true'
let g:netrw_banner = 0
let g:netrw_winsize = 25
set swapfile
set directory^=~/.local/state/nvim/swap//
set undofile
set undodir^=~/.local/state/nvim/undo//
