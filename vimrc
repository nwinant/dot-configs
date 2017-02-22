""" See: http://vimdoc.sourceforge.net/htmldoc/syntax.html
"""      https://dougblack.io/words/a-good-vimrc.html
"""      https://github.com/tpope/vim-sensible


""" =======  Plugins  =========================================================

" Activate Pathogen plugin manager
" See https://github.com/tpope/vim-pathogen
"     https://gist.github.com/romainl/9970697 (vim plugin directory layout)
"call pathogen#infect()
execute pathogen#infect()

filetype plugin indent on


""" =======  Colors  =========================================================

" View all installed colorschemes:
" :colo [space] [ctl-d]
" :he cterm-colors
" :he highlight-groups
" :he group-name
" :he cterm-colors

"set t_Co=256

syntax on
"colorscheme blue
"colorscheme darkblue
"colorscheme default
"colorscheme delek
"colorscheme desert
"colorscheme elflord
"colorscheme evening
"colorscheme industry
"colorscheme koehler
"colorscheme morning
"colorscheme murphy
"colorscheme pablo
"colorscheme peachpuff
"colorscheme ron
"colorscheme shine
"colorscheme slate
"colorscheme torte
"colorscheme zellner

"set background=dark
"set background=light
"highlight Normal ctermbg=None ctermfg=white
highlight LineNr ctermbg=none ctermfg=black
highlight Search cterm=underline gui=underline ctermbg=darkblue ctermfg=white
highlight CursorLine term=bold cterm=bold
"highlight CursorColumn term=bold cterm=bold ctermbg=none


""" =======  Key bindings  ====================================================

""" Tabs & spaces
"set smarttab      " tabs are only used for indentation
set expandtab     " use spaces instead of tabs
set tabstop=8     " # of visual spaces/tab
set softtabstop=0 " # of spaces/tab when editing
set shiftwidth=2  " # of columns to indent text

""" UI
set number       " show lines numbers
set cursorline   " highlight current line
"set cursorcolumn " highlight current col
set showcmd      " show command in bottom bar
set wildmenu     " visual autocomplete
set showmatch    " highlight matching [{()}]

""" Search
set incsearch  " search as characters are entered
set hlsearch   " highlight searches
set ignorecase " like, y'know... ignore case
"set noignorecase  " searches are case-sensitive

""" Smartcase: Case-insensitive when search string has only lowercase letters.
"""            Can be overridden with \c or \C at end of search string:
"""              /string     case-insensitive
"""              /STring     case-sensitive
"""              /string\c   case-insensitive
"""              /string\C   case-sensitive
"""            NOTE: this also applies to SUBSTITUTIONS.
set smartcase


""" =======  Key bindings  ====================================================
"""
""" NOTE: One of the strengths of vim is its ubiquity. We don't want to diverge
"""       much from standard keybindings (lest it screw up our muscle memory on
"""       foreign machines) so any changed bindings should be unlikely to cause
"""       significant issues when not present.

""" Module: wrapped-line-movement:
""" 
""" Press \w to toggle wrapping on or off. When wrap is on, the cursor movement keys are mapped to
""" move by display lines.


" turn off search highlighting w/ \<space>
nnoremap <leader><space> :nohlsearch<CR>





