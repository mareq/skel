" Customized vimrc file.
"
" Maintainer:  Marek Balint <mareq@balint.eu>
" Last change: 2016 Nov 09


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
set history=50  " keep 50 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch   " do incremental searching
set ignorecase  " do case-insensitive searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
  " Map ,m and ,M keys to enable/disable mouse
  nnoremap ,m :set mouse=a<CR>
  nnoremap ,M :set mouse=<CR>
endif

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
  " Disable auto-comment for all file types
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  " Use syntaxcomplete
  "autocmd Filetype *
  "  \ if (&omnifunc == "") |
  "  \   setlocal omnifunc=syntaxcomplete#Complete |
  "  \ endif
  " Display quickfix window always at the bottom
  autocmd FileTYpe qf wincmd J

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  "autocmd FileType text setlocal textwidth=78

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

" APPEARANCE
" Set color scheme
colorscheme neon
" Turn on line numbering
set number
" Map both ,n and ,N keys to toggle line numbering
nnoremap <silent> ,n :set invnumber number?<CR>
nnoremap <silent> ,N :set invnumber number?<CR>
" Highlight cursor line
set nocursorline
" Show special characters
set list
set listchars=eol:$,tab:»-,trail:•,extends:»,precedes:«,nbsp:•
"set listchars=eol:$,tab:»-,extends:»,precedes:«,nbsp:.
" Map ,; key to toggle showing list characters
nnoremap <silent> ,; :set invlist list?<CR>
" Turn off text wrapping
set nowrap
" Map ,w key to toggle text wrapping
nnoremap <silent> ,w :set invwrap wrap?<CR>
" Status line configuration
"set statusline=%<%F\ %y\ %m%r%=%([%{Tlist_Get_Tag_Prototype_By_Line()}]%)\ \[%03b]\[0x%02B]\ %14.(\[%l/%L,%v]%)\ \[%P]
set statusline=%<%F\ %y\ %m%r%=\[%03b]\[0x%02B]\ %14.(\[%l/%L,%v]%)\ \[%P]
" Always display status line
set laststatus=2
" Display tab pages line only when there is more than one tab page
set showtabline=1
" Display cursor position in the lower right corner
set ruler
" Display mode (insert, replace, visual) in lower left corner
set showmode
" Display an incomplete command in the lower right corner
set showcmd
" Turn on Doxygen syntax highlighting
let g:load_doxygen_syntax=1
" Customize tabs appearance
if exists("+showtabline")
  function! MyTabLine()
    let s = ''
    let wn = ''
    let t = tabpagenr()
    let i = 1
    while i <= tabpagenr('$')
      let buflist = tabpagebuflist(i)
      let winnr = tabpagewinnr(i)
      let s .= '%' . i . 'T'
      let s .= (i == t ? '%1*' : '%2*')
      if i > 1
        let s .= '%#TabLine#|'
      endif
      let wn = tabpagewinnr(i,'$')
      let s .= (i == t ? '%#TabLineSel# ' : '%#TabLine# ')
      let s .= (i == t ? '%#TabNumSel#' : '%#TabNum#')
      let s .= i
      let s .= '%*'
      let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
      let bufnr = buflist[winnr - 1]
      let file = bufname(bufnr)
      let buftype = getbufvar(bufnr, 'buftype')
      if buftype == 'nofile'
          if file =~ '\/.'
              let file = substitute(file, '.*\/\ze.', '', '')
          endif
      else
          let file = fnamemodify(file, ':p:t')
      endif
      if file == ''
          let file = '[No Name]'
      endif
      let s .= ' '
      let s .= file
      let s .= ' '
      if tabpagewinnr(i,'$') > 1
        let s .= (i == t ? '%#TabWinNumSel#' : '%#TabWinNum#')
        if tabpagewinnr(i,'$') > 1
          let s .= '['.wn.']'
          let s .= (i == t ? '%#TabLineSel# ' : '%#TabLine# ')
        endif
      end
      let i = i + 1
    endwhile
    let s .= '%T%#TabLineFill#%='
    return s
  endfunction
  set tabline=%!MyTabLine()
endif

" EDITING
" Indentation (see also custom settings in has("autocmd") above)
set autoindent
set smartindent
set expandtab
set shiftwidth=2
set tabstop=2
" Map ,i key to toggle indentation options
nnoremap <silent> ,i :set autoindent!<CR>:set invsmartindent smartindent?<CR>
" Map ,t key to toggle expandtabs option
nnoremap <silent> ,t :set invexpandtab expandtab?<CR>
" Allow positioning cursor where no actual character resides
set virtualedit=all
" Use system tagfile for autocompletion
" # ctags -R -f ~/.vim/systags /usr/include /usr/local/include
set tags+=$HOME/.vim/tags/cpp
" Insert mode completion settings
set completeopt=menu,menuone,longest
" Limit popup menu height
set pumheight=15
" Map ,p and ,P keys to paste "+ register
nnoremap ,p "+p
nnoremap ,P "+P
" Map ,y and ,Y keys to yank into "+ register
map ,y "+y
map ,Y "+Y
" Map ,,p and ,,P keys to paste "0 register
nnoremap ,,p "0p
nnoremap ,,P "0P
" Map right and middle mouse buttons to yank into "* register
noremap <RightMouse> "+y
noremap <MiddleMouse> "+y
" Map ,h and ,l keys to walk through tabs
nnoremap <silent> ,h :tabprev<CR>
nnoremap <silent> ,l :tabnext<CR>
" Map ,H and ,L keys to move current tab one position left/right
nnoremap <silent> ,H :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> ,L :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
" Map ,,k to open new tab
nnoremap <silent> ,,k :tabnew<CR>
" Map ,,j to close active tab
nnoremap <silent> ,,j :tabclose<CR>
" Map <CTRL-\> key to work as hijacked , key
nnoremap <silent> <C-\> ,
" Map ,,ml to merge-in the local version
nnoremap <silent> ,,ml :diffget LOCAL<CR>
" Map ,,mb to merge-in the base version
nnoremap <silent> ,,mb :diffget BASE<CR>
" Map ,,mr to merge-in the remote version
nnoremap <silent> ,,mr :diffget REMOTE<CR>


" BEHAVIOR
" Write backup file, then write changes and remove backup file
set nobackup
set writebackup
" Turn off swap files
set directory^=$HOME/.vim/swp//
" Use *.ci extension for CPP files
au BufNewFile,BufRead *.ci setfiletype cpp
" Use *.msg and *.inc extensions for XML files
"au BufNewFile,BufRead *.msg setfiletype xml
"au BufNewFile,BufRead *.inc setfiletype xml
" Remap * key to *N
nnoremap <silent> * *N
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
" Map ,,q key to cloase all buffers
nnoremap <silent> ,,q :qall<CR>
" Map ,r key to refresh current buffer
nnoremap <silent> ,r :edit<CR>
" Map ,R key to refresh all buffers on all tabsd
nnoremap <silent> ,R :tabdo exec 'windo edit'<CR>
" Map ,s key to toggle swap files
nnoremap <silent> ,s :set invswapfile swapfile?<CR>
" Map ,/ key to switch off highlighting the last used search pattern
nnoremap ,/ :nohlsearch<CR>
" Map ,! key to show highlight group of object under cursor
nnoremap <silent> ,! :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" Map ,,cpp key to set file type to C++
nnoremap <silent> ,,cpp :set filetype=cpp<CR>
" Map ,,du key to update the diff
nnoremap <silent> ,,du :diffupdate<CR>
" Map ,,dk key to diff the current buffer
nnoremap <silent> ,,dk :diffthis<CR>
" Map ,,dj key to turn off diff for the current buffer
nnoremap <silent> ,,dj :diffoff<CR>
" Map ,,dw key to ignore whitespaces in diff
nnoremap <silent> ,,dw :set diffopt+=iwhite<CR>
" Map ,,dW key to not ignore whitespaces in diff
nnoremap <silent> ,,dW :set diffopt-=iwhite<CR>
" Map ,,hup key to source configuration file
nnoremap <silent> ,,hup :source ~/.vimrc<CR>
" Load filetype plugin for man pages (enable :Man and \K commands)
runtime! ftplugin/man.vim


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  PLUGINS                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BUFEXPLORER (#42/#159)
" Maximum height of BufExplorer window
let g:bufExplorerMaxHeight = 999
" Vertical size (DOES NOT WORK!!!)
let g:bufExplorerSplitVertSize = 32
let g:bufExplorerSplitHorzSize = 32
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
" Show unlisted buffers
let g:bufExplorerShowUnlisted = 0
" Buffers sort order [extension,fullpath,mru,name,number]
let g:bufExplorerSortBy = "mru"
" Split path and file name
let g:bufExplorerSplitOutPathName = 1
" Map key ,9 to show BufExplorer
nnoremap <silent> ,9 :BufExplorer<CR>

" TRINITY (#2347)
" Map key <CTRL-W>t to toggle all three plugins
"nnoremap <silent> <C-W>t :TrinityToggleAll<CR>

" NERDTREE (#1658)
" Window position
let g:NERDTreeWinPos = "left"
" Close NerdTree window upon opening file
let g:NERDTreeQuitOnOpen = 1
" Hijack NetRW
let g:NERDTreeHijackNetrw = 1
" Show bookmarks
let g:NERDTreeShowBookmarks = 1
" Window size (default is 31)
let g:NERDTreeWinSize = 50
" Map key ,1 to show NerdTree
nnoremap <silent> ,1 :NERDTreeToggle<CR>
"nnoremap <silent> ,1 :TrinityToggleNERDTree<CR>
" Map key ,` to find current file in NerdTree
nnoremap <silent> ,` :NERDTreeFind<CR>

" TAGLIST (#273)
" Automatically open TagList window on startup
let g:Tlist_Auto_Open = 0
" Exit Vim when TagList window is the only one
let g:Tlist_Exit_OnlyWindow = 1
" Display TagList on the right
let g:Tlist_Use_Right_Window = 1
" Set default widht of TagList window
let g:Tlist_WinWidth = 60
" Set focus to TagList window when opened
let g:Tlist_GainFocus_On_ToggleOpen = 1
" Close TagList window when a symbol is selected
let g:Tlist_Close_On_Select = 1
" Process opened files even when TagList window is closed
let g:Tlist_Process_File_Always = 1
" Enable automatic processing of new/modified files
let g:Tlist_Auto_Update = 1
" Show tags only for current active buffer
let g:Tlist_Show_One_File = 0
" Automacially highlight current tag
let g:Tlist_Auto_Highlight_Tag = 1
" Automatically highlight current tag when entering Vim buffer/window
let g:Tlist_Highlight_Tag_On_BufEnter = 1 
" Automatically close folds for inactive files/buffers
let g:Tlist_File_Fold_Auto_Close = 1
" Tags sorting order ("name" or "order")
let g:Tlist_Sort_Type = "order"
" Map key ,2 to toggle TagList window
nnoremap <silent> ,2 :TlistToggle<CR>
"nnoremap <silent> ,2 :TrinityToggleTagList<CR>
" Map key ,@ to force highlighting of current tag
"nnoremap <silent> ,@ :TlistHighlightTag<CR>
" Map key ,@ to show tag prototype
nnoremap <silent> ,@ :TlistShowPrototype<CR>
" Map key ,@ to show tag
"nnoremap <silent> ,@ :TlistShowTag<CR>

" SOURCE EXPLORER (#2179)
" Set the height of SourceExplorer window
let g:SrcExpl_winHeight = 8
" Set time (in milliseconds) for refreshing the SourceExplorer
let g:SrcExpl_refreshTime = 100
" Set "Enter" key to jump into the exact definition context
let g:SrcExpl_jumpKey = "<ENTER>"
" Set "Space" key for back from the definition context
let g:SrcExpl_gobackKey = "<SPACE>"
" In order to Avoid conflicts, the Source Explorer should know what plugins
" are using buffers. And you need add their bufname into the list below
" according to the command ":buffers!"
let g:SrcExpl_pluginList = [
  \ "__Tag_List__",
  \ "_NERD_tree_",
  \ "Source_Explorer"
  \ ]
" Enable/Disable the local definition searching, and note that this is not
" guaranteed to work, the Source Explorer doesn't check the syntax for now.
" It only searches for a match with the keyword according to command 'gd'
let g:SrcExpl_searchLocalDef = 1
" Do not let the Source Explorer update the tags file when opening
let g:SrcExpl_isUpdateTags = 0
" Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to
" create/update a tags file
let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ."
" Set <???> key for updating the tags file artificially
"let g:SrcExpl_updateTagsKey = "<???>" 
" Map key ,3 to toggle SourceExplorer
nnoremap <silent> ,3 :SrcExplToggle<CR>
"nnoremap <silent> ,3 :TrinityToggleSourceExplorer<CR>

" " OMNICPPCOMPLETE (#1520)
" " Configuration according to: http://vim.wikia.com/wiki/C%2B%2B_code_completion
" " Enable global scope search
" let OmniCpp_GlobalScopeSearch = 1
" " Enable namespace search
" "let OmniCpp_NamespaceSearch = 1
" let OmniCpp_NamespaceSearch = 2
" " Show access (+, #, -) in the popup menu
" let OmniCpp_ShowAccess = 1
" " Show function parameters
" let OmniCpp_ShowPrototypeInAbbr = 1
" " Autocomplete after .
" let OmniCpp_MayCompleteDot = 1
" " Autocomplete after ->
" let OmniCpp_MayCompleteArrow = 1
" " Autocomplete after ::
" let OmniCpp_MayCompleteScope = 1
" " Default namespaces list (like using directive)
" "let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" let OmniCPP_DefaultNamespaces = []
" " Automatically open and close the popup menu / preview window
" au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
" set completeopt=menuone,menu,longest,preview
" " End of configuration according to Vim wiki
" Map key ,,ctags to generate tags
nnoremap <silent> ,,ctags :!ctags -R -I --sort=yes --languages=c++ --langmap=c++:+.ci --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" CLANG COMPLETE (#3302)
" Automatically select the first entry in the popup menu
let g:clang_auto_select = 0
" Automatic completion after '->', '.' and '::'
let g:clang_complete_auto = 0
" Automatically open quickfix window on error
let g:clang_complete_copen = 1
" Highlight warnings and errors the same way clang does it
let g:clang_hl_errors = 1
" Periodically update the quickfix window
let g:clang_periodic_quickfix = 0
" Map key ,c to update the quickfix window
nnoremap <silent> ,c :call g:ClangUpdateQuickFix()<CR>
" Do snippets magic by completing function arguments
let g:clang_snippets = 0
" The snippets engine
let g:clang_snippets_engine = 'clang_complete'
" Use conceal feature to hide <# and #> which delimit snippets
let g:clang_conceal_snippets = 1
" Name or path of clang executable
let g:clang_exec = 'clang'
" Option added at the end of clang command
let g:clang_user_options = '-fcxx-exceptions'
" Sources for user options passed to clang
let g:clang_auto_user_options = 'path, .clang_complete'
" Use libclang directly instead of aclling clang/clang++ tool
let g:clang_use_library = 1
" Path to libclang
"let g:clang_library_path = ''
" Completion results sorting algorithm (alpha/priority)
let g:clang_sort_algo = 'priority'
" Complete preprocessor macros and constants
let g:clang_complete_macros = 1
" Complete code paterns, such as loop constructs etc.
let g:clang_complete_patterns = 1

" SUPERTAB (#1643)
" Default completion type
let g:SuperTabDefaultCompletionType = 'context'
" Default secondary completion type
let g:SuperTabContextDefaultCompletionType = '<c-n>'
" Supertab key mappings
let g:SuperTabMappingForward = '<nul>'
let g:SuperTabMappingBackward = '<s-nul>'

" SNIPMATE (#2540)

" CONQUE (#2771)$
" Map key ,,c to open new tab with terminal$
nnoremap <silent> ,,c :ConqueTermTab bash<CR>
" Map key ,,rt to run command in new tab$
nnoremap ,,rt :ConqueTermTab 
" Map key ,,rs to run command in new horizontal buffer$
nnoremap ,,rs :ConqueTermSplit 
" Map key ,,rv to run command in new vertical buffer$
nnoremap ,,rv :ConqueTermVSplit 

" OPEN-PDF (#4708)
" Automatically convert PDFs on opening them
let g:pdf_convert_on_read = 1
let g:pdf_convert_on_edit = 1

" FUGITIVE (#2975)

" STARTIFY (https://github.com/mhinz/vim-startify)
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
  \ 'COMMIT_EDITMSG',
  \ ]
" Show <empty buffer> and <quit> on Startify screen
let g:startify_enable_special = 1
" Customize lists shown on Startify screen (files, dir, bookmarks, sessions)
let g:startify_list_order = [
  \ ['   sessions'],
  \ 'sessions',
  \ ['   bookmarks'],
  \ 'bookmarks',
  \ ['   recent files (current directory)'],
  \ 'dir',
  \ ['   recent files (global)'],
  \ 'files',
  \ ]
" Display custom header on Startify screen
let g:startify_custom_header = map(split(system('tips | cowsay -f apt'), '\n'), '"   ". v:val') + ['']
" Display custom footer on Startify screen
let g:startify_custom_footer = ''
" Display custom status line when opening Startify screen
autocmd User Startified let &l:stl = 'Startify [b:same window] [s:split window] [v:vertical split window] [t:new tab]'
" Prevent NERDTree to open a buffer in Startify window
"autocmd User Startified setlocal buftype=
" Specify bookmarks
let g:startify_bookmarks = []
" Map key ,0 to show Startify screen
nnoremap <silent> ,0 :Startify<CR>
" Map key ,ss to save the session
nnoremap <silent> ,,ss :SSave<CR>
" Map key ,sl to load the session
nnoremap <silent> ,,sl :SLoad<CR>
" Map key ,sc to close the session
nnoremap <silent> ,,sc :SClose<CR>
" Map key ,sd to load the session
nnoremap <silent> ,,sd :SDelete<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        LIST OF CUSTOM KEY BINDINGS                        "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"   CTRL-\      ,
"
"   ,c          update the quickfix window
"   ,h          go to previous tab
"   ,H          move current tab left
"   ,i          toggle indentation options
"   ,l          go to next tab
"   ,L          move current tab right
"   ,m          enable mouse
"   ,M          disable mouse
"   ,n          toggle line numbering
"   ,N          toggle line numbering
"   ,p          paste "+ register
"   ,P          paste "+ register
"   ,r          refresh current buffer
"   ,R          refresh all buffers on all tabsd
"   ,s          toggle swap files
"   ,t          toggle expandtabs option
"   ,w          toggle text wrapping
"   ,y          yank into "+ register
"   ,Y          yank into "+ register
"   ,`          find current file in NerdTree
"   ,1          show NerdTree
"   ,2          toggle TagList window
"   ,@          show tag prototype
"   ,3          toggle SourceExplorer
"   ,9          show BufExplorer
"   ,0          show Startify screen

"   ,,c         open new tab with terminal$
"   ,,j         close current tab
"   ,,k         open new tab
"   ,,p         paste "0 register
"   ,,P         paste "0 register
"   ,,q         close all buffers (:qall)

"   ,,cpp       set file type to C++
"   ,,ctags     generate ctags
"   ,,du        diff: update
"   ,,dj        diff: off (:diffoff)
"   ,,dk        diff: on (:diffthis)
"   ,,dw        diff: ignore whitespaces
"   ,,dW        diff: do not ignore whitespaces
"   ,,hup       source configuration file
"   ,,mb        merge: diffget base
"   ,,ml        merge: diffget local
"   ,,mr        merge: diffget remote
"   ,,rs        run command in new horizontal buffer
"   ,,rt        run command in new tab
"   ,,rv        run command in new vertical buffer


" vim: ts=2 sw=2 et


