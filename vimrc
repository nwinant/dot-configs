"""====================================[[  .vimrc  ]]============================================""
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
 ""|    To get the value of a setting, either append '?', or prepend '&' (for option). E.g.:
 ""|    
 ""|         :set colorcolumn?
 ""|         echo &colorcolumn
 ""|    
 """---------------------------------------------------------------------------------------------""

""========|  Standard key bindings  |============================================================//

""|  Movement
 "|  
 "|    :0        Move to beginning of buffer
 "|    :$        Move to end       of buffer
 "|  
 "|    H         Move to top    of the screen    ("High")
 "|    M         Move to middle of the screen    ("Middle")
 "|    L         Move to bottom of the screen    ("Low")
 "|
 "|    ^         Move to beginning of line
 "|    $         Move to end       of line
 "|
 "|    ctrl-b    Scroll one page  up             ("Back")
 "|    ctrl-f    Scroll one page  down           ("Forward")
 "|  
 "|    ctrl-u    Scroll half-page up             ("Up")
 "|    ctrl-d    Scroll half-page down           ("Down")
 "|  
 "|    ctrl-y    Scroll one line  up
 "|    ctrl-e    Scroll one line  down
 "|  
 "|    zt        Scroll line with the cursor to top    of the screen
 "|    z.        Scroll line with the cursor to center of the screen
 "|    zb        Scroll line with the cursor to bottom of the screen
 "|  
 "|    %         Jump to matching bracket
 ""

""|  Splits / Windows (:he split)
 "|    
 "|    :sp               Split, horizontal
 "|    :split           
 "|    :vsp              Split, vertical
 "|    :vsplit          
 "|    :res +N           Increase current window height by 10 rows
 "|    :resize
 "|    :vertical res +N  Increase current window width by 10 cols
 "|    :vertical resize
 "|    :10vsp ~/.vimrc   Split, 10px wide, loading ~/.vimrc
 "|    
 "|    ctrl-w s          Split, horizontal (may interfere w/ some terms; if so, CTRL-Q)
 "|    ctrl-w v          Split, vertical
 "|    ctrl-w w          Toggle split focus
 "|    ctrl-^            Edit alternate file
 "|    
 "|    :ls               List buffers
 "|    :hide             Hide current window w/o closing it
 "|    :unhide           Unhide buffers
 "|    :clo[se][!]       Close current window
 "|    :on[ly][!]        Close all other windows
 "|    :q[uit][!]        Quit current window
 "|                        If this is the last window for a buffer, all changes are lost.
 "|    
 "|    ctrl-w 10 <       Decrease current width by 10 (default: 1)
 "|    ctrl-w 10 >       Increase current width by 10 (default: 1)
 "|    ctrl-w 10 |       Set current width to 10 (default: max width)
 "|    ctrl-w 10 +       Increase current height by 10 (default: 1)
 "|    ctrl-w 10 -       Decrease current height by 10 (default: 1)
 "|    ctrl-w 10 _       Set current height to 10 (default: max height)
 "|    ctrl-w =          Normalize all split sizes, which is handy when resizing terminal
 "|    ctrl-w R          Swap top/bottom or left/right split
 ""

""|  Tabs (vim tabs are better thought of as layouts, or collection of windows. See :he tabs)
 "|     
 "|    gt           Go to next tab
 "|    gT           Go to prev tab
 "|    {i}gt        Go to tab at index i
 "|    ctrl-PgDn    Go to next tab
 "|    ctrl-PgUp    Go to prev tab
 "|    ctrl-w T     Break out current window into a new tabview
 "|    ctrl-w o     Close every window in the current tabview but the current one
 ""

""========|  Startup  |==========================================================================//

""|  Disables limitations imposed for backwards-compatibility with vi.
 "|  Normally, this should be set automatically by the presence of ~/.vimrc, but we're making it
 "|  explicit here in case the environment overrides that default behavior.
 "|  Because this changes other options, it should be at the start of the file.
 "|  
 "|  See :help compatible
 ""  
set nocompatible

""|  Don't show :intro message when starting vim.
set shortmess=I

""========|  Functions  |========================================================================//

""|  Enable luxurious UI decor: line numbers, column markers, etc. Specifically, this enables those
 "|  settings that cause complications (e.g., selecting text); see DisableBling() & ToggleBling().
 "|  
 "|  Provides mouse support in NORMAL and VISUAL modes. 
 "|  This swallows click-to-paste, so it's disabled in INSERT mode. 
 "|  Mouse support provides the following:
 "|    
 "|    *  Highlighting text puts vim into VISUAL mode
 "|    *  Click to move cursor
 "|    *  Scroll wheel support
 "|    *  Click to select split
 ""
function EnableBling()
  set colorcolumn=80,100  "" Highlight cols 80 & 100
  set mouse=nv            "" Enable mouse support in NORMAL and VISUAL modes
  set cursorline          "" Highlight current line
  set number              "" Display line numbers
endfun

function DisableBling()
  set colorcolumn=
  set mouse=
  set nocursorline
  set nonumber
endfun

""|  Toggle UI elements that can cause complications, such as when selecting text.
 ""
function ToggleBling()
  if &colorcolumn ==? ''
    call EnableBling()
  else
    call DisableBling()
  endif
endfun

""========|  Key bindings & Movement  |==========================================================//
 "    
 "|  NOTE: One of the strengths of vim is its ubiquity. We don't want to diverge
 "|        much from standard keybindings (lest it screw up our muscle memory on
 "|        foreign machines) so any changed bindings should be unlikely to cause
 "|        significant issues when not present.
 "|
 "|        See :help map-modes
 "|
 "|        By default, the leader is "\"
 ""
nnoremap <silent> <leader><space> :nohlsearch<CR>          | ""|  \-SPACE Search highlighting off
nnoremap <silent> <leader>#       :call ToggleBling()<CR>  | ""|  \-#     Toggle line nums, etc.

""|  Force use of hjkl, with arrow keys providing documentation.
" ... Turns out, this becomes unspeakably annoying!
"noremap <Left>  :echo 'Nope! Use --> [h] j  k  l  <--'<CR>
"noremap <Down>  :echo 'Nope! Use -->  h [j] k  l  <--'<CR>
"noremap <Up>    :echo 'Nope! Use -->  h  j [k] l  <--'<CR>
"noremap <Right> :echo 'Nope! Use -->  h  j  k [l] <--'<CR>

""|  Streamline switching between splits by dropping the leading C-w
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

""|  Module: wrapped-line-movement. Press \w to toggle wrapping on or off.
 "|  When wrap is on, the cursor movement keys are mapped to move by display lines.
 ""

""========|  Plugins  |==========================================================================//

""  Activate Pathogen plugin manager
 "  See: https://github.com/tpope/vim-pathogen
 "       https://gist.github.com/romainl/9970697 (vim plugin directory layout)
execute pathogen#infect()

""  When loading a file, attempt to detect filetype and load its plugin & indentation
"filetype plugin indent on    
filetype plugin on

""  Configure Airline - https://github.com/vim-airline/vim-airline
let g:airline#extensions#tabline#enabled      = 1      " Enable the list of buffers
let g:airline#extensions#tabline#show_buffers = 1      " Show buffers
let g:airline#extensions#tabline#show_tabs    = 0      " Hide tabs, so it doesn't hide buffer names
let g:airline#extensions#tabline#fnamemod     = ':t'   " Show just the filename

""========|  Display  |==========================================================================//

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

""  http://vimdoc.sourceforge.net/htmldoc/syntax.html

""  Syntax highlighting
"highlight Normal      ctermfg=white       ctermbg=None
highlight Normal      ctermfg=7       ctermbg=None
highlight Comment     ctermfg=DarkYellow
"highlight Comment     ctermfg=58
"highlight Comment     ctermfg=52
"highlight Comment     ctermfg=21
"highlight Normal      ctermfg=15          ctermbg=None
"highlight Normal      ctermfg=white       ctermbg=None

""  --

"highlight Comment     ctermfg=16
"highlight Normal      ctermfg=64          ctermbg=None
"highlight Comment     ctermfg=52
"highlight Type        ctermfg=64
"highlight Statement   ctermfg=64
"highlight Special     ctermfg=64
"highlight Identifier  ctermfg=64
"highlight PreProc     ctermfg=64
"highlight Constant    ctermfg=64

""  --

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
"highlight CursorLine                      ctermbg=16        cterm=bold
"highlight CursorLine                      ctermbg=16
highlight IncSearch   ctermfg=black       ctermbg=yellow    cterm=bold
highlight Search      ctermfg=white       ctermbg=darkblue
highlight ColorColumn                     ctermbg=16
"highlight OverLength                      ctermbg=16
highlight LineNr      ctermfg=8           ctermbg=None
"highlight LineNr      ctermfg=58           ctermbg=0
"highlight LineNr      ctermfg=58           ctermbg=None
"highlight LineNr      ctermfg=DarkYellow           ctermbg=None
"set numberwidth=10
"set relativenumber       " Display lines numbers relative to the cursor

""========|  Other assorted settings  |==========================================================//

""  Tabs & spaces
""  -------------
set expandtab         " Use spaces instead of tabs
set tabstop     =8    " # of visual spaces/tab
set softtabstop =0    " # of spaces/tab when editing
set shiftwidth  =2    " # of columns to indent text
set smarttab          " Tabs are only used for indentation

""  UI
""  --
"set cursorline       " Highlight current line
set showcmd           " Show command in bottom bar
set wildmenu          " Visual autocomplete
set showmatch         " Highlight matching [{()}]
"match OverLength /\%<81v.\%>80v/
:call EnableBling()

""  Search
""  ------
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

"""====================================[[  ! END .vimrc !  ]]====================================""
