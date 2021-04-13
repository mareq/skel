" NVIM-LSPCONFIG (#NA; https://github.com/neovim/nvim-lspconfig)

" Global configuration
lua << EOF
-- Logging level
--vim.lsp.set_log_level("debug")

-- Disable diagnostic messages
--vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
EOF

" Setup LSPs
lua << EOF
-- Rust
require'lspconfig'.rust_analyzer.setup{}
EOF

" Use LSP omni-completion in Rust files
autocmd Filetype rust setlocal omnifunc=v:lua.vim.lsp.omnifunc


" vim: ts=2 sw=2 et


