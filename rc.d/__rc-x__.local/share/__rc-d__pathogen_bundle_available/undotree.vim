" UNDOTREE (#4177; https://github.com/mbbill/undotree)

" Toggle Undotree window
nnoremap <silent> ,8 :UndotreeToggle<CR>
" Set window layout
let g:undotree_WindowLayout = 4
" Use short time indicators ('d' instead of 'days')
let g:undotree_ShortIndicators = 1
" Undotree window width
let g:undotree_SplitWidth = 24
" Diff window height
let g:undotree_DiffpanelHeight = 10
" Set focus to Undotree window on opening it
let g:undotree_SetFocusWhenToggle = 1
" Tree node shape
let g:undotree_TreeNodeShape = "*"
" Diff command
let g:undotree_DiffCommand = "diff"
" Highlight changed texgt
let g:undotree_HighlightChangedText = 1
" Show help line
let g:undotree_HelpLine = 1
" Persist undo history
if has("persistent_undo")
  if has("nvim")
    set undodir=$HOME/.local/share/undotree/nvim/
  else
    set undodir=$HOME/.local/share/undotree/vim/
  endif
  set undofile
endif


" vim: ts=2 sw=2 et


