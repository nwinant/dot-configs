syntax on


""" See: https://github.com/tpope/vim-sensible
"""      https://dougblack.io/words/a-good-vimrc.html


""" =======  Plugins  =========================================================

" Activate Pathogen plugin manager
" See https://github.com/tpope/vim-pathogen
"     https://gist.github.com/romainl/9970697 (vim plugin directory layout)
"call pathogen#infect()
execute pathogen#infect()

filetype plugin indent on


""" =======  Key bindings  ====================================================

""" Tabs & spaces
"set smarttab      " tabs are only used for indentation
set expandtab     " use spaces instead of tabs
set tabstop=8     " # of visual spaces/tab
set softtabstop=0 " # of spaces/tab when editing
set shiftwidth=2  " # of columns to indent text

""" UI
"set number     " show lines numbers
"set cursorline " highlight current line
set showcmd    " show command in bottom bar
set wildmenu   " visual autocomplete
set showmatch  " highlight matching [{()}]

""" Search
set incsearch " search as characters are entered
set hlsearch  " highlight searches


""" =======  Key bindings  ====================================================
"
" NOTE: One of the strengths of vim is its ubiquity. We don't want to diverge
"       much from standard keybindings (lest it screw up our muscle memory on
"       foreign machines) so any changed bindings should be unlikely to cause
"       significant issues when not present.

""" Module: wrapped-line-movement:
""" 
""" Press \w to toggle wrapping on or off. When wrap is on, the cursor movement keys are mapped to
""" move by display lines.


" turn off search highlighting w/ \<space>
nnoremap <leader><space> :nohlsearch<CR>





