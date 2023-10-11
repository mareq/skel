" ALE (#NA; https://vimawesome.com/plugin/ale)
"
" CoC is used as the default choice in this ALE-CoC-mixed configuration. ALE is used only as a fallback for running
" scripts which CoC can not run. In order to make the behaviour uniform, regardless of how the linters are being run,
" this configuration makes CoC send its code-diagnostics to ALE and ALE is used to display them.

" GENERAL BEHAVIOUR
" Disable LSP features in ALE (offloaded to CoC)
" https://github.com/dense-analysis/ale#5iii-how-can-i-use-ale-and-cocnvim-together
"   with :CocConfig and add `"diagnostic.displayByAle": true`
let g:ale_disable_lsp = 1
" Fix new-line characters in code-diagnostic messages from CoC
let g:ale_other_source_text_line_separator = "    "
" Display ALE info
nmap <silent> ,,Ai :ALEInfo<CR>
" Restart ALE
nmap <silent> ,,Ar :ALEReset<CR>
" Enable ALE
nmap <silent> ,,ak :ALEEnableBuffer<CR>
nmap <silent> ,,Ak :ALEEnable<CR>
" Disable ALE
nmap <silent> ,,Aj :ALEDisable<CR>
nmap <silent> ,,aj :ALEDisableBuffer<CR>
" Allow only explicitly setup linters
let g:ale_linters_explicit = 1
" When to run linters
let g:ale_lint_on_enter = 0
"let g:ale_lint_on_text_changed = "never"
"let g:ale_lint_on_insert_leave = 0
"let g:ale_lint_on_save = 0
"let g:ale_lint_on_filetype_changed = 0
"let g:ale_lint_on_enter = 1
let g:ale_lint_on_text_changed = "normal"
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_filetype_changed = 1
" Allow fixing files when they are saved
let g:ale_fix_on_save = 0
" Nice linter processes
"let g:ale_command_wrapper = 'nice -n19 ionice -c3'
" Error highlighting
let g:ale_set_highlights = 1
let g:ale_set_signs = 1
let g:ale_sign_highlight_linenrs = 0
let g:ale_sign_error = " "
let g:ale_sign_warning = " "
let g:ale_sign_info = " "
let g:ale_sign_style_error = " "
let g:ale_sign_style_warning = " "
" Format for linter messages
let g:ale_echo_msg_error_str = "err"
let g:ale_echo_msg_warning_str = "warn"
let g:ale_echo_msg_info_str = "info"
let g:ale_echo_msg_log_str = "log"
let g:ale_echo_msg_format = "%linter% [%severity%(%code%)]: %s"
let g:ale_lsp_show_message_format = g:ale_echo_msg_format
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_delay = 10
"let g:ale_virtualtext_prefix = "    <!! "
let g:ale_virtualtext_prefix = "     "
let g:ale_virtualtext_suffix = " "
" Display information in floating windows
let g:ale_set_balloons = 1
let g:ale_floating_preview = 1
let g:ale_hover_to_floating_preview = 1
let g:ale_detail_to_floating_preview = 1
" Display detail of the error
let g:ale_cursor_detail = 0
nmap <silent> <SPACE>e :ALEDetail<CR>
" Run ALE linters for current buffer
nmap <silent> ,,cl :ALELint<CR>

" ALE configuration for Python
" TODO: Switch from ALE to CoC for Python once CoC suport for Python is improved:
" - lint using PEP8 style guide
" - format Python code (e.g. reorder imports according to PEP8)
let s:ale_linters_python = []
" Customize python flake8
call add(s:ale_linters_python, "flake8")
let s:ale_python_flake8_options = []
call add(s:ale_python_flake8_options, "--max-line-length=120") " custom max line length
let s:ale_python_flake8_options_ignore = [] " ignored errors
call add(s:ale_python_flake8_options_ignore, "E201") " E201: whitespace after '[', '{'
call add(s:ale_python_flake8_options_ignore, "E202") " E202: whitespace before ']', '}'
call add(s:ale_python_flake8_options_ignore, "E226") " E226: missing whitespace around arithmetic operator
call add(s:ale_python_flake8_options_ignore, "E231") " E231: missing whitespace after ','
call add(s:ale_python_flake8_options_ignore, "E251") " E251: unexpected spaces around keyword / parameter equals
call add(s:ale_python_flake8_options_ignore, "E501") " E501: line too long
call add(s:ale_python_flake8_options_ignore, "E731") " E731: do not assign a lambda expression, use a def
call add(s:ale_python_flake8_options_ignore, "F541") " F541: f-string is missing placeholders
call add(s:ale_python_flake8_options_ignore, "W391") " W391: trailing blank lines
call add(s:ale_python_flake8_options_ignore, "W503") " W503: line break before binary operator
call add(s:ale_python_flake8_options_ignore, "W504") " W504: line break after binary operator
call add(s:ale_python_flake8_options, "--ignore=" . join(s:ale_python_flake8_options_ignore, ','))
let g:ale_python_flake8_options = join(s:ale_python_flake8_options, ' ')
" Customize python mypy
call add(s:ale_linters_python, "mypy")
let s:ale_python_mypy_options = []
let s:ale_python_mypy_options_ignore = [] " ignored errors
call add(s:ale_python_mypy_options, "--show-error-codes") " display error codes in the messages (so that they can be selectively suppressed)
"call add(s:ale_python_mypy_options, "--ignore-missing-imports") " suppress found module but no type hints or library stubs error
let g:ale_python_mypy_options = join(s:ale_python_mypy_options, ' ')
" Map ,,Apts to add mypy error suppression comment
nmap <silent> ,,Apts A  # type: ignore[]<ESC>
" Customize python pylint
call add(s:ale_linters_python, "pylint")
let s:ale_python_pylint_options = []
let s:ale_python_pylint_options_ignore = [] " ignored errors
call add(s:ale_python_pylint_options, "--max-line-length=120") " set maximum line length to custom value
call add(s:ale_python_pylint_options, "--argument-rgx=\"^_?[a-z][a-z0-9]*(_[a-z0-9]+)*$\"") " allow short argument names (still snake-case)
call add(s:ale_python_pylint_options, "--attr-rgx=\"^_{0,2}[a-z][a-z0-9]*(_[a-z0-9]+)*$\"") " allow short attribute names (still snake-case)
call add(s:ale_python_pylint_options, "--variable-rgx=\"^_?[a-z][a-z0-9]*(_[a-z0-9]+)*$\"") " allow short variable names (still snake-case)
call add(s:ale_python_pylint_options, "--class-rgx=\"^[A-Z][a-z0-9]*([A-Z][a-z0-9]*)*$\"") " allow short class names (still camel-case)
call add(s:ale_python_pylint_options_ignore, "C0305") " C0305: trailing blank lines
call add(s:ale_python_pylint_options_ignore, "E0401") " E0401: import-error (TODO: fix this)
call add(s:ale_python_pylint_options_ignore, "W0106") " W0106: expression-not-assigned
call add(s:ale_python_pylint_options_ignore, "R0913") " R0913: too-many-arguments
call add(s:ale_python_pylint_options, "--disable=" . join(s:ale_python_pylint_options_ignore, ','))
let g:ale_python_pylint_options = join(s:ale_python_pylint_options, ' ')
" Python fixers
let s:ale_fixers_python = [
\ "trim_whitespace",
\ "reorder-python-imports",
"\ "autopep8",
\ "black",
\ "isort",
"\ "two_trailing_lines",
\]

" ALE initialize linters and fixers specified above
let g:ale_linters = {
\ "python": s:ale_linters_python,
\}
let g:ale_fixers = {
\ "python": s:ale_fixers_python,
\}


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
" Additional word characters
autocmd FileType * let b:coc_additional_keywords = ["-"]
" Trigger autocomplete
inoremap <silent><expr> <C-Space> coc#refresh()
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
" Format (selected) code
nmap ,,cf <Plug>(coc-format)
nmap ,,cF <Plug>(ale_fix)
xmap ,,cf <Plug>(coc-format-selected)
" Organize imports of the current buffer
nmap ,,ci :call CocAction("runCommand", "editor.action.organizeImport")<CR>
" Rename symbol
nmap ,,cn <Plug>(coc-rename)
" Apply CodeAction to the selection (normal mode needs selection/motion suffix, such as `omap if` below)
nmap ,,ca <Plug>(coc-codeaction-selected)
xmap ,,ca <Plug>(coc-codeaction-selected)
nmap ,,cA <Plug>(coc-codeaction)
xmap ,,cA <Plug>(coc-codeaction)
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
" Refresh CoC diagnostics on writing the buffer (Error on notification "diagnostic.refresh": Action "diagnostic.refresh" not exist)
"autocmd BufWritePost * silent call CocActionAsync('diagnostic.refresh')
" Jump around diagnostic messages (let ALE do that when using both ALE & CoC in the same time)
"nmap <silent> [d <Plug>(coc-diagnostic-prev)
"nmap <silent> ]d <Plug>(coc-diagnostic-next)
nmap <silent> [d :ALEPrevious<CR>
nmap <silent> ]d :ALENext<CR>
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
"   coc-hls
"   coc-html
"   coc-html-css-support
"   coc-htmlhint
"   coc-java
"   coc-jedi
"   coc-json
"   coc-lists
"   coc-markdownlint
"   coc-perl
"   coc-prettier
"   coc-pydocstring
"   coc-pyright
"autocmd FileType python let b:coc_root_patterns = ['setup.cfg', 'pyproject.toml', 'app.py', 'setup.py', 'manage.py', 'requirements.txt', 'pyrightconfig.json']
"   coc-rls
"   coc-rome
"   coc-rust-analyzer
"   coc-sh
"   coc-snippets
"   coc-spell-checker
"   coc-sql
"   coc-stylelint
"   coc-stylelintplus
"   coc-swagger
"   coc-texlab
"   coc-toml
"   coc-translator
"   coc-tsserver
"   coc-xml
"   coc-yaml


" vim: ts=2 sw=2 et


