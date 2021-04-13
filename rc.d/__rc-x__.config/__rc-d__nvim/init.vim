" Neovim main configuration file
"
" Maintainer:  Marek Balint <mareq@balint.eu>
" Last change: 2021 Apr 10


" VIM
" Source the common vim/nvim configuration
source $HOME/.config/vim/init.vim


" PLUGINS
" see `plugin` subdirectory for plugin configurations

" CoC: Path to the data directory needs to be set before the plugin is loaded
let g:coc_data_home = "~/.local/share/coc"

" Pathogen: Load plugins
execute pathogen#infect()


" vim: ts=2 sw=2 et


