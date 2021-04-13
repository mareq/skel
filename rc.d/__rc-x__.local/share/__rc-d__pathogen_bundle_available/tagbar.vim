" TAGBAR (#3465; https://github.com/majutsushi/tagbar)

" Set position of the Tagbar window
let g:tagbar_left = 0
let g:tagbar_vertical = 0
" Set width of the tagbar window (default is 40)
let g:tagbar_width = 31
" Make the display more compact (omit help, blank lines, do not show line numbers, ...)
let g:tagbar_compact = 1
let g:tagbar_show_linenumbers = 0
" Automatically move the cursor into the Tagbar window when it is opened
let g:tagbar_autofocus = 1
" Automatically close Tagbar window upon selection of the tag
let g:tagbar_autoclose = 1
" Initial fold level (higher than this will be closed)
let g:tagbar_foldlevel = 1
" Automatically open folds to show the tag
let g:tagbar_autoshowtag = 1
" Set sort order
let g:tagbar_sort = 1
let g:tagbar_case_insensitive = 1
" Show visibility of symbols (public/private)
let g:tagbar_show_visibility = 1
" Show Tagbar
nnoremap <silent> ,2 :TagbarToggle<CR>


" vim: ts=2 sw=2 et


