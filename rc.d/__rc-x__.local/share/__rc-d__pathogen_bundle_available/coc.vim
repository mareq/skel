" COC (#NA; https://github.com/neoclide/coc.nvim)

" GENERAL BEHAVIOUR
" Display CoC info
nmap <silent> ,,Ci :CocInfo<CR>
" Restart CoC (needs second `<CR>` to confirm message from CoC saying that it is restarting)
nmap <silent> ,,Cr :CocRestart<CR><CR>
" Enable CoC
nmap <silent> ,,Ck :CocEnable<CR>
" Disable CoC
nmap <silent> ,,Cj :CocDisable<CR>
" Manage extensions.
nnoremap <silent> ,,Ce :<C-u>CocList --no-quit extensions<cr>
nnoremap <silent> ,,CE :<C-u>CocList --no-quit marketplace<cr>
" Update CoC
nmap <silent> ,,Cu :CocUpdateSync<CR>:CocRebuild<CR>
" List available commands
nnoremap <silent> ,,cm  :<C-u>CocList commands<cr>
" Close all floating windows
nmap <silent> ,,cwq :call coc#float#close_all()<CR>
nmap <silent> <C-W>,q :call coc#float#close_all()<CR>
" Jump to the first floating window
nmap <silent> ,,cww <Plug>(coc-float-jump)
nmap <silent> <C-W>,w <Plug>(coc-float-jump)
" Scrolling content of floating windows
if has("nvim-0.4.0") || has("patch-8.2.0750")
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif
" Do default action for next item.
nnoremap <silent> ]l  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> [l  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>l  :<C-u>CocListResume<CR>
" Sanitize `,.`, `,,c`, `,,C` combinations - this prevents it from e.g. repeating the last edit (the `.`) in unfinished combo-hits
nmap <silent> ,. <NOP>
nmap <silent> ,,c <NOP>
nmap <silent> ,,C <NOP>

" EDITING
" Trigger autocomplete
inoremap <silent><expr> <C-Space> coc#refresh()
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
" Format (selected) code
nmap ,,cf <Plug>(coc-format)
xmap ,,cf <Plug>(coc-format-selected)
" Organize imports of the current buffer
nmap ,,ci :call CocAction("runCommand", "editor.action.organizeImport")<CR>
" Rename symbol
nmap ,,cn <Plug>(coc-rename)
" Apply CodeAction to the selection (normal mode needs selection/motion suffix, such as `omap if` below)
nmap ,,ca <Plug>(coc-codeaction-selected)
xmap ,,ca <Plug>(coc-codeaction-selected)
" Apply AutoFix to problem on the current line.
nmap ,,cx <Plug>(coc-fix-current)
" Refactor current symbol
nmap ,,cr <Plug>(coc-refactor)
" Refactor occurences of a search term
function! s:search_action()
  call inputsave()
  let search_args = input("Search: ")
  call inputrestore()
  return ":CocSearch ".search_args."\r"
endfunction
nmap <silent><expr>,,cs <SID>search_action()
" Select function/class object
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
" Select range
nmap <silent> ,,cv <Plug>(coc-range-select)
xmap <silent> ,,cv <Plug>(coc-range-select)

" CODE NAVIGATION
" GoTo code navigation
nmap <silent> ,.d <Plug>(coc-definition)
nmap <silent> ,.c <Plug>(coc-declaration)
nmap <silent> ,.t <Plug>(coc-type-definition)
nmap <silent> ,.i <Plug>(coc-implementation)
nmap <silent> ,.r <Plug>(coc-references-used)
nmap <silent> ,.R <Plug>(coc-references)
" Find symbol of current document.
nnoremap <silent> <SPACE>s  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> ,3  :<C-u>CocList --interactive symbols<cr>
nnoremap <silent> <SPACE>S  :<C-u>CocList --interactive symbols<cr>
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync("highlight")
" Show documentation in preview window.
function! s:show_documentation()
  if (index(["vim","help"], &filetype) >= 0)
    execute "h ".expand("<cword>")
  elseif (coc#rpc#ready())
    call CocActionAsync("doHover")
  else
    execute "!" . &keywordprg . " " . expand("<cword>")
  endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>

" DIAGNOSTICS
" Toggle diagnostics on/off
nmap <silent> ,,cd :call CocAction("diagnosticToggle")<CR>
" Jump around diagnostic messages
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)
" Show diagnostics list
nnoremap <silent> <SPACE>d  :<C-u>CocList diagnostics<cr>
" Show diagnostics window
nmap <silent> ,4 :CocDiagnostics<CR>
nmap <silent> <SPACE>D :CocDiagnostics<CR>


" EXTENSIONS
" :CocInstall coc-marketplace
"   coc-clangd
"   coc-cmake
"   coc-css
"   coc-diagnostic
"   coc-eslint
"   coc-gist
"   coc-html
"   coc-htmlhint
"   coc-html-css-support
"   coc-java
"   coc-jedi
"   coc-json
"   coc-lists
"   coc-markdownlint
"   coc-perl
"   coc-prettier
"   coc-python
"   coc-pydocstring
"   coc-rls
"   coc-rome
"   coc-rust-analyzer
"   coc-sh
"   coc-stylelintplus
"   coc-stylelint
"   coc-snippets
"   coc-spell-checker
"   coc-sql
"   coc-swagger
"   coc-texlab
"   coc-toml
"   coc-translator
"   coc-tsserver
"   coc-xml
"   coc-yaml


" vim: ts=2 sw=2 et


