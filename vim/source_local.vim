" local vimrc overwrite the global one
if filereadable(expand("~/.vimrc.local"))
  execute 'so' expand("~/.vimrc.local")
endif
if filereadable(getcwd() . "/.vimrc.local")
  so .vimrc.local
else
  if filereadable(getcwd() . "/../.vimrc.local")
    so ../.vimrc.local
  else
    if filereadable(getcwd() . "/../../.vimrc.local")
      so ../../.vimrc.local
    endif
  endif
endif
