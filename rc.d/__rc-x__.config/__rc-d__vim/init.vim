" Customized vimrc file.
"
" Maintainer:  Marek Balint <mareq@balint.eu>
" Last change: 2018 Nov 01


" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup  " do not keep a backup file, use versions instead
else
  set backup    " keep a backup file
endif
set history=4096  " keep 4096 lines of command line history
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set ignorecase    " do case-insensitive searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  "filetype plugin indent on

  " CUSTOM SETTINGS:
  " Disable sourcing of indentation script for specific filetype (the same
  " line above has been commented out and repeated here without "indent").
  filetype plugin on
  " Display quickfix window always at the bottom
  autocmd FileTYpe qf wincmd J

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

"else
"
"  set autoindent " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              CUSTOM SETTINGS                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" INDENTATION
" Allow positioning cursor where no actual character resides
set virtualedit=all
" Indentation
set autoindent
"set smartindent
set cindent
set cinkeys-=0#
set indentkeys-=0#
" Toggle indentation options on/off
"nnoremap <silent> ,i :set autoindent!<CR>:set invsmartindent smartindent?<CR>
nnoremap <silent> ,i :set autoindent!<CR>:set cindent!<CR>
" Automatic formatting
filetype plugin on
autocmd FileType * setlocal formatoptions-=t formatoptions-=c formatoptions-=r formatoptions-=o formatoptions-=l formatoptions+=n formatoptions+=1
" Tabs and spaces
set shiftwidth=2
set tabstop=2
set expandtab
" Toggle expandtabs option on/off
nnoremap <silent> ,t :set invexpandtab expandtab?<CR>


" AUTOCOMPLETION
" Insert mode completion settings
set completeopt=menuone,preview,noselect
" Limit popup menu height
set pumheight=16


" SEARCH
" Word characters
set iskeyword+=-
" Do incremental searching
set incsearch
" Display incomplete commands
set ignorecase
" Toggle highlighting the last used search pattern on/off
nnoremap <silent> ,/ :nohlsearch<CR>
" Do not move when searching using * and #
nnoremap <silent> * *N
nnoremap <silent> # #N
" Remap * key (in visual mode) to search for selected text (forward)
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
  \N
" Remap # key (in visual mode) to search for selected text (backward)
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
  \N
" Move to the opening/closing bracket of the current block
nnoremap <silent> ,,( va)%<ESC>
nnoremap <silent> ,,) va)<ESC>
nnoremap <silent> ,,[ va]%<ESC>
nnoremap <silent> ,,] va]<ESC>
nnoremap <silent> ,,{ va}%<ESC>
nnoremap <silent> ,,} va}<ESC>


" YANK & PASTE
" Map ,,p and ,,P keys to paste "0 register (most recent yank)
noremap <silent> ,p "0p
noremap <silent> ,P "0P
" Yank & paste "+ and "* registers (X11: CLIPBOARD and PRIMARY)
noremap <silent> ,,y "+y"*y
noremap <silent> ,,Y "+Y"*Y
noremap <silent> ,,yy "+Y"*yy
noremap <silent> ,,p "+p
noremap <silent> ,,P "+P
" Map right and middle mouse buttons to yank into "+  and "* registers (X11: CLIPBOARD and PRIMARY)
noremap <RightMouse> "+y"*y
noremap <MiddleMouse> "+y"*Y


" APPEARANCE
" Set color scheme
colorscheme neon
" Show DefaultColor
nnoremap <silent> ,! :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" Show line numbers
set number
" Toggle line numbering on/off
nnoremap <silent> ,n :set invnumber number?<CR>
" Show special characters
set list
set listchars=eol:$,tab:»-,trail:•,extends:»,precedes:«,nbsp:•
" Toggle showing special characters on/off
nnoremap <silent> ,; :set invlist list?<CR>
" Do not change cursor shape for different modes
set guicursor=
" Highlight cursor line
set cursorline
" Do not highlight cursor column
set nocursorcolumn
" Maximum line length
set colorcolumn=80
set textwidth=120
" Turn off text wrapping
set nowrap
" Toggle text wrapping on/off
nnoremap <silent> ,w :set invwrap wrap?<CR>
" Status line
set statusline=%<%F\ %y\ %m%r%=\[%03b]\[0x%02B]\ %14.(\[%l/%L,%v]%)\ \[%P]
" Always display status line
set laststatus=2
" Display cursor position in the lower right corner
set ruler
" Do not display mode (insert, replace, visual)
set noshowmode
" Display incomplete commands
set showcmd


" CONCEAL
" Set modes that enable concealement of cursorline
set concealcursor=
" Set the concealment method
set conceallevel=2


" WINDOWS & TABS
" Maximize current window
nnoremap <silent> <C-w><C-_> :resize<CR>:vertical resize<CR>
" Display tab pages line only when there is more than one tab page
set showtabline=1
" Walk through tabs
nnoremap <silent> ,h :tabprev<CR>
nnoremap <silent> ,l :tabnext<CR>
" Move current tab one position left/right
nnoremap <silent> ,H :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> ,L :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
" Map ,,k to open new tab
nnoremap <silent> ,,k :tabnew<CR>
" Map ,,j to close active tab
nnoremap <silent> ,,j :tabclose<CR>


" FOLDING
function! g:FoldColumnIncrease()
  let cmd = "set foldcolumn=" . (&foldcolumn + 1)
  execute cmd
endfunction
function! g:FoldColumnDecrease()
  if &foldcolumn > 0
    let cmd = "set foldcolumn=" . (&foldcolumn - 1)
    execute cmd
  endif
endfunction
" Turn on foldcolumn (with width 2)
set foldcolumn=2
" Turn on/reset foldcolumn (with width 2 or 8)
nnoremap <silent>,,fk :set foldcolumn=2<CR>
nnoremap <silent>,,fK :set foldcolumn=8<CR>
" Turn off foldcolumn
nnoremap <silent>,,fj :set foldcolumn=0<CR>
" Increase width of the foldcolumn
nnoremap <silent>,,fl :exec g:FoldColumnIncrease()<CR>
" Decrease width of the foldcolumn
nnoremap <silent>,,fh :exec g:FoldColumnDecrease()<CR>
" Set foldmethod: syntax
nnoremap <silent>,,fs :setlocal foldmethod=syntax<CR>
" Set foldmethod: marker
nnoremap <silent>,,fa :setlocal foldmethod=marker<CR>
" Set foldmethod: diff
nnoremap <silent>,,fd :setlocal foldmethod=diff<CR>
" Set foldmethod: manual
nnoremap <silent>,,fm :setlocal foldmethod=manual<CR>
" Set foldmethod: indent
nnoremap <silent>,,fi :setlocal foldmethod=indent<CR>
" Jump to the next closed fold (source: https://stackoverflow.com/a/9407015)
function! NextClosedFold(dir)
    let cmd = "norm!z" . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction
nnoremap <silent> zJ :call NextClosedFold('j')<cr>
nnoremap <silent> zK :call NextClosedFold('k')<cr>


" HISTORY, SWAP, BACKUP
" Keep 1024 lines of command line history
set history=4096
" Write swap files to specific directory
set directory=~/.local/share/vim/swap/
" Toggle swap files
nnoremap <silent> ,s :set invswapfile swapfile?<CR>
" Write backup file, then write changes and remove backup file
set nobackup
set writebackup


" UPDATE TIME
" Update time in ms
set updatetime=256


" MOUSE
" Enable mouse by default where possible
if has("mouse")
  set mouse=a
endif
" Toggle mouse on/off
nnoremap ,m :set mouse=a<CR>
nnoremap ,M :set mouse=<CR>


" LOCATION LIST
" Open location list
nnoremap <silent> ,.k :lopen<CR>
" Close location list
nnoremap <silent> ,.j :lclose<CR>


" QUICKFIX
" Open quickfix
nnoremap <silent> ,.K :copen<CR>
" Close quickfix
nnoremap <silent> ,.J :cclose<CR>


" MISC KEYBINDINGS
" Map § key to ` (useful for weird keyboard mappings)
nmap § `
nmap ± ~
" Map ,,, to work as hijacked , key
nnoremap <silent> ,,, ,
" Close all buffers
nnoremap <silent> ,,q :qall<CR>
" Close all buffers, no questions asked
nnoremap <silent> ,,QQ :qall!<CR>
" Refresh current buffer
nnoremap <silent> ,r :edit<CR>
" Refresh all buffers on all tabsd
nnoremap <silent> ,R :tabdo exec "windo edit!"<CR>
" Re-read configuration files
nnoremap ,,hup :source $MYVIMRC<CR>:runtime! plugin/**/*.vim<CR>:AirlineRefresh<CR>:echo "Configuration reloaded: ".$MYVIMRC<CR>
nnoremap <silent>,,HUP :source $MYVIMRC<CR>:runtime! plugin/**/*.vim<CR>:echo "CONFIGURATION RELOADED: ".$MYVIMRC<CR>
" Map ,! key to show highlight group of object under cursor
nnoremap <silent> ,! :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


" PROVIDERS
" check providers: `:checkhealth`
" Python2 provider (uncomment the `loaded_...` line to disable the provider)
"let g:python_host_prog = "/usr/bin/python"
"let g:python_host_prog = "~/.conda/envs/nvim2/bin/python"
"let g:loaded_python_provider = 1
" Python3 provider (uncomment the `loaded_...` line to disable the provider)
let g:python3_host_prog = "/usr/bin/python3"
"let g:python3_host_prog = "~/.conda/envs/nvim3/bin/python3"
"let g:loaded_python3_provider = 1


" FTPLUGIN
" TODO: First make formatting footers work (Why are they ignored?).
" Python settings
" Do not override user settings
let g:python_recommended_style = 0
" Set custom file extensions
autocmd BufEnter,BufNew *.cwl :set filetype=yaml
" Set custom settings for tabs and spaces
autocmd Filetype python setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab


" vim: ts=2 sw=2 et


