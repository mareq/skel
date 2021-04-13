" REST-CONSOLE (#5182; https://github.com/diepm/vim-rest-console.git)

" Allow GET requests to have body
let g:vrc_allow_get_request_body = 1
" Enable automatic formatting of the response
let g:vrc_auto_format_response_enabled = 1
" Use JSON content type by default
let g:vrc_response_default_content_type = 'application/json'
" cUrl options
let g:vrc_curl_opts = {
  \ "-sS": "",
  \ "-i": "",
  \ "--connect-timeout": 3600,
\}
" Print executed curl command
let g:vrc_show_command = 1
" Set trigger key (<C-j> by default)
let g:vrc_trigger = ",,sr"


" vim: ts=2 sw=2 et


