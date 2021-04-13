" AIRLINE (#NA; https://github.com/vim-airline/vim-airline, https://github.com/vim-airline/vim-airline-themes)

" Set theme
let g:airline_theme="neon"
" Turn on powerline symbols
let g:airline_powerline_fonts = 1
" Use plain ascii symbols, set this variable
let g:airline_symbols_ascii = 1
" Do not collapse the left section for inactive windows
let g:airline_inactive_collapse = 0
" Do not draw separators for empty sections (only for the active window)
"let g:airline_skip_empty_sections = 1
let g:airline_skip_empty_sections = 0
" Single-letter vi-mode names
let g:airline_mode_map = {
    \ "__"     : "-",
    \ "c"      : "C",
    \ "i"      : "I",
    \ "ic"     : "I",
    \ "ix"     : "I",
    \ "n"      : "N",
    \ "multi"  : "M",
    \ "ni"     : "N",
    \ "no"     : "N",
    \ "R"      : "R",
    \ "Rv"     : "R",
    \ "s"      : "S",
    \ "S"      : "S",
    \ ""     : "S",
    \ "t"      : "T",
    \ "v"      : "V",
    \ "V"      : "V",
    \ ""     : "V",
    \ }
" Enable tabline
let g:airline#extensions#tabline#enabled = 1
" Enable/disable displaying tab type (e.g. [buffers]/[tabs]) >
let g:airline#extensions#tabline#show_tab_type = 0
" Enable/disable displaying open splits per tab (only when tabs are opened)
let g:airline#extensions#tabline#show_splits = 0
" Enable/disable displaying buffers with a single tab.
let g:airline#extensions#tabline#show_buffers = 0
" Configure the minimum number of tabs needed to show the tabline. >
let g:airline#extensions#tabline#tab_min_count = 2
" Configure which tabline formatter should be used
let g:airline#extensions#tabline#formatter = "default"
"let g:airline#extensions#tabline#formatter = "airline#extensions#tabline#formatters#unique_tail_improved#format"  " TODO
" Configure whether close button should be shown
let g:airline#extensions#tabline#show_close_button = 0
" Show both tab number and number of splits for each tab
let g:airline#extensions#tabline#tab_nr_type = 2
" Enable/disable tabws integration
let g:airline#extensions#tabws#enabled = 0
" Truncate sha1 commits at this number of characters.
let g:airline#extensions#branch#sha1_len = 7
" Enable/disable coc integration
let g:airline#extensions#coc#enabled = 1
" Override default status line contents
let g:airline#extensions#default#layout = [
    \ [ 'a', 'b', 'c' ],
    \ [ 'm', 'x', 'y', 'z', 'error', 'warning' ]
    \ ]
function! g:AirLineStatusLineOverride()
  let spc = g:airline_symbols.space
  " based on copy-paste from: vim-airline/autoload/airline/init.vim
  " list of current powerline symbols: https://github.com/ryanoasis/nerd-fonts/issues/144
  " rasep: '', symbol_chr: '', linenr:''
  if get(g:, "airline_powerline_fonts", 0)
    let rasep = " \ue0b3 "
    let symbol_chr = "\uf031"
    let linenr = "\uf0c9"
  elseif &encoding==?"utf-8" && !get(g:, "airline_symbols_ascii", 0)
    let rasep = " < "
    let symbol_chr = "A"
    let linenr = "\uf0c9",
  else
    let rasep = " < "
    let symbol_chr = "A"
    let linenr = "ln"
  endif
  let g:airline_section_a = airline#section#create_left(["mode", "crypt", "paste", "keymap", "spell", "capslock", "xkblayout", "iminsert"])
  let g:airline_section_b = airline#section#create(["hunks", "branch"])
  if exists("+autochdir") && &autochdir == 1
    let g:airline_section_c = airline#section#create(["%<", "path", spc, "readonly"])
  else
    let g:airline_section_c = airline#section#create(["%<", "file", spc, "readonly"])
  endif
  let g:airline_section_gutter = airline#section#create(["%="])
  let g:airline_section_m = airline#section#create_right([rasep, "coc_status"])
  let g:airline_section_x = airline#section#create_right(["bookmark", "tagbar", "vista", "gutentags", "grepper", "filetype"])
  let g:airline_section_y = airline#section#create_right(["ffenc"])
  let g:airline_section_z = airline#section#create(["windowswap", "obsession", "0x%02B:%03b ".symbol_chr, rasep, "%l/%L,%v ".linenr, rasep, "%P"])
  let g:airline_section_error = airline#section#create(["ycm_error_count", "syntastic-err", "eclim", "neomake_error_count", "ale_error_count", "languageclient_error_count", "coc_error_count"])
  let g:airline_section_warning = airline#section#create(["ycm_warning_count",  "syntastic-warn", "neomake_warning_count", "ale_warning_count", "languageclient_warning_count", "whitespace", "coc_warning_count"])
endfunction
let g:airline_section_override_func = "g:AirLineStatusLineOverride"
" Enable/disable tagbar integration
let g:airline#extensions#tagbar#enabled = 1


" vim: ts=2 sw=2 et


