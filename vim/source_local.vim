" local vimrc overwrite the global one
if filereadable(expand("~/.vimrc.local"))
  so $HOME/.vimrc.local
endif

func! MyTryLocalVimrc(vimrc)
  " Don't source ~/.vimrc.local twice
  if fnamemodify(a:vimrc, ":p") != expand("~/.vimrc.local")
    if filereadable(a:vimrc)
      exec 'so' a:vimrc
    endif
  endif
endfunc
call MyTryLocalVimrc(".vimrc.local")
call MyTryLocalVimrc("../.vimrc.local")
call MyTryLocalVimrc("../../.vimrc.local")
