" STARTIFY (#4544; https://github.com/mhinz/vim-startify)

" Set the directory to be used for storing startify sessions
let g:startify_session_dir = $HOME.'/.local/share/startify/'
" Do not show Startify screen automatically at startup
let g:startify_disable_at_vimenter = 1
" Automatically load the session in the current directory
let g:startify_session_autoload = 0
" Automatically save current session before closing
let g:startify_session_persistence = 0
" Delete open buffers before loading a new session
let g:startify_session_delete_buffers = 1
" When opening a file or bookmark, change to its directory
let g:startify_change_to_dir = 1
" Specify numer of files to list
let g:startify_files_number = 10
" Show relative filenames
let g:startify_relative_path = 0
" Filters for excluded recent files
let g:startify_skiplist = [
  \ "COMMIT_EDITMSG",
  \ ]
" Show <empty buffer> and <quit> on Startify screen
let g:startify_enable_special = 1
" Customize lists shown on Startify screen (files, dir, bookmarks, sessions)
let g:startify_lists = [
  \ { "type": "sessions", "header": ["   sessions"] },
  \ { "type": "bookmarks", "header": ["   bookmarks"] },
  \ { "type": "dir", "header": ["   recent files (current directory)"] },
  \ { "type": "files", "header": ["   recent files (global)"] },
\ ]
" Display custom header on Startify screen
"let g:startify_custom_header = map(split(system("tips | cowsay -f apt"), "\n"), ""   ". v:val") + [""]
let g:startify_custom_header = ""
" Display custom footer on Startify screen
let g:startify_custom_footer = ""
" Display custom status line when opening Startify screen
autocmd User Startified let &l:stl = "Startify [b:same window] [s:split window] [v:vertical split window] [t:new tab]"
" Prevent NERDTree to open a buffer in Startify window
"autocmd User Startified setlocal buftype=
" Specify bookmarks
let g:startify_bookmarks = []
" Show Startify screen
nnoremap <silent> ,0 :Startify<CR>
" Save the session
nnoremap <silent> ,,ss :SSave<CR>
" Load the session
nnoremap <silent> ,,sl :SLoad<CR>
" Close the session
nnoremap <silent> ,,sc :SClose<CR>
" Delete the session
nnoremap <silent> ,,sd :SDelete<CR>


" vim: ts=2 sw=2 et


