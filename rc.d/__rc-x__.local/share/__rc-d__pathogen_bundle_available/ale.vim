" ALE (#NA; https://vimawesome.com/plugin/ale)

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
" Run ALE linters for current buffer
nmap <silent> ,,cl :ALELint<CR>
" Run fixer for current buffer
nmap <silent> ,,cf :ALEFix<CR>
" Search for a symbol
nmap ,,cs :ALESymbolSearch
" Rename symbol
nmap ,,cn :ALERename<CR>
" Go to previous linter error
nmap <silent> [d :ALEPrevious<CR>
" Go to next linter error
nmap <silent> ]d :ALENext<CR>
" Display detail of the error
nmap <silent> <SPACE>e :ALEDetail<CR>
" Go to definition
nmap <silent> ,.d :ALEGoToDefinition<CR>
" Go to symbol's type definition
nmap <silent> ,.t :ALEGoToTypeDefinition<CR>
" Find references
nmap <silent> ,.r :ALEFindReferences<CR>
" Show details
nmap <silent> K :ALEHover<CR>
" Show details in preview window
nmap <SPACE>a <Plug>(ale_documentation)

" Allow only explicitly setup linters
let g:ale_linters_explicit = 1
" When to run linters
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = "never"
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 0
let g:ale_lint_on_filetype_changed = 0
" Nice linter processes
"let g:ale_command_wrapper = 'nice -n19 ionice -c3'
" Allow fixing files when they are saved
let g:ale_fix_on_save = 0
" Error highlighting
let g:ale_set_highlights = 1
let g:ale_set_signs = 1
let g:ale_sign_highlight_linenrs = 0 let g:ale_sign_error = " "
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
" Autocompletion
let g:ale_completion_enabled = 1
imap <C-Space> <Plug>(ale_complete)

" ALE configuration for Markdown
let s:ale_linters_markdown = []
" Markdown linter: alex
call add(s:ale_linters_markdown, "alex")
" Markdown linter: languagetool
call add(s:ale_linters_markdown, "languagetool")
" Markdown linter: markdownlint
call add(s:ale_linters_markdown, "markdownlint")
" Markdown linter: mdl
call add(s:ale_linters_markdown, "mdl")
" Markdown linter: proselint
call add(s:ale_linters_markdown, "proselint")
" Markdown linter: redpen
call add(s:ale_linters_markdown, "redpen")
" Markdown linter: remark_lint
call add(s:ale_linters_markdown, "remark_lint")
" Markdown linter: textlint
call add(s:ale_linters_markdown, "textlint")
" Markdown linter: vale
call add(s:ale_linters_markdown, "vale")
" Markdown linter: writegood
call add(s:ale_linters_markdown, "writegood")
" Markdown fixers
let s:ale_fixers_markdown = [
\ "two_trailing_lines",
\]

" ALE configuration for Python
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
call add(s:ale_python_pylint_options, "--argument-rgx=\"^_?[a-z][a-z0-9]*(_[a-z0-9]+)*$\"") " allow short argument names (still snake-case)
call add(s:ale_python_pylint_options, "--attr-rgx=\"^_{0,2}[a-z][a-z0-9]*(_[a-z0-9]+)*$\"") " allow short attribute names (still snake-case)
call add(s:ale_python_pylint_options, "--variable-rgx=\"^[a-z][a-z0-9]*(_[a-z0-9]+)*$\"") " allow short variable names (still snake-case)
call add(s:ale_python_pylint_options, "--class-rgx=\"^[A-Z][a-z0-9]*([A-Z][a-z0-9]+)*$\"") " allow short variable names (still snake-case)
call add(s:ale_python_pylint_options_ignore, "C0305") " C0305: trailing blank lines
call add(s:ale_python_pylint_options_ignore, "E0401") " E0401: import-error (TODO: fix this)
call add(s:ale_python_pylint_options_ignore, "W0106") " W0106: expression-not-assigned
call add(s:ale_python_pylint_options_ignore, "R0913") " R0913: too-many-arguments
call add(s:ale_python_pylint_options, "--disable=" . join(s:ale_python_pylint_options_ignore, ','))
let g:ale_python_pylint_options = join(s:ale_python_pylint_options, ' ')
" Python fixers
let s:ale_fixers_python = [
\ "trim_whitespace",
\ "isort",
\ "reorder-python-imports",
\ "autopep8",
\ "two_trailing_lines",
\]

" ALE configuration for Rust
let s:ale_linters_rust = []
" Rust linter: rustc
" call add(s:ale_linters_rust, "rustc")
" Rust linter: cargo
"call add(s:ale_linters_rust, "cargo")
let g:ale_rust_cargo_check_tests = 1
let g:ale_rust_cargo_check_examples = 1
let g:ale_rust_cargo_use_clippy = executable("cargo-clippy")
let g:ale_rust_cargo_clippy_options = ""
" Rust linter: rls
"call add(s:ale_linters_rust, "rls")
" Rust linter: analyzer
call add(s:ale_linters_rust, "analyzer")
let g:ale_rust_analyzer_config = {
\ 'rust-analyzer.lruCapacity': 32,
\ }
" Rust fixers
let s:ale_fixers_rust = [
\ "trim_whitespace",
\ "rustfmt",
\]

" ALE initialize linters and fixers specified above
let g:ale_linters = {
\ "markdown": s:ale_linters_markdown,
\ "python": s:ale_linters_python,
\ "rust": s:ale_linters_rust,
\}
let g:ale_fixers = {
\ "markdown": s:ale_fixers_markdown,
\ "python": s:ale_fixers_python,
\ "rust": s:ale_fixers_rust,
\}


" vim: ts=2 sw=2 et


