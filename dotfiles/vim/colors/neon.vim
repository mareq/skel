" Vim color file
" Maintainer: Marek Balint <mareq@balint.eu>
" Last change: 2017 May 07

" First remove all existing highlighting.
set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

" Set colorscheme name
let colors_name = "neon"

" Normal text
hi Normal ctermbg=black ctermfg=White guibg=#000000 guifg=#FFFFFF

" Status line
hi StatusLine term=reverse,bold cterm=reverse,bold ctermbg=LightGray ctermfg=DarkBlue gui=reverse,bold guibg=LightGray guifg=LightBlue
hi StatusLineNC term=reverse,bold cterm=reverse,bold ctermbg=DarkGray ctermfg=LightGray gui=reverse,bold guibg=DarkGray guifg=LightGray
if version >= 700
  function! InsertStatuslineColor(mode)
    if a:mode == 'i'
      hi StatusLine ctermfg=DarkRed ctermbg=LightGray guifg=DarkRed guibg=LightGray
    elseif a:mode == 'r'
      hi StatusLine ctermfg=DarkGreen ctermbg=DarkGray guifg=DarkGreen guibg=DarkGray
    else
      hi StatusLine ctermfg=DarkBlue ctermbg=LightGray guifg=DarkBlue guibg=LightGray
    endif
  endfunction
  au InsertEnter * call InsertStatuslineColor(v:insertmode)
  au InsertLeave * hi StatusLine ctermfg=DarkBlue ctermbg=LightGray guifg=DarkBlue guibg=LightGray
endif

" Groups used in the 'highlight' and 'guicursor' options default value.
hi ErrorMsg term=standout ctermbg=DarkRed ctermfg=White guibg=Red guifg=White
hi IncSearch term=reverse cterm=reverse gui=reverse
hi Search term=reverse cterm=underline ctermbg=DarkBlue ctermfg=Yellow guibg=Gray guifg=Black
hi ModeMsg term=bold cterm=bold gui=bold
hi StatusLineNC term=reverse cterm=reverse gui=reverse
hi VertSplit term=reverse cterm=reverse gui=reverse
hi Visual ctermbg=Yellow ctermfg=DarkBlue guibg=grey60
hi VisualNOS term=underline,bold cterm=underline,bold gui=underline,bold
hi DiffText term=reverse cterm=bold ctermbg=Red ctermfg=LightGray gui=bold guibg=Red
hi Cursor guibg=Green guifg=Black
hi lCursor guibg=Cyan guifg=Black
hi MatchParen term=bold ctermfg=White ctermbg=DarkGray guifg=Blue guibg=#201F1F
hi Directory term=bold ctermfg=Blue guifg=Blue
hi LineNr term=underline ctermfg=Yellow guifg=Yellow
hi MoreMsg term=bold ctermfg=LightGreen gui=bold guifg=SeaGreen
hi Question term=standout ctermfg=LightGreen gui=bold guifg=Green
hi SpecialKey term=bold ctermfg=DarkGray guifg=gray20
hi NonText term=bold ctermfg=DarkGray gui=bold guifg=gray20
hi Title term=bold ctermfg=LightMagenta gui=bold guifg=Magenta
hi WarningMsg term=standout ctermfg=LightRed guifg=Red
hi WildMenu term=standout ctermbg=Yellow ctermfg=Black guibg=Yellow guifg=Black
hi Folded term=standout ctermbg=LightGrey ctermfg=DarkBlue guibg=LightGrey guifg=DarkBlue
hi FoldColumn term=standout ctermbg=LightGrey ctermfg=DarkBlue guibg=Grey guifg=DarkBlue
hi DiffAdd term=bold ctermbg=DarkCyan ctermfg=LightGray guibg=DarkCyan
hi DiffChange term=bold ctermbg=DarkBlue ctermfg=LightGray guibg=DarkBlue
hi DiffDelete term=bold ctermbg=DarkGray ctermfg=Red gui=bold guifg=Red guibg=DarkGray
hi CursorColumn term=reverse ctermbg=Black guibg=grey40
hi CursorLine term=underline cterm=underline guibg=grey40
hi Pmenu ctermbg=Blue ctermfg=Yellow
hi PmenuSel ctermbg=LightGray ctermfg=Black
hi PmenuSbar ctermbg=Blue ctermfg=LightGray
hi PmenuThumb ctermbg=Blue 
hi TabLine cterm=bold ctermfg=Black ctermbg=LightGray
hi TabNum cterm=bold ctermfg=Black ctermbg=LightGray
hi TabWinNum cterm=bold ctermfg=Black ctermbg=LightGray
hi TabLineSel cterm=reverse,bold ctermfg=DarkBlue ctermbg=LightGray
hi TabNumSel cterm=reverse,bold ctermfg=DarkBlue ctermbg=LightGray
hi TabWinNumSel cterm=reverse,bold ctermfg=DarkBlue ctermbg=LightGray
hi TabLineFill ctermfg=LightGray ctermbg=LightGray

" Groups for syntax highlighting
hi Identifier ctermfg=LightBlue guifg=#8000FF  " identifier
hi Statement cterm=bold ctermfg=Magenta guifg=#FF00FF  " keyword
hi Structure cterm=bold ctermfg=Magenta guifg=#FF00FF  " namespace, class, etc.
hi Operator ctermfg=Yellow guifg=#FFFF00  " operator
hi Constant ctermfg=Yellow guifg=#FFFF00  " numeric value
hi Character ctermfg=Magenta guifg=#FF00FF  " character constant
hi String ctermfg=Red guifg=#FF0000  " string constant
hi Special ctermfg=Red  guifg=#FF0000  " special character (e.g. \n)
hi Type ctermfg=Yellow guifg=#FFFF00  " built-in type
hi PreProc ctermfg=White guifg=#C0C0C0
hi Comment ctermfg=Green guifg=#00FF00  " comment
hi Error ctermbg=DarkRed ctermfg=White guibg=#C00000 guifg=#FFFFFF
hi Todo cterm=bold ctermbg=DarkGray ctermfg=Brown guibg=#201F1F guifg=#FFAA00
hi Ignore ctermfg=Gray guifg=grey20
" Additional syntax highlighting groups for Man pages
hi manReference ctermfg=LightBlue guifg=#8000FF
" Additional syntax highlighting groups for Doxygen
hi doxygenComment ctermfg=Green guifg=#00FF00  " Doxygen comment
hi doxygenBriefWord ctermfg=Magenta guifg=#FF00FF
hi doxygenParam ctermfg=Magenta guifg=#FF00FF
hi doxygenOther ctermfg=Magenta guifg=#FF00FF
hi doxygenBOther ctermfg=Magenta guifg=#FF00FF
hi doxygenSpecialCodeWord ctermfg=Magenta guifg=#FF00FF
hi doxygenParamName ctermfg=Yellow guifg=#FFFF00
hi doxygenBriefLine ctermfg=Red guifg=#FF0000
hi doxygenCodeWord ctermfg=Red guifg=#FF0000
hi doxygenBriefL ctermfg=Green guifg=#00FF00
hi doxygenHeaderLine ctermfg=Green guifg=#00FF00
hi doxygenSpecialOnelineDesc ctermfg=Green guifg=#00FF00
hi doxygenSpecialMultilineDesc ctermfg=Green guifg=#00FF00
hi doxygenSpecialTypeOnelineDesc ctermfg=Green guifg=#00FF00
hi doxygenHtmlCh ctermfg=Cyan guifg=#00FFFF
hi doxygenHtmlCmd ctermfg=Cyan guifg=#00FFFF
hi doxygenHtmlCode ctermfg=Green guifg=#00FF00
" Additional syntax highlighting groups for RainbowParenthesis
hi lvl01Paren ctermfg=Yellow
hi lvl02Paren ctermfg=Green
hi lvl03Paren ctermfg=Cyan
hi lvl04Paren ctermfg=Blue
hi lvl05Paren ctermfg=Magenta
hi lvl06Paren ctermfg=Red
hi lvl07Paren ctermfg=Yellow
hi lvl08Paren ctermfg=Green
hi lvl09Paren ctermfg=Cyan
hi lvl10Paren ctermfg=Blue
hi lvl11Paren ctermfg=Magenta
hi lvl12Paren ctermfg=Red
" Additional syntax highlighting groups for NERDTree
hi treeFile ctermfg=Yellow guifg=#FFFF00
hi treeExecFile ctermfg=Green guifg=#00FF00
hi treeLink ctermfg=Cyan guifg=#00FFFF
hi treeBookmarksHeader ctermfg=Yellow guifg=#FFFF00


" vim: ts=2 sw=2


