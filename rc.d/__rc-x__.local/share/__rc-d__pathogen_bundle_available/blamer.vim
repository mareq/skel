" Blamer (#NA; https://github.com/APZelos/blamer.nvim)

" Enable plugin
let g:blamer_enabled = 1
" Delay until the blame is displayed
let g:blamer_delay = 0
" Show blamer in visual mode
let g:blamer_show_in_visual_modes = 1
" Show blamer in insert mode
let g:blamer_show_in_insert_modes = 1
" The prefix that will be added to the template.
let g:blamer_prefix = ""
"let g:blamer_prefix = "   "
"let g:blamer_prefix = "   "
"let g:blamer_prefix = "   "
" The template for the blame message that will be shown.
let g:blamer_template = "     <commit-short> - <summary> [<author-time>] <author-mail> [<committer-time>] <committer-mail>"
" The format of the date fields
let g:blamer_date_format = '%Y-%m-%d %H:%M:%S'
" Shows commit date in relative format
let g:blamer_relative_time = 0


" vim: ts=2 sw=2 et


