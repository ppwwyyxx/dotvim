
let mapleader=" "
let maplocalleader=","

lua << EOF
local lazypath = vim.fn.stdpath("config") .. "/bundle/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
local plugins = {}
local use = function(x) table.insert(plugins, x) end

use 'vim-scripts/MultipleSearch'
use 'ppwwyyxx/vim-PinyinSearch'

use {'rhysd/accelerated-jk', lazy = false }
use {'yonchu/accelerated-smooth-scroll', lazy = false }
use {'tsaleh/vim-align', cmd = {'Align', 'AlignCtrl'} }
use 'tpope/vim-surround'
use 'preservim/nerdcommenter'
use {'glts/vim-textobj-comment', dependencies = 'kana/vim-textobj-user'}
use {'kana/vim-textobj-indent', dependencies = 'kana/vim-textobj-user'}

require("lazy").setup(plugins, {
  root = vim.fn.stdpath("config") .. "/bundle_vscode",
})
EOF

set scrolljump=5                       " lines to scroll with cursor
set scrolloff=5                        " minimum lines to keep at border

set undofile                       " keep an undo record separately for every file
set undolevels=200
set undodir=~/.vimtmp/undo
set updatetime=500                     " time threshold for CursorHold event

" Mappings:
set timeoutlen=300                     " wait for ambiguous mapping
set ttimeoutlen=0                      " wait for xterm key escape
xnoremap / <Esc>/\%V
nnoremap ; :
command! -bang -nargs=* Q q<bang>
command! -bang -nargs=* -complete=file W w<bang> <args>
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>

nnoremap Y y$
xnoremap <c-c> "+y
inoremap <c-v> <Esc>:set paste<CR>"+p:set nopaste<CR>a

nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
let g:accelerated_jk_acceleration_limit = 500
let g:accelerated_jk_acceleration_table = [10, 20, 30, 35, 40, 45, 50]

inoremap <c-h> <Left>
inoremap <c-j> <Down>
inoremap <c-k> <Up>
inoremap <c-l> <Right>
imap <c-e> <End>
imap <c-a> <Home>
inoremap <c-b> <S-Left>
inoremap <a-f> <Esc>lwi
inoremap <a-b> <Esc>bi

func! ClearMyHighlight()
  " https://vi.stackexchange.com/questions/3148/what-is-the-functional-difference-between-nohlsearch-and-set-nohlsearch
  call clearmatches()
  " Different from regular vim. otherwise buggy buffer in vscode
  return ":let v:hlsearch=0\<CR>:silent! SearchReset\<CR>"
endfunc
nnoremap <expr> <Leader>no ClearMyHighlight()

" Plugins:
nnoremap ? :call PinyinSearch()<CR>
let g:PinyinSearch_Dict = $HOME . "/.vim/bundle/vim-PinyinSearch/PinyinSearch.dict"

let g:NERDCreateDefaultMappings = 0
nmap <Leader>cc <Plug>NERDCommenterSexy
xmap <Leader>cc <Plug>NERDCommenterSexy
nmap <Leader>cl <Plug>NERDCommenterAlignLeft
xmap <Leader>cl <Plug>NERDCommenterAlignLeft
nmap <Leader>uc <Plug>NERDCommenterUncomment
xmap <Leader>uc <Plug>NERDCommenterUncomment

nnoremap <silent> * :execute ':Search \<' . expand('<cword>') . '\>'<cr>
let g:MultipleSearchMaxColors = 16

" Vscode:
nnoremap <Leader>fm :call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>
nnoremap <Leader>mm :call VSCodeNotify('editor.action.toggleMinimap')<CR>
nnoremap <Leader>tl :call VSCodeNotify('breadcrumbs.focusAndSelect')<CR>
nnoremap <C-q>z :call VSCodeNotify('workbench.action.toggleZenMode')<CR>
nnoremap <Leader>/ :call VSCodeNotify('search.action.openNewEditor')<CR>
nnoremap <Leader>pp :call VSCodeNotify('workbench.action.openRecent')<CR>
nnoremap <Leader>gC :call VSCodeNotify('gitlens.copyRemoteFileUrlToClipboard')<CR>
nnoremap ]e :call VSCodeNotify('editor.action.marker.nextInFiles')<CR>
nnoremap [e :call VSCodeNotify('editor.action.marker.prevInFiles')<CR>

command! -bang Quit call VSCodeNotify('workbench.action.closeEditorsInGroup')
command! -bang Wq call VSCodeCall('workbench.action.files.save') | call VSCodeNotify('workbench.action.closeEditorsInGroup')

" reload file from disk:, what about :e file?
"command! e call VSCodeNotify('workbench.action.files.revert')
