" BUFEXPLORER (#42/#159; https://github.com/jlanzarotta/bufexplorer)

" Bring up the selected buffer in the window specified
"let g:bufExplorerChgWin = ""
" Maximum height of BufExplorer window
let g:bufExplorerMaxHeight = 1024
" Default key mappings
let g:bufExplorerDisableDefaultKeyMapping=0
" Show default help
let g:bufExplorerDefaultHelp = 0
" Show detailed help
let g:bufExplorerDetailedHelp = 0
" Go to active window when selecting buffer
let g:bufExplorerFindActive = 1
" Sort in reverse order
let g:bufExplorerReverseSort = 0
" Show directories
let g:bufExplorerShowDirectories = 1
" Show absolute/relative paths
let g:bufExplorerShowRelativePath = 1
" Show buffers for the specific tab
let g:bufExplorerShowTabBuffer = 0
" Show NoName buffers
let g:bufExplorerShowNoName = 0
" Show unlisted buffers
let g:bufExplorerShowUnlisted = 0
" Buffers sort order [extension,fullpath,mru,name,number]
let g:bufExplorerSortBy = "mru"
" Split path and file name
let g:bufExplorerSplitOutPathName = 1
" Position and size of the BufExplorer window
let g:bufExplorerSplitBelow = 0
let g:bufExplorerSplitRight = 1
let g:bufExplorerSplitHorzSize = 8
let g:bufExplorerSplitVertSize = 32
" Show BufExplorer
nnoremap <silent> ,9 :BufExplorer<CR>
nnoremap <silent> ,,99 :BufExplorerVerticalSplit<CR>
nnoremap <silent> ,,9h :BufExplorerHorizontalSplit<CR>
nnoremap <silent> ,,9v :BufExplorerVerticalSplit<CR>


" vim: ts=2 sw=2 et


