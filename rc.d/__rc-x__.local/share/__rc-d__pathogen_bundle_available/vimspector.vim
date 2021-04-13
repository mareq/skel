" VIMSPECTOR (#NA; https://github.com/puremourning/vimspector)

" Custom vimspector path
" ./install_gadget.py --basedir $HOME/.local/share/vimspector --all --force-all
let g:vimspector_base_dir = $HOME.'/.local/share/vimspector'

" Debugging
nmap <silent>,,dk <Plug>VimspectorContinue
nmap <silent>,,dK <Plug>VimspectorRestart
nmap <silent>,,dj <Plug>VimspectorPause
nmap <silent>,,dJ <Plug>VimspectorStop
" Stepping
nmap <silent>,,dl <Plug>VimspectorStepOver
nmap <silent>,,dL <Plug>VimspectorStepInto
nmap <silent>,,dh <Plug>VimspectorStepOut
nmap <silent>,,dd <Plug>VimspectorUpFrame
nmap <silent>,,df <Plug>VimspectorUpFrame
nmap <silent>,,d; <Plug>VimspectorRunToCursor
" Watches
nmap <silent>,,dw <Plug>VimspectorBalloonEval
xmap <silent>,,dw <Plug>VimspectorBalloonEval
function! s:watch_action()
  call inputsave()
  let watch_expr = input("Watch expression: ")
  call inputrestore()
  return ":VimspectorWatch ".watch_expr."\r"
endfunction
nmap <silent><expr>,,dW <SID>watch_action()
" Breakpoint keymaps
nmap <silent> ,,db <Plug>VimspectorToggleBreakpoint
nmap <silent> ,,dB <Plug>VimspectorToggleConditionalBreakpoint
nmap <silent> ,,dc <Plug>VimspectorAddFunctionBreakpoint
" Threads
nmap <silent> ,,dt :call vimspector#PauseContinueThread()<CR>
nmap <silent> ,,dT :call vimspector#SetCurrentThread()<CR>
" UI
nmap ,,dO :VimspectorShowOutput 
let g:vimspector_sign_priority = {
\ 'vimspectorBP':         11,
\ 'vimspectorBPCond':     11,
\ 'vimspectorBPDisabled': 11,
\ 'vimspectorPC':         999,
\}


" vim: ts=2 sw=2 et


