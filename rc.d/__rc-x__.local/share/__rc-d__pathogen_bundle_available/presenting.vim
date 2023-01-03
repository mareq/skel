" PRESENTING (#4653; https://github.com/sotte/presenting.vim.git)

" Start presentation
nnoremap <silent> ,,sp :PresentingStart<CR>
" In-presentation commands:
" - next slide: n
" - previous slide: p
" - stop presenting: q

" Integrate with VimWiki: use horizontal line as slide separator
"au FileType vimwiki let b:presenting_slide_separator = '----'
" Integrate with VimWiki: use headings as slide separator
"au FileType vimwiki let b:presenting_slide_separator = '\v(^|\n)\ze\=+'
au FileType vimwiki let b:presenting_slide_separator = '\v(^|\n)\ze\=\=*.*'
" Number of blank lines inserted at the top
let g:presenting_top_margin = 2


" vim: ts=2 sw=2 et


