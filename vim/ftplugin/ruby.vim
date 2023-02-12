
if exists("b:did_ftplugin")
  finish
endif


let &makeprg="ruby -c %"
imap <C-CR> <CR><CR>end<Esc>-cc
setl ts=2 sw=2 sts=2
iabbr ipeb require 'pry'; binding.pry
