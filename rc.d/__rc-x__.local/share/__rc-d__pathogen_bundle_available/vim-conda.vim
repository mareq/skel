" VIM-CONDA (#5107; https://github.com/cjrh/vim-conda)
" TODO: Install & Reevaluate
" Current evaluation: May be useful, but too annoying - see details below.
" Conda sets the `$CONDA_DEFAULT_ENV` environment variable and Vim-Conda
" initialilzed the `g:conda_startup_env` variable to that value. But then
" it tries to find a directory with that name, which does not exist.
" For some reason there is only `/opt/conda" directory listed
" by the `get_envs()` function. And so it prints out ugly error message.


" vim: ts=2 sw=2 et


