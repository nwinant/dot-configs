" From http://vim.wikia.com/wiki/Move_cursor_by_display_lines_when_wrapping
" 
" The command :set wrap lbr will wrap long lines between words.
"
" However, when you move the cursor down (or up), the cursor will jump from one physical line to 
" the next. You can press j to move down one physical line, or gj to move down one displayed line.
"
" To make it easy, you could put the following in your vimrc file. Then press \w to toggle wrapping
" on or off (that's a backslash then w, assuming the default Leader key). When wrap is on, the 
" cursor movement keys are mapped to move by display lines.

noremap <silent> <Leader>w :call ToggleWrap()<CR>
function ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    setlocal nowrap
    set virtualedit=all
    silent! nunmap <buffer> <Up>
    silent! nunmap <buffer> <Down>
    silent! nunmap <buffer> <Home>
    silent! nunmap <buffer> <End>
    silent! iunmap <buffer> <Up>
    silent! iunmap <buffer> <Down>
    silent! iunmap <buffer> <Home>
    silent! iunmap <buffer> <End>
  else
    echo "Wrap ON"
    setlocal wrap linebreak nolist
    set virtualedit=
    setlocal display+=lastline
    noremap  <buffer> <silent> <Up>   gk
    noremap  <buffer> <silent> <Down> gj
    noremap  <buffer> <silent> <Home> g<Home>
    noremap  <buffer> <silent> <End>  g<End>
    inoremap <buffer> <silent> <Up>   <C-o>gk
    inoremap <buffer> <silent> <Down> <C-o>gj
    inoremap <buffer> <silent> <Home> <C-o>g<Home>
    inoremap <buffer> <silent> <End>  <C-o>g<End>
  endif
endfunction

"noremap  <buffer> <silent> k gk
"noremap  <buffer> <silent> j gj
"noremap  <buffer> <silent> 0 g0
"noremap  <buffer> <silent> $ g$

