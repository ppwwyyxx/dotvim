
if exists("b:did_ftplugin")
  finish
endif

iabbr #i #include
iabbr #I #include
setl ts=2 sw=2 sts=2

let &makeprg="clang++ % -g -Wall -Wextra -O0 -std=c++11 -o %<"
if filereadable(getcwd() . "/Makefile")
  let &makeprg="make"
elseif  filereadable(getcwd() . "/../Makefile")
  let &makeprg="make -C .."
endif

syn keyword cppType real_t Vec Vec2D Vector Matrix Color PII PDD
syn keyword cppSTLType T
