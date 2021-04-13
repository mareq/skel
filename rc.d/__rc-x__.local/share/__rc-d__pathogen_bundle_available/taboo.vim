" TABOO (#4237; https://github.com/gcmt/taboo.vim)

" remember tabnames when saving session
set sessionoptions+=tabpages,globals
" Map ,,K to open new tab
nnoremap ,,K :TabooOpen<SPACE>
" Map ,,l to rename active tab
nnoremap ,,l :TabooRename<SPACE>
" Map ,,L to reset custom label for active tab
nnoremap <silent> ,,L :TabooReset<CR>


" vim: ts=2 sw=2 et


