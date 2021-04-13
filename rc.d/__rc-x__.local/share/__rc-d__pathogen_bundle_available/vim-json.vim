" VIM-JSON (#1945, https://github.com/elzr/vim-json)
" TODO: Need JSON formatting

"" Original vimrc formatting
" Map ,,js to format the JSON file
com! FormatJson %!python -m json.tool
nnoremap <silent> ,,js :FormatJson<CR>:%s/    /  /g<CR>:nohlsearch<CR>:set filetype=json<CR>
"" Stuff from Istar
"com! -range=% JSONBeautify <line1>,<line2>!jq '.'
"com! -range=% JSONUglify <line1>,<line2>!jq -c '.'
" Turn off conceal feature
let g:vim_json_syntax_conceal = 0


" vim: ts=2 sw=2 et


