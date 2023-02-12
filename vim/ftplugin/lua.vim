if exists("b:did_ftplugin")
  finish
endif

set makeef=/dev/null
let &makeprg="lua %"
setl ts=2 sw=2 sts=2
