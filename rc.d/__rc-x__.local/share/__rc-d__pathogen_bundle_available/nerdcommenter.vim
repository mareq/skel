" NERD-COMMENTER (#1218; https://github.com/scrooloose/nerdcommenter)


" Use extra space around comment delimiters
let NERDSpaceDelims = 0
" Default alignment for comments being inserted
let NERDDefaultAlign = "left"
" Key mappings
let NERDCreateDefaultMappings = 0
nmap ,,cc <Plug>NERDCommenterToggle
xmap ,,cc <Plug>NERDCommenterToggle
nmap ,,c> <Plug>NERDCommenterComment
xmap ,,c> <Plug>NERDCommenterComment
nmap ,,c< <Plug>NERDCommenterUncomment
xmap ,,c< <Plug>NERDCommenterUncomment


" vim: ts=2 sw=2 et


