if exists("b:did_ftplugin")
  finish
endif

set ofu=
set nofoldenable
inoremap {% {%  %}<Left><Left>
inoremap ``` ```<CR>```<Up><End><Esc>
" surround with link
xmap <Leader>l s]%a()
" emphasis
xmap <Leader>e s*gvs*
nnoremap md :LivedownToggle<CR>


let s:path = expand('<sfile>:p:h')
exec 'source' s:path . '/tex_formula.vim'

lua << EOF
require('cmp').setup.buffer({ enabled = false })
EOF

