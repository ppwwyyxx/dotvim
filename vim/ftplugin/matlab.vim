if exists("b:did_ftplugin")
  finish
endif

inoremap <buffer> if<Space> if<Space><CR>end<Up>
inoremap <buffer> for<Space> for<Space><CR>end<Up><End>
inoremap <buffer> func<Space> function<Space><CR>end<Up><End>
