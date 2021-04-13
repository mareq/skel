" SYNTASTIC (#2736; https://github.com/vim-syntastic/syntastic.git)
" TODO: Enable & Customize

" Automatic checking behaviour
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
" Run all checkers and aggregate reported problem
let g:syntastic_aggregate_errors = 1
" Display information about the checker that reported the problem
let g:syntastic_id_checkers = 1
" Customize vertical bar error markers
let g:syntastic_error_symbol = "!"
let g:syntastic_warning_symbol = "w"
let g:syntastic_style_error_symbol = "!"
let g:syntastic_style_warning_symbol = "w"
" Populate location list with reported problems
let g:syntastic_always_populate_loc_list = 1
" Do not open/close location list automatically
let g:syntastic_auto_loc_list = 0


" vim: ts=2 sw=2 et


