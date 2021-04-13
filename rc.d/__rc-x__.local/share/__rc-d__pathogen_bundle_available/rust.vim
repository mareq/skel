" RUST.VIM (https://github.com/rust-lang/rust.vim)

" Use Rust recommended formatting style
let g:rust_recommended_style = 1
" Create folds for braced blocks, but leave them unfolded by default
let g:rust_fold = 1
" Autoformat on write
let g:rustfmt_autosave = 0
" Set up rustfmt
let g:rustfmt_command = "rustfmt"
let g:rustfmt_options = "--edition=2018"
" Map ,,rf to format the Rust file (using default configuration)
nnoremap <silent> ,,rf :RustFmt<CR>
" Map ,,RF ,,rF ,,Rf to format the Rust file (using user-specific configuration)
com! RustFmtUser %!rustfmt --config-path=$HOME/.rustfmt.toml
nnoremap <silent> ,,RF :RustFmtUser<CR>:set filetype=rust<CR>
nnoremap <silent> ,,rf :RustFmtUser<CR>:set filetype=rust<CR>
nnoremap <silent> ,,Rf :RustFmtUser<CR>:set filetype=rust<CR>
" Map ,,rb to invoke cargo build
nnoremap <silent> ,,rb :Cbuild<CR>
" Map ,,rt to invoke cargo test
nnoremap <silent> ,,rt :Ctest<CR>
" Map ,,ri to show Rust info
nnoremap <silent> ,,ri :RustInfo<CR>


" vim: ts=2 sw=2 et


