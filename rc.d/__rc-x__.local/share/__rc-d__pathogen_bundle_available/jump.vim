" Jump to previouisly visited locations (https://vim.fandom.com/wiki/Jumping_to_previously_visited_locations)

function! GotoJump()
  jumps
  let j = input("Please select your jump: ")
  if j != ''
    let pattern = '\v\c^\+'
    if j =~ pattern
      let j = substitute(j, pattern, '', 'g')
      execute "normal " . j . "\<c-i>"
    else
      execute "normal " . j . "\<c-o>"
    endif
  endif
endfunction

nmap ,,<C-o> :call GotoJump()<CR>


" vim: ts=2 sw=2 et


