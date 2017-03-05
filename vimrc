"""   /================================[[  .vimrc  ]]=============================================\
 ""|    
 ""|    YAVMRC: Yet Another ViMRC
 ""|    
 ""|    See: http://vimdoc.sourceforge.net/htmldoc/syntax.html
 ""|         http://vimdoc.sourceforge.net/htmldoc/options.html
 ""|         https://dougblack.io/words/a-good-vimrc.html
 ""|         https://github.com/tpope/vim-sensible
 ""|    
 ""|    To reload these settings without restarting vim:
 ""|    
 ""|         :source ~/.vimrc    ~or~    :so ~/.vimrc
 ""|    
 """  \-------------------------------------------------------------------------------------------/




""  [====[  Plugins  ]============================================================================]

""  Activate Pathogen plugin manager
 "  See: https://github.com/tpope/vim-pathogen
 "       https://gist.github.com/romainl/9970697 (vim plugin directory layout)
execute pathogen#infect()

""  When loading a file, attempt to detect filetype and load its plugin & indentation
filetype plugin indent on    

""  Configure Airline - https://github.com/vim-airline/vim-airline
let g:airline#extensions#tabline#enabled      = 1      " Enable the list of buffers
let g:airline#extensions#tabline#show_buffers = 1      " Show buffers
let g:airline#extensions#tabline#show_tabs    = 0      " Hide tabs, so it doesn't hide buffer names
let g:airline#extensions#tabline#fnamemod     = ':t'   " Show just the filename


""  [====[  Display  ]============================================================================]

syntax on              " Enable syntax highlighting
set laststatus=2       " Always display the status line
set background=dark    " Does my terminal have a dark background? Survey says: YES!

"syntax enable
colorscheme solarized

""|  View all installed colorschemes:
 "|  
 "|    :colo [space] [ctl-d]
 "|    :he cterm-colors
 "|    :he highlight-groups
 "|    :he group-name
 ""

""  Syntax highlighting
highlight Normal       ctermfg=white      ctermbg=None
"highlight Normal      ctermfg=white
"highlight Comment     ctermfg=DarkBlue
"highlight Comment     ctermfg=Black
"highlight Type        ctermfg=Green
"highlight Statement   ctermfg=DarkYellow
"highlight Special     ctermfg=LightGray
"highlight Identifier  ctermfg=DarkCyan
"highlight PreProc     ctermfg=DarkCyan
"highlight Constant    ctermfg=DarkGreen

""  Search & navigation highlighting
"highlight CursorLine                                        cterm=bold
highlight CursorLine                      ctermbg=None      cterm=bold
highlight IncSearch   ctermfg=black       ctermbg=yellow    cterm=bold
highlight Search      ctermfg=white       ctermbg=darkblue
highlight ColorColumn                     ctermbg=0


""  [====[  Other assorted settings  ]============================================================]

""  Tabs & spaces
set expandtab         " Use spaces instead of tabs
set tabstop     =8    " # of visual spaces/tab
set softtabstop =0    " # of spaces/tab when editing
set shiftwidth  =2    " # of columns to indent text
set smarttab          " Tabs are only used for indentation

""  UI
set cursorline        " Highlight current line
set showcmd           " Show command in bottom bar
set wildmenu          " Visual autocomplete
set showmatch         " Highlight matching [{()}]
set number           " Show lines numbers
"set cursorcolumn     " Highlight current col
set colorcolumn=100

""  Search
set incsearch         " Search as characters are entered
set hlsearch          " Highlight searches
set ignorecase        " Like, y'know... ignore case
"set noignorecase     " Searches are case-sensitive

""|  Smartcase: Case-insensitive when search string has only lowercase letters.
 "|             Can be overridden with \c or \C at end of search string:
 "|   
 "|               /string     case-insensitive
 "|               /STring     case-sensitive
 "|               /string\c   case-insensitive
 "|               /string\C   case-sensitive
 "|   
 "|             NOTE: this also applies to SUBSTITUTIONS.
set smartcase

""  Open split planes to the right and bottom
set splitbelow
set splitright


""  [====[  Key bindings & Movement  ]============================================================]
 "    
 "|  NOTE: One of the strengths of vim is its ubiquity. We don't want to diverge
 "|        much from standard keybindings (lest it screw up our muscle memory on
 "|        foreign machines) so any changed bindings should be unlikely to cause
 "|        significant issues when not present.
 ""

""|  Turn off search highlighting w/ \<space>
nnoremap <leader><space> :nohlsearch<CR>

""|  Streamline switching between splits by dropping the leading C-w
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

""|  Enable mouse support in NORMAL and VISUAL modes. 
 "|  This swallows click-to-paste, so it's disabled in INSERT mode. 
 "|  Mouse support provides the following:
 "|    
 "|    *  Highlighting text puts vim into VISUAL mode
 "|    *  Click to move cursor
 "|    *  Scroll wheel support
 "|    *  Click to select split
 ""
set mouse=nv

""|  Module: wrapped-line-movement. Press \w to toggle wrapping on or off.
 "|  When wrap is on, the cursor movement keys are mapped to move by display lines.
 ""

""  [====[  Standard key bindings  ]==============================================================]

""|  Movement
 "|   
 "|     H    Move to   top      of the screen   ("High")
 "|     M    Move to   middle   of the screen   ("Middle")
 "|     L    Move to   bottom   of the screen   ("Low")
 "|    zt    Scroll line with the cursor to   TOP      of the screen
 "|    z.    Scroll line with the cursor to   center   of the screen
 "|    zb    Scroll line with the cursor to   BOTTOM   of the screen
 "|    ^b    Scroll one page   up     ("Back")
 "|    ^f    Scroll one page   down   ("Forward")
 "|    ^u    Scroll half-page   UP
 "|    ^d    Scroll half-page   DOWN
 "|    ^y    Scroll one line   up
 "|    ^e    Scroll one line   down
 "|     %    Jump to matching bracket
 ""

""|  Splits / Windows
 "|  :he splits
 "|    
 "|    ctrl + w _    Max out the height of the current split
 "|    ctrl + w |    Max out the width of the current split
 "|    ctrl + w =    Normalize all split sizes, which is very handy when resizing terminal
 "|    Ctrl+W R      Swap top/bottom or left/right split
 "|    Ctrl+W T      Break out current window into a new tabview
 "|    Ctrl+W o      Close every window in the current tabview but the current one
 ""

""|  Tabs / Layouts / Collection of windows
 "|  :he tabs
 "|     
 "|    gt          Go to next tab
 "|    gT          Go to prev tab
 "|    {i}gt       Go to tab at index i
 "|    Ctl-PgDn    Go to next tab
 "|    Ctl-PgUp    Go to prev tab
 ""




"""   \================================[[  ! END .vimrc !  ]]=====================================/
