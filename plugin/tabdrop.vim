function! s:TabDropHelper(file, here)
  let visible = {}
  let path = fnamemodify(a:file, ':p')
  for t in range(1, tabpagenr('$'))
    for b in tabpagebuflist(t)
      if fnamemodify(bufname(b), ':p') == path
        if a:here
          let current = tabpagenr()
          exec "tabnext " . t
          exec "tabmove " . (current - 1)
        else
          exec "tabnext " . t
        endif
        return
      endif
    endfor
  endfor

  if bufname('') == '' && &modified == 0
    exec "edit " . a:file
  else
    exec "tabnew " . a:file
  end
endfunction

function! s:TabDrop(file)
  call s:TabDropHelper(a:file, 0)
endfunction

function! s:TabDropHere(file)
  call s:TabDropHelper(a:file, 1)
endfunction

command! -nargs=1 -complete=file TabDrop call s:TabDrop(<q-args>)
command! -nargs=1 -complete=file TabDropHere call s:TabDropHere(<q-args>)
