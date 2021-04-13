" RAINBOW PARENTHESIS (#4176; https://github.com/luochen1990/rainbow)

" Globally enable the plugin (need to turn off for some filetypes; see `g:rainbow_conf`)
let g:rainbow_active = 1
" Detailed configuration
let g:rainbow_conf =
  \{
    \ "separately": {
      \ "nerdtree": 0,
      \ "vimwiki": 0,
    \},
    \ "ctermfgs": ["yellow", "green", "cyan", "blue", "magenta", "red"],
    \ "guifgs": ["yellow", "green", "cyan", "blue", "magenta", "red"],
  \}


" vim: ts=2 sw=2 et


