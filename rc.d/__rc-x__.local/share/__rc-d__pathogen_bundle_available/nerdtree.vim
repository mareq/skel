" NERDTREE (#1658; https://github.com/scrooloose/nerdtree.git)

" Window position
let g:NERDTreeWinPos = "left"
" Close NerdTree window upon opening file
let g:NERDTreeQuitOnOpen = 1
" Hijack NetRW
let g:NERDTreeHijackNetrw = 1
" Show bookmarks
let g:NERDTreeShowBookmarks = 1
" Window size (default is 31)
let g:NERDTreeWinSize = 64
" Use natural sort order
let g:NERDTreeNaturalSort = 1
" Use tree root of given tab as working directory for VIM
let g:NERDTreeChDirMode = 2
" Do not ignore any files
let g:NERDTreeIgnore = []
" Highlight the cursor line
let NERDTreeHighlightCursorline = 1
" Do not collapse single-child directories to the single line
let NERDTreeCascadeSingleChildDir = 0
" Customize file opening method
let NERDTreeCustomOpenArgs = {"file": {"reuse": "", "where": "p"}, "dir": {}}
let NERDTreeMapCustomOpen = "o"
" Show NerdTree
nnoremap <silent> ,1 :NERDTreeToggle<CR>
" Find current file in NerdTree (TODO: This will now produce error if there is no file opened)
nnoremap <silent> ,` :NERDTreeFind<CR>
nnoremap <silent> ,§ :NERDTreeFind<CR>


" vim: ts=2 sw=2 et


