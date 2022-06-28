" Author: Yuxin Wu

set nocompatible                    " Use Vim Settings (Not Vi). This must be first, because it changes other options as a side effect.
syntax on
" Plugins: f[[
filetype off            " for vundle

call plug#begin('~/.vim/bundle')
" UI And Basic:
if !exists('g:vscode')
  Plug 'vim-scripts/sudo.vim'
  Plug 'jlanzarotta/colorSchemeExplorer'
  Plug 'Yggdroot/indentLine'
  Plug 'uguu-org/vim-matrix-screensaver'
  Plug 'kien/rainbow_parentheses.vim'
  Plug 'vim-scripts/searchfold.vim'
  Plug 'vim-scripts/LargeFile'
  Plug 'tomasiser/vim-code-dark'
  if has('nvim')
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'kyazdani42/nvim-web-devicons'
  else
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
  endif
endif
Plug 'vim-scripts/MultipleSearch'
Plug 'ppwwyyxx/vim-PinyinSearch'

" Window Tools:
if !exists('g:vscode')
  Plug 'sjl/gundo.vim'
  if has('nvim')
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'kyazdani42/nvim-tree.lua'
    "Plug 'stevearc/aerial.nvim'
  else
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  endif
  Plug 'preservim/tagbar'
  Plug 'sjl/clam.vim'
  Plug 'ervandew/screen'
  Plug 'powerman/vim-plugin-viewdoc'
endif
" Editing Tools:
Plug 'qstrahl/vim-matchmaker'
Plug 'rhysd/accelerated-jk'
Plug 'yonchu/accelerated-smooth-scroll'
Plug 'tsaleh/vim-align'
Plug 'tpope/vim-surround'
if !exists('g:vscode') && has('nvim')
  Plug 'phaazon/hop.nvim'
endif
" Use S/s to skip halfway in a line
Plug 'jayflo/vim-skip'
Plug 'terryma/vim-expand-region'
if !exists('g:vscode')
  Plug 'terryma/vim-multiple-cursors'
endif
Plug 'scrooloose/nerdcommenter'
Plug 'glts/vim-textobj-comment'
Plug 'lucapette/vim-textobj-underscore'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-operator-user'
Plug 'jeetsukumaran/vim-indentwise'
Plug 'vim-scripts/VisIncr'
" Programming:
if !exists('g:vscode')
Plug 'ruanyl/vim-gh-line'
Plug 'myhere/vim-nodejs-complete', {'for': 'javascript'}
Plug 'LaTeX-Box-Team/LaTeX-Box', {'for': 'tex'}
Plug 'Valloric/YouCompleteMe', {'do': 'python3 ./install.py --clangd-completer', 'for': ['cpp', 'java', 'python']}
Plug 'critiqjo/lldb.nvim'  ", {'for': ['cpp', 'c'] }
Plug 'othree/html5.vim', {'for': 'html'}
Plug 'derekwyatt/vim-fswitch', {'for': [ 'cpp', 'c' ] }
Plug 'shime/vim-livedown', {'for': 'markdown'}
Plug 'neomake/neomake'
Plug 'airblade/vim-gitgutter'
Plug 'wakatime/vim-wakatime'
" Syntax:
Plug 'dense-analysis/ale'
Plug 'vim-scripts/gprof.vim'
Plug 'smilekzs/vim-coffee-script'
Plug 'chrisbra/csv.vim', {'for': 'csv'}
Plug 'mrtazz/DoxygenToolkit.vim'
Plug 'digitaltoad/vim-jade', {'for': 'jade'}
Plug 'maksimr/vim-jsbeautify'
Plug 'einars/js-beautify'
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'groenewege/vim-less'
Plug 'vim-scripts/Mathematica-Syntax-File'
Plug 'fs111/pydoc.vim'
Plug 'ujihisa/rdoc.vim'
Plug 'slim-template/vim-slim'
Plug 'wavded/vim-stylus'
Plug 'jeroenbourgois/vim-actionscript'
if !has('nvim')
  Plug 'tikhomirov/vim-glsl'
  Plug 'tpope/vim-markdown'
  Plug 'hail2u/vim-css3-syntax', {'for': 'css'}
endif

" to learn
" Plug 'rstacruz/sparkup'
endif
call plug#end()
filetype plugin indent on
" --------------------------------------------------------------------- f]]

" Environment: f[[
if exists('$TMUX')                 " fix keymap under screen
    " tmux will send xterm-style keys when its xterm-keys option is on
    exec "set <xUp>=\e[1;*A"
    exec "set <xDown>=\e[1;*B"
    exec "set <xRight>=\e[1;*C"
    exec "set <xLeft>=\e[1;*D"
endif

set shell=zsh
let g:my_term = 'urxvt'                " for plugins to open window
set iskeyword+=%,&,?,\|,\\,!
set isfname-==
set grepprg=grep\ -nH\ $*
set t_vb=                              " shut up bell
set confirm
set shortmess+=s
set fileencodings=ucs-bom,utf8,cp936,big5,euc-jp,euc-kr,gb18130,latin1
set viewoptions=folds,options,cursor,slash,unix
set virtualedit=onemore
scriptencoding utf-8
set ttyfast
"let g:html_dynamic_folds = 1
"set lazyredraw

" --------------------------------------------------------------------- f]]
" UI: f[[
set background=light
set title
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)

colo default
if !exists('g:vscode')
  set guicursor=    " neovim mess up with terminal cursor
endif
if has("gui_running")                  " for gvim
  set antialias                      " font antialias
  "set guifont=inconsolata\ 15
  set guifont=Monospace\ 12
  set guifontwide=WenQuanYi\ Micro\ Hei\ 15
  set guioptions=aegi                " cleaner gui
  set linespace=3
  set background=light
  "colo molokai
  hi CursorColumn guibg=Green
  hi Matchmaker guibg=#444444
endif
if exists('g:vscode')
  hi Matchmaker guibg=#444444
endif
set t_Co=256
au BufEnter * if &buftype == "quickfix" | syn match Error "error:" | endif
hi Search guibg=#8ca509
hi LineNr ctermfg=134 guifg=#d426ff
hi VertSplit ctermbg=none ctermfg=55 cterm=none guifg=purple
hi CursorLineNr ctermfg=red
hi Statement ctermfg=3
hi Visual ctermbg=81 ctermfg=black cterm=none
hi MatchParen ctermbg=yellow ctermfg=black
hi Pmenu ctermfg=81 ctermbg=16
hi Cursorline ctermfg=117 cterm=italic guifg=Cyan
hi Comment ctermfg=blue guifg=#145ecc
hi Search ctermfg=red ctermbg=cyan
hi DiffAdd ctermbg=none ctermfg=LightBlue
hi DiffChange ctermbg=none ctermfg=yellow
hi DiffText ctermbg=none ctermfg=55
let g:zenburn_high_Contrast = 1

" Highlight Class and Function names
if !exists('g:vscode')
func! HighlightClasses()
  syn match cCustomClass     "\w\+\s*\(::\)\@="
  hi def link cCustomClass     cppType
endfunc
au syntax * call HighlightClasses()

" Spell Check:
set spellfile=~/.vim/static/spell.utf-8.add
hi clear SpellBad
hi SpellBad term=standout term=underline cterm=italic ctermfg=none ctermbg=black guifg=red
hi clear SpellCap
hi SpellCap term=standout term=underline cterm=italic ctermfg=blue guifg=blue
hi clear SpellLocal
hi SpellLocal term=standout term=underline cterm=italic ctermfg=blue guifg=blue
hi clear SpellRare
hi SpellRare term=standout term=underline cterm=italic ctermfg=Blue guifg=blue
" Statusline Highlight:
" Having these two lines in vscode causes newline (o) to sometimes not work correctly
au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=undercurl guisp=Magenta
au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
let g:tex_conceal='adgmb'
endif

set mouse=a
set showcmd                            " display incomplete commands right_bottom
set numberwidth=1
if !exists('g:vscode')
set relativenumber
set number
set ruler
set rulerformat=%35(%=%r%Y\|%{&ff}\|%{strlen(&fenc)?&fenc:'none'}\ %m\ %l/%L%)
set laststatus=2

if has('nvim')
  lua << END
  local theme = require'lualine.themes.powerline_dark'
  theme.inactive.c.fg = theme.normal.c.fg
  theme.inactive.c.bg = theme.normal.c.bg
  -- http://lua-users.org/wiki/SplitJoin
  local split = function(str, pat)
    local t = {}  -- NOTE: use {n = 0} in Lua-5.0
    local fpat = "(.-)" .. pat
    local last_end = 1
    local s, e, cap = str:find(fpat, 1)
    while s do
       if s ~= 1 or cap ~= "" then
          table.insert(t, cap)
       end
       last_end = e+1
       s, e, cap = str:find(fpat, last_end)
    end
    if last_end <= #str then
       cap = str:sub(last_end)
       table.insert(t, cap)
    end
    return t
  end
  require('lualine').setup {
  options = {
    theme = theme,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_a = {{'mode', fmt = function(str) return str:sub(1,1) end }},
    lualine_b = {'branch', 'diff'},
    lualine_c = {
      {'filename', path = 1, fmt = function(str)
          -- shorten the path
          local parts = split(str, '[\\/]+')
          for i=1,#parts-2 do
            parts[i] = parts[i]:sub(1, 3)
          end
          return table.concat(parts, "/")
        end },
      {'diagnostics', sources = {'nvim_diagnostic', 'ale'}}
    },
    lualine_x = {'encoding', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = { lualine_x = {'progress'}, },
}
END
else
  let g:airline_theme='durant'
  "let g:airline_powerline_fonts=1
  let g:airline_mode_map = {'n': 'N', 'i': 'I', 'R': 'R', 'v': 'V', 'V': 'V'}
  let g:airline_left_sep = '»'
  let g:airline_right_sep = '«'
  let g:airline#extensions#whitespace#enabled = 0
  let g:airline#extensions#ale#enabled = 1
endif
set noshowmode
endif

set scrolljump=5                       " lines to scroll with cursor
set scrolloff=5                        " minimum lines to keep at border
set sidescroll=3
set sidescrolloff=3
set nowrap                             " do not wrap long lines
set whichwrap=b,s,<,>,[,]
"set listchars=nbsp:¬,eol:¶,tab:>-,extends:»,precedes:«,trail:•
set fillchars=vert:*,fold:-,diff:-
if v:version > 703 || has("patch541")
  set formatoptions+=nMjm            " m: linebreak for Chinese
else
  set formatoptions+=nMm
endif
set splitright splitbelow
set backspace=indent,eol,start         " allow backspace over everything
set smarttab
set autoindent smartindent
set cino=N-s
command! INDENT :pyf ~/.vim/static/clang-format.py
set textwidth=0
set tabstop=2 softtabstop=2 shiftwidth=2
set showmatch matchtime=0

if has('nvim') && !exists('g:vscode')
  lua <<EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = { 'bash', 'c', 'cmake', 'cpp', 'cuda', 'glsl', 'css', 'html', 'javascript', 'json', 'lua', 'make', 'markdown', 'ninja', 'proto', 'python', 'scss', 'typescript', 'vim', 'yaml' },
    highlight = { enable = true, },
  }
EOF
  hi clear TSVariable
  hi clear pythonTSParameter
  hi TSVariable ctermfg=white
  hi pythonTSParameter ctermfg=white
endif

set ignorecase smartcase incsearch hlsearch
set magic                              " for regular expressions
xnoremap / <Esc>/\%V
" use /[^\x00-\x7F] to search multibytes
" ---------------------------------------------------------------------f]]
" History:
set nobackup noswapfile nowritebackup
set history=200                        " command line history
if has('persistent_undo')
  set undofile                       " keep an undo record separately for every file
  set undolevels=200
  if has('nvim')
      set undodir=~/.vimtmp/undo
  else
      set undodir=~/.vimtmp/old_vim_undo
  endif
endif
if has('nvim')
  set viminfo+=n$HOME/.vimtmp/nviminfo
else
  set viminfo+=n$HOME/.vimtmp/viminfo
endif
au CursorHold,CursorHoldI,BufEnter,WinEnter * checktime
set autoread                           " auto reload file when changes have been detected
set updatetime=500                     " time threshold for CursorHold event

" ---------------------------------------------------------------------
" Basic Maps:
let mapleader=" "
let maplocalleader=","
let g:no_viewdoc_maps = 1
set timeoutlen=300                     " wait for ambiguous mapping
set ttimeoutlen=0                      " wait for xterm key escape
inoremap jj <ESC>
nnoremap ; :
command! -bang -nargs=* Q q<bang>
command! -bang -nargs=* -complete=file W w<bang> <args>
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>
nnoremap <Tab> i<Tab><Esc>
nnoremap <S-Tab> ^i<Tab><Esc>
if !exists('g:vscode')  " cmap slows down vscode
  cnoremap %% <C-R>=expand('%:h').'/'<cr>
  cmap w!! SudoWrite %
  cnoremap cd. lcd %:p:h
endif
nnoremap "gf <C-W>gf
" disable ex mode, help and c-a
nnoremap Q <Esc>
nnoremap <F1> <Esc>
inoremap <F1> <Esc>
nnoremap <C-a> <Esc>

vnoremap <expr> I ForceBlockwiseVisual('I')
vnoremap <expr> A ForceBlockwiseVisual('A')
func! ForceBlockwiseVisual(key)
  if mode () == 'v'
    return "\<C-v>". a:key
  elseif mode () == 'V'
    return "\<C-v>0o$". a:key
  else | return a:key | endif
endfunc
" ---------------------------------------------------------------------
" Clipboard:                           " + register may be wrong under xterm
nnoremap Y y$
set pastetoggle=<F12>                  " toggle paste insert mode
au VimEnter * set pastetoggle=<F12>     " workaround for bug in neovim #2843
xnoremap <c-c> "+y
inoremap <c-v> <Esc>:set paste<CR>"+p:set nopaste<CR>a
inoremap <Leader><c-v> <Esc>:r !xsel -o -p<CR>
" insert word of the line above
inoremap <C-Y> <C-C>:let @z = @"<CR>mz
      \:exec 'normal!' (col('.')==1 && col('$')==1 ? 'k' : 'kl')<CR>
      \:exec (col('.')==col('$') - 1 ? 'let @" = @_' : 'normal! yw')<CR>
      \`zp:let @" = @z<CR>a
" delete to blackhole register
nnoremap <Del> "_x
xnoremap <Del> "_d
" ---------------------------------------------------------------------
" Folding:
set foldmethod=marker
set foldmarker=f[[,f]]
set foldnestmax=2                      " nesting
set foldminlines=5
"set foldcolumn=0
"set diffopt=filler,foldcolumn:0
nnoremap zo zO

" ---------------------------------------------------------------------
" QuickFix:
if !exists('g:vscode')
set switchbuf=split
func! QuickfixToggle()
  for i in range(1, winnr('$'))
    if getbufvar(winbufnr(i), '&buftype') == 'quickfix'
      cclose | lclose
      return
    endif
  endfor
  copen
endfunc
nnoremap <Leader>q :call QuickfixToggle()<CR>
nnoremap ]e :lnext<CR>
nnoremap [e :lprev<CR>
endif

" ---------------------------------------------------------------------
" Cursor Movement: f[[
if isdirectory($HOME . "/.vim/bundle/accelerated-jk")        " a variable not assigned
  nmap j <Plug>(accelerated_jk_gj)
  nmap k <Plug>(accelerated_jk_gk)
endif
let g:accelerated_jk_acceleration_limit = 500
let g:accelerated_jk_acceleration_table = [10, 20, 30, 35, 40, 45, 50]

if !exists('g:vscode')  " affect display
  nnoremap n nzzzv
  nnoremap N Nzzzv
endif
inoremap <c-h> <Left>
inoremap <c-j> <Down>
inoremap <c-k> <Up>
inoremap <c-l> <Right>
imap <c-e> <End>
imap <c-a> <Home>
inoremap <c-b> <S-Left>
inoremap <a-f> <Esc>lwi
inoremap <a-b> <Esc>bi
if !exists('g:vscode')
  cmap <c-j> <Down>
  cmap <c-k> <Up>
  cmap <a-f> <S-Right>
  cmap <c-b> <S-Left>
  cmap <a-b> <S-Left>
  cmap <c-e> <End>
  cmap <c-d> <Home>
endif
" undoable C-U, C-W
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>
vnoremap << <gv<gv
vnoremap >> >gv>gv
" Save Cursor Position:
if !exists('g:vscode')
au BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif
" Hint On Moving Cursor:
func! HintCursorLine(opr)
  if a:opr == 0            " clear cursorline
    set nocursorline
    if exists("&cc") | set cc= | endif
    return
  endif

  if ! exists('g:last_line') | let g:last_line = -1 | end
  if ! exists('g:last_pos')  | let g:last_pos  = -1 | end
  if ! exists('g:last_win')  | let g:last_win  = -1 | end
  let cur_pos  = winline()
  let cur_line = line(".")
  let diff = max([ abs(g:last_line - cur_line), abs(g:last_pos - cur_pos) ])
  if g:last_win != winnr() || diff > 3
    set cursorline
  endif
  let g:last_pos  = cur_pos
  let g:last_line = cur_line
  let g:last_win  = winnr()
endfunc
" Highlight Chosen Columns:
func! ToggleColorColumn(col)
  let col_num = (a:col == 0) ? virtcol(".") : a:col
  let cc_list = split(&cc, ',')
  if count(cc_list, string(col_num)) <= 0
    exec "set cc+=".col_num
  else
    exec "set cc-=".col_num
  endif
endfunc
hi ColorColumn ctermbg=red
"au CursorMoved,BufWinEnter * call HintCursorLine(1)    " this greatly affects performance ...
au CursorHold,CursorHoldI,BufLeave,WinLeave * call HintCursorLine(0)
nmap <LocalLeader>c :call ToggleColorColumn(0)<CR>
endif

" ---------------------------------------------------------------------
" Window:
nmap <c-w><Right> 4<c-w>>
nmap <c-w><Left> 4<c-w><
nmap <c-w><Down> 4<c-w>-
nmap <c-w><Up> 4<c-w>+
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l
nmap <c-k> <c-w>k
nmap <c-j> <c-w>j
au vimResized * exe "normal! \<c-w>="

" ---------------------------------------------------------------------f]]
" Auto Fill Brackets:
func! AutoPair(open, close)
  let line = getline('.')
  if col('.') > strlen(line) || index([' ', ']', ')', '}'], line[col('.') - 1]) > 0
    return a:open . a:close . "\<ESC>i"
  else
    return a:open
  endif
endfunc
func! ClosePair(char)
  return (getline('.')[col('.') - 1] == a:char ? "\<Right>" : a:char)
endfunc
inoremap <expr> ( AutoPair('(', ')')
inoremap <expr> ) ClosePair(')')
inoremap <expr> [ AutoPair('[', ']')
inoremap <expr> ] ClosePair(']')
inoremap <expr> { AutoPair('{', '}')
inoremap <expr> } ClosePair('}')
inoremap " ""<Left>
inoremap ' ''<Left>
au Filetype mkd,tex,txt,lrc silent! iunmap '
au Filetype vim silent! iunmap "
au Filetype vim silent! iunmap ""
" ---------------------------------------------------------------------
" About Chinese: f[[
" punctuations auto changing has unexpected problems
imap （ (
imap ） )
imap 』 }
imap 『 {
imap 【 [
imap 】 ]
imap 。 .
imap ， ,
imap ； ;
imap ： :
imap “ "
imap ” "
imap ‘ '
imap ’ '
imap ？ ?
imap ！ !
imap 》 >
imap 《 <
imap 、 /
imap ￥ $
imap 》 >
imap 《 <
map ： :

func! Replace_Chn()                     " for writing latex
  let chinese={"（" : "(" , "）" : ")" , "，" : ",", "；" : ";", "：" : ":",
  "？" : "?", "！" : "!", "“" : "\"", "’" : "'" ,
  ""”" : "\"", "℃" : "\\\\textcelsius", "μ" : "$\\\\mu$"}
  for i in keys(chinese)
    silent! exec '%substitute/' . i . '/'. chinese[i] . '/g'
  endfor
endfunc
nnoremap <leader>sch :call Replace_Chn()<cr>

" Fcitx:
func! Fcitx_enter()
  if (getline('.')[col('.') - 1] >= "\x80" || getline('.')[col('.') - 2] >= "\x80")
    call system("fcitx-remote -o")
  endif
endfun
"autocmd InsertLeave * call system("fcitx-remote -c")
autocmd InsertEnter * call Fcitx_enter()

nmap <Leader>ps :call PinyinSearch()<CR>
nnoremap ? :call PinyinSearch()<CR>
nmap <Leader>pn :call PinyinNext()<CR>
let g:PinyinSearch_Dict = $HOME . "/.vim/bundle/vim-PinyinSearch/PinyinSearch.dict"
"let g:PinyinSearch_Dict = $HOME . "/Work/projects/vim-PinyinSearch/PinyinSearch.dict"

" ---------------------------------------------------------------------f]]
" Delete Trailing Whitespaces On Saving:
func! DeleteTrailingWhiteSpace()
  normal mZ
  %s/\s\+$//e
  normal `Z
endfunc
au BufWrite * if &ft != 'mkd' && &ft != 'tex' | call DeleteTrailingWhiteSpace() | endif

" ---------------------------------------------------------------------
" Log For Debugging Vimscript:
func! ToggleVerbose()
  if !&verbose
    exe "!rm /tmp/vimlog"
    set verbosefile=/tmp/vimlog
    set verbose=10
  else | set verbose=0 | set verbosefile= | endif
endfunc
nmap <Leader>tv :call ToggleVerbose()<CR>

" ---------------------------------------------------------------------
" Diff Current Buffer With Correspondent Saved File:
func! DiffWithSaved()
  let ft=&filetype
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . ft
endfunc
command! DiffSaved call DiffWithSaved()
nnoremap <Leader>df :call DiffWithSaved()<CR>

" ---------------------------------------------------------------------f]]
" Open Browser:
func! Browser ()
  let line0 = getline (".")
  let line  = matchstr (line0, "http[^ ,;\t)]*")
  if line==""
    let line = matchstr (line0, "ftp[^ ,;\t)]*")
  endif
  if line==""
    let line = matchstr (line0, "www\.[^ ,;\t)]*")
  endif
  exec "!chromium ".line
  " TODO chrome cannot be run as root
endfunc
nnoremap <Leader>ch :call Browser ()<CR>

" ---------------------------------------------------------------------
" Misc Functions:
" Copy,Backup,Evening,Nowrap,VirtualEdit,Line,Noh,Sync,pagejoin,pageq
nmap <Leader>cp :!xclip -i -selection clipboard % <CR><CR>
nnoremap <Leader>bk :!mkdir -p vim_backup; cp % vim_backup/%_bk --backup=numbered <CR>

nmap <Leader>tw :set wrap!<CR>
nmap <Leader>rd :redraw!<CR>

func! ClearMyHighlight()
  " https://vi.stackexchange.com/questions/3148/what-is-the-functional-difference-between-nohlsearch-and-set-nohlsearch
  call clearmatches()
  if !exists('g:vscode')
    " cause buggy buffer to create in vscode
    return ":let v:hlsearch=0\<CR>:silent! SearchBuffersReset\<CR>"
  else
    return ":let v:hlsearch=0\<CR>:silent! SearchReset\<CR>"
  endif
endfunc
"nnoremap <silent> <Leader>no :noh <CR>:call clearmatches()<CR>:silent! SearchBuffersReset<CR>
nnoremap <expr> <Leader>no ClearMyHighlight()

nnoremap <Leader>sd :! sdcv `echo <cword> \| sed -e 's/[^[:alnum:]]//g'` <CR>

nnoremap <Leader>pj v}Jj0O
nnoremap <leader>pq gqip
nmap <Leader>syn :vsplit<bar>wincmd l<bar>exe "norm! Ljz<c-v><cr>"<cr>:set scb<cr>:wincmd h<cr> :set scb<cr>

nnoremap <Leader>-- o<C-R>=printf('%s%s', printf(&commentstring, ' '), repeat('-', 90))<CR><Home><Esc>

nnoremap <Leader>sH :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" change current line to title case
nnoremap <Leader>tc :s/\<\(\w\)\(\w*\)\>/\u\1\L\2/g

" ---------------------------------------------------------------------f]]
" Completetion And Tags: f[[
set wildmenu                                         " command-line completion
set wildmode=list:longest,full
set wildignore+=*.o,main,*.pyc,*.aux,*.toc,*.bin     " don't add .class for javacomplete searching for Reflection.class
set wildignore+=*.git,*.svn,*.hg
set wildignore+=*.sqlite3
set wildignore+=*~,*.bak,*.sw,*.gif
set completeopt=menu,preview,longest
set complete=.,w,b,u
set path+=./include,                                 " path containing included files for searching variables
" Prevent the first completion result to be chosen, only needed for C++?
inoremap <C-O> <C-X><C-O><C-P>
inoremap <C-P> <C-X><C-P>
set dict+=$HOME/.vim/static/dict_with_cases          " use c-X c-K to open dictionary completion
set tags=.tags
nmap <Leader>tag :!ctags -R -f .tags --c++-kinds=+p --fields=+iaS --extra=+q . <CR><CR>

let g:ycm_global_ycm_extra_conf = $HOME . "/.vim/static/ycm_extra_conf.py"
"let g:ycm_key_detailed_diagnostics = "<Leader>yd"
"let g:ycm_complete_in_comments = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
"let g:ycm_collect_identifiers_from_tags_files = 0    " slow
let g:ycm_confirm_extra_conf = 0
"let g:ycm_cache_omnifunc = 1
"let g:ycm_min_num_identifier_candidate_chars = 3
"nnoremap <leader>jd :YcmCompleter GoTo<CR>

let g:EclimCompletionMethod = 'omnifunc'

let g:sparkup = '~/.vim/bundle/sparkup/sparkup'
let g:sparkupExecuteMapping = '<C-z>'
" <C-n> to jump to next empty tag

let g:clang_format#code_style = 'google'
let g:clang_format#style_options = {
      \ "IndentWidth": "4",
      \ "TabWidth": "4",
      \ "ContinuationIndentWidth": "2",
      \ "BinPackParameters": "false",
      \ "IndentCaseLabels": "true",
      \ "PenaltyExcessCharacter": "1000",
      \ "PenaltyReturnTypeOnItsOwnLine": "10",
      \ "Cpp11BracedListStyle": "true",
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AllowShortLoopOnASingleLine" : "true",
            \ "Standard" : "C++11" }

set statusline+=%#warningmsg#
set statusline+=%*

let g:ale_linters_explicit = 1
let g:ale_linters = {'python': ['flake8']}
let g:ale_fixers = {'python': ['black']}

" ---------------------------------------------------------------------f]]
" Set Title:        " TODO for normal type of file f[[
let g:custom_head_list = [" File:"]
func! GenerateHead(line)
  call append(a:line, g:custom_head_list)
  " comment
  normal ggVG cl
  silent! exec "%s/^ \\+//g"
endfunc
func! SetTitle()
  let file_name = expand("%:t")
  let file_head = expand("%:t:r")
  if &ft == 'sh'
    call setline(1, "!/bin/bash -e")
    call GenerateHead(1)
    normal G
  elseif file_name =~ "^[^.]*\.hh*[px]*$"
    call GenerateHead(0)
    call append(line("$"), ["#pragma once", ""])
    normal G
  elseif &ft == 'cpp'
    call GenerateHead(0)
    call append(line("$"), ["#include <iostream>","#include <cstring>","#include <cstdio>",
          \ "#include <limits>","#include <vector>", "#include <unordered_map>", "#include <set>",
          \ "#include <iterator>", "#include <unordered_set>", "#include <queue>", "using namespace std;",
          \ "#define MSET(ARR, x) memset(ARR, x, sizeof(ARR))",
          \ "#define REP(x, y) for (auto x = decltype(y){0}; x < (y); x ++)",
          \ "#define REPL(x, y, z) for (auto x = decltype(z){y}; x < (z); x ++)",
          \ "#define REPD(x, y, z) for (auto x = decltype(z){y}; x >= (z); x --)",
          \ "#define P(a) std::cout << (a) << std::endl",
          \ "#define PP(a) std::cout << #a << \": \" << (a) << std::endl",
          \ "#define PA(arr) \\", "  do { \\", "    std::cout << #arr << \": \"; \\",
          \ "    std::copy(begin(arr), end(arr), std::ostream_iterator<std::remove_reference<decltype(arr)>::type::value_type>(std::cout, \" \")); \\",
          \ "    std::cout << std::endl;  \\",
          \ "  } while (0)" ])
    normal G
  elseif &ft == 'ruby'
    0put=\"!/usr/bin/env ruby\<nl> coding: utf-8\"
    call GenerateHead(2)
    normal G
  "elseif &ft == 'html'
    "call setline(1, "html:5")
    "normal $
    "call feedkeys("\<C-z>")                                " call sparkup
  elseif &ft == 'java'
    call GenerateHead(0)
    call append(line("$"), ["public class ". file_head . " {", "\tpublic static void main(String[] args) {", "\t}", "}"])
    normal jjj
  elseif &ft == 'tex' || &ft == 'javascript' || &ft == 'coffee'
    call GenerateHead(0)
    normal G
  endif
endfunc
au BufNewFile *.* call SetTitle()
au BufNewFile Makefile exec ":r ~/Work/projects/image_stitching/src/Makefile"

" ---------------------------------------------------------------------f]]
" Make For Programming: f[[
"for gprof
command! -nargs=* Makepg call Make_arg("g++ % -o %:r -pg -Wall -std=c++11", <f-args>)

func! Make()                        " silent make with quickfix window popup
  make
  redraw!
  for i in getqflist()
    if i['valid']
      cwin | winc p | return
    endif
  endfor
endfunc

au Filetype gnuplot let &makeprg="gnuplot % ; feh ./*"
au Filetype dot let &makeprg="dot -Tpng -O -v % ; feh %.png"
au Filetype php let &makeprg="php %"
au Filetype r let &makeprg="R <% --vanilla"
au Filetype sh let &makeprg="shellcheck -f gcc %"
if !exists('g:vscode')
func! InstantRun()
  if &ft == 'python'
    if matchstr(getline(1), 'python2') == ""
      :!python %
    else | :!python2 %
    endif
  elseif &ft == 'ruby' | :!ruby %
  elseif &ft == 'sh' | :!bash %
  elseif &ft == 'cpp' | :!gdb %<
  elseif &ft == 'java' | :! java %<
  elseif &ft == 'javascript' | :! node %
  elseif &ft == 'coffee' | :! coffee %
  elseif &ft == 'haskell' | :! runhaskell %
  else | call Make() | endif
endfunc
nnoremap <Leader>rr :call InstantRun() <CR>
endif
nnoremap <Leader>mk :call Make()<CR>
nnoremap <Leader>mr :!make run <CR>
" --------------------------------------------------------------------- f]]

" Mapping For Programming: (These should've been moved to ftplugin) f[[
func! Tex_Block(label)
  let Blk_Dict={"e": "enumerate","d": "description", "m": "matrix", "c": "cases",
        \ "f": "figure", "t": "table", "tt": "tabular", "eq": "equation*", "mp": "minipage"}
  let blk_text = (has_key(Blk_Dict, a:label)) ? Blk_Dict[a:label ] : a:label
  call append(line('.') - 1,["\\begin{". blk_text ."}","","\\end{". blk_text ."}"])
  normal kk
  startinsert
endfunc
func! Tex_Formula_init()
  inoremap <buffer> <c-f> \dfrac{}{}<Esc>2hi
  inoremap <buffer> <Leader>bf \mathbf{}<Left>
  inoremap <buffer> <c-r> \sqrt{}<Left>
  inoremap <buffer> <c-Left> \Leftrightarrow<Space>
  inoremap <buffer> <c-Right> \Rightarrow<Space>
  inoremap <buffer> \left \left<Space>\right<Esc>5hi

  " Symbol:
  inoremap <buffer> `a \alpha
  inoremap <buffer> `b \beta
  inoremap <buffer> `c ^\circ
  inoremap <buffer> `D \Delta
  inoremap <buffer> `d \mathrm{d}
  inoremap <buffer> `G \Gamma
  inoremap <buffer> `l \lambda
  inoremap <buffer> `m \mu
  inoremap <buffer> `O \Omega
  inoremap <buffer> `o \omega
  inoremap <buffer> `p \pi
  inoremap <buffer> `r \rho
  inoremap <buffer> `t \theta
  inoremap <buffer> `R \mathbb{R}
  inoremap <buffer> `s \sigma
  inoremap <buffer> `v \varphi
endfunc
func! Tex_init()
  setl nocursorline                                " for performance
  hi clear Conceal
  let &conceallevel=has("gui_running") ? 1: 2        " conceal problem for gvim
  set concealcursor=
  setl expandtab
  setl textwidth=99999
  set makeef=/dev/null

  inoremap <buffer> $$ $<Space>$<Left>
  inoremap <buffer> " ``''<Left><Left>
  nmap <buffer> <Leader>" xi``<Esc>,f"axi''<Esc>
  inoremap <buffer> ... \cdots<Space>
  call Tex_Formula_init()

  inoremap <buffer> \[ \[<Space>\]<Left><Left>
  inoremap <buffer> \{ \{<Space>\}<Left><Left>
  inoremap <buffer> \langle \langle<Space><Space>\rangle<Esc>7hi
  inoremap <buffer> \verb \verb<Bar><Bar><Left>
  inoremap <buffer> \beg \begin{}<Left>
  inoremap <buffer> \bb <Esc>:call Tex_Block("")<Left><Left>
  inoremap <buffer> \bbt <Esc>:call Tex_Block("t")<CR><Up><End>[H]<Down>\centering<CR>\caption{\label{tab:}}<Esc>k:call Tex_Block("tabular")<CR>
  inoremap <buffer> \bbf <Esc>:call Tex_Block("f")<CR><Up><End>[H]<Down>\centering<CR>\includegraphics[width=0.8\textwidth]{res/}<CR>\caption{\label{fig:}}<Esc>
  inoremap <buffer> \bbm <Esc>:call Tex_Block("mp")<CR><Up><End>[b]{0.46\linewidth}<Down>\centering<CR>\includegraphics[width=\textwidth]{res/}<CR>\caption{\label{fig:}}<Esc>
  inoremap <buffer> \bmb \begin{bmatrix}\end{bmatrix}<Esc>12hi
  inoremap <buffer> \bf \textbf{}<Left>
  xmap <buffer> \ve s\|i\verb<BS><Del><Esc>
  xmap <buffer> \bbe di\bbe<CR><Tab><Esc>pj
  xmap <buffer> \bbd di\bbd<CR><Tab><Esc>pj
  xmap <buffer> \bf s}i\textbf<Esc>
  xmap <buffer> \em s}i\emph<Esc>
  xmap <buffer> <Leader>tab :s/\s\+/ \&/g<CR>gv:s/$/\\\\/g<CR>gv<Space>tt

  " Plugin: LaTeX-Box
  let g:LatexBox_no_mappings = 1
  inoremap <buffer> [[ \begin{}<Left>
  imap <buffer> ]] <Plug>LatexCloseCurEnv
  inoremap <buffer> <C-n> <Esc><Right>:call LatexBox_JumpToNextBraces(0)<CR>i
  nmap <buffer> P l:call LatexBox_JumpToNextBraces(0)<CR>
  nmap <buffer> Q :call LatexBox_JumpToNextBraces(1)<CR>

  xmap <buffer> ie <Plug>LatexBox_SelectCurrentEnvInner
  xmap <buffer> ae <Plug>LatexBox_SelectCurrentEnvOuter
  omap <buffer> ie :normal vie<CR>
  omap <buffer> ae :normal vae<CR>
  xmap <buffer> im <Plug>LatexBox_SelectInlineMathInner
  xmap <buffer> am <Plug>LatexBox_SelectInlineMathOuter
  omap <buffer> im :normal vim<CR>
  omap <buffer> am :normal vam<CR>

  nmap <buffer> <Leader>ce <Plug>LatexChangeEnv
  xmap <buffer> <Leader>tc <Plug>LatexWrapSelection
  xmap <buffer> <Leader>te <Plug>LatexEnvWrapSelection

  func! ToMatrix()
python << EOF
import vim, re
buf = vim.current.buffer
(lnum1, col1) = buf.mark('<')
(lnum2, col2) = buf.mark('>')
lines = vim.eval('getline({}, {})'.format(lnum1, lnum2))
lines = [re.sub(' +', '&  ', x.strip()) + '\\\\' for x in lines]
#lines.insert(0, '\\begin{bmatrix}')
#lines.append('\\end{bmatrix}')
buf[lnum1-1:lnum2] = lines
EOF
  endfunc
  vnoremap <buffer> <Leader>M :<C-w>call ToMatrix()<CR>

endfunc
func! C_grammar_init()
  inoremap <buffer> while<Space> while<Space>()<Left>
  inoremap <buffer> {{ {}<Left><CR><CR><Up><Tab>
  inoremap <buffer> if<Space> if<Space>()<Left>
  inoremap <buffer> for<Space> for<Space>()<Left>
  "command! INDENT :!indent -linux -l80 -brf %
  "nnoremap <Leader>id :w<CR>:INDENT<CR><CR>:e<CR>
endfunc
func! Cpp_init()
  iabbr #i #include
  iabbr #I #include
  "set expandtab
  set syntax=cpp11.doxygen
  setl ts=2 sw=2 sts=2 expandtab

  let &makeprg="clang++ % -g -Wall -Wextra -O0 -std=c++11 -o %<"
  if filereadable(getcwd() . "/Makefile")
    let &makeprg="make"
  elseif  filereadable(getcwd() . "/../Makefile")
    let &makeprg="make -C .."
  endif

  call C_grammar_init()
  syn keyword cppType real_t Vec Vec2D Vector Matrix Plane Sphere Geometry Ray Color Img imgptr PII PDB PDD PDI PID PIF
  syn keyword cppSTLType T
endfunc
func! Matlab_init()
  inoremap <buffer> if<Space> if<Space><CR>end<Up>
  inoremap <buffer> for<Space> for<Space><CR>end<Up><End>
  inoremap <buffer> func<Space> function<Space><CR>end<Up><End>
endfunc
func! Python_init()
  let &makeprg="pylint --reports=n --output-format=parseable %"
  setl expandtab
  setl ts=4 sw=4 sts=4
  setl textwidth=78
  iabbr ipeb import IPython as IP; IP.embed()
  syn keyword pythonDecorator self
  nmap <buffer> <F8> :ALEFix<CR>
endfunc
func! Ruby_init()
  let &makeprg="ruby -c %"
  imap <C-CR> <CR><CR>end<Esc>-cc
  setl expandtab
  setl ts=2 sw=2 sts=2
  iabbr ipeb require 'pry'; binding.pry
endfunc
func! Java_init()
  let &makeprg="javac %"
  syn keyword javaType String Integer Double Pair Collection Collections List Boolean Triple ArrayList Entry LinkedList Map HashMap Set HashSet TreeSet TreeMap Iterator Iterable Comparator Arrays ListIterator Vector File Character Object Exception Random
  " TODO match java class name with regex
  let java_comment_strings = 1
  let java_mark_braces_in_parens_as_errors= 1
  let java_ignore_javadoc = 1
  let java_minlines = 150
  call C_grammar_init()
endfunc
func! CS_init()
  call C_grammar_init()
  syn keyword csType var
endfunc
func! Js_init()
  let &makeprg="node %"
  setl ts=2 sw=2 sts=2
  call C_grammar_init()
endfunc
func! MarkDown_init()
  " call Tex_Formula_init()
  setl expandtab
  set ofu=
  set nofoldenable
  inoremap {% {%  %}<Left><Left>
  inoremap ``` ```<CR>```<Up><End><Esc>
  " surround with link
  xmap <Leader>l s]%a()
  " emphasis
  xmap <Leader>e s*gvs*
endfunc
func! Lua_init()
  set makeef=/dev/null
  let &makeprg="lua %"
  setl expandtab
  setl ts=2 sw=2 sts=2
  iabbr ipeb require("fb.debugger").enter()
endfunc
" pdf auto refresh preview
if has('nvim')
  au BufWritePost *.tex call jobstart("make try")
endif
au FileType tex :call Tex_init()
au FileType markdown :call MarkDown_init()
au FileType cpp :call Cpp_init()
au FileType matlab :call Matlab_init()
au FileType cs :call CS_init()
au FileType python :call Python_init()
au FileType ruby :call Ruby_init()
au FileType java :call Java_init()
au FileType javascript :call Js_init()
au FileType r,c :call C_grammar_init()
au FileType lua :call Lua_init()

" ---------------------------------------------------------------------f]]
" FileType Commands:
au BufRead *.conf setf conf
au BufWritePost .Xresources silent !xrdb %
au BufWritePost .tmux.conf silent !tmux source %
au BufWritePost .xbindkeysrc silent !bash -c 'killall xbindkeys; sleep 0.5; xbindkeys'
au BufRead tmux.conf,.tmux* setf tmux
au BufRead /usr/include/* setf cpp
au BufRead SConstruct setf python
au BufRead TARGETS,WORKSPACE setf syntax=python | set expandtab
au BufNewFile,BufRead config.fish set ft=sh               " syntax for fish config file
au BufNewFile,BufRead *.json setl ft=json syntax=txt
au BufNewFile,BufRead /tmp/dir*,/tmp/tmp* setf txt           " for vidir / vimv
au BufWritePost,BufWrite __doc__ setf txt
au BufNewFile,BufRead *.mako setf mako
au BufNewFile,BufRead *.g,*.y,*.ypp setl syntax=antlr3         " syntax for CFG
au BufNewFile,BufRead *.ejs set syntax=html ft=html
au BufNewFile,BufRead *.ispc set syntax=cpp
au BufNewFile,BufRead *.gprof setf gprof
au BufNewFile,BufRead *.txt,*.doc,*.pdf setf txt
au BufReadPre *.doc,*.class,*.pdf setl ro
au BufReadPost *.doc silent %!antiword "%"
au BufReadPost *.pdf silent %!pdftotext -nopgbrk "%" -
au BufRead *.class exe 'silent %!javap -c "%"' | setf java
au BufNewFile,BufRead *.lrc setf lrc
au Filetype lrc :match Underlined /.\%45v.\+/
au Filetype lrc setl textwidth=45                                  " for display in iphone
au Filetype coffee setl omnifunc=nodejscomplete#CompleteJS
au Filetype coffee,jade,stylus,javascript,html,css,yaml,typescript,vim,json,javascriptreact setl expandtab
au BufNewFile,BufRead *.hwdb setl expandtab
au FileType json setl foldmethod=syntax
au Filetype txt,crontab setl textwidth=500
let g:tex_flavor = 'latex'                                         " default filetype for tex
au FileType sh,zsh inoremap ` ``<Left>
au FileType sh,zsh setl expandtab
au BufNewFile,BufRead *.elv setl ft=zsh syntax=zsh
au BufWritePost *
      \ if getline(1) =~ "^#!/bin/[a-z]*sh" |
      \   exe "silent !chmod a+x <afile>" |
      \ endif


" ---------------------------------------------------------------------
" Misc Plugins: f[[
" :ColorSchemeExplorer to use colorschemeexplorer
" <Leader>mar to mark
" surround: ds/cs in normal mode, s in visual mode
" :I in block-visual mode to use VisIncr
" <Leader>tt to Align latex table
" <Leader>t=  <Leader>T=  to Align = (left or right)
" <Leader>z/Z/iz to fold/restore/reverse_fold search result
" Tyank, Twrite, Tput to use tbone for tmux
" {count}zS to show highlight
nnoremap md :LivedownToggle<CR>
" <leader>gO to open github repo
let g:gh_line_map = '<Leader>gC'
au BufEnter *.cpp let b:fswitchdst = 'hh,h' | let b:fswitchlocs = './,./include,../include'
au BufEnter *.cc let b:fswitchdst = 'hh,h' | let b:fswitchlocs = './include,./,../include'
au BufEnter *.hh let b:fswitchdst = 'cc,cpp' | let b:fswitchlocs = './,../'
au BufEnter *.h let b:fswitchdst = 'cc,cpp' | let b:fswitchlocs = './,../'
command! A FSHere
command! AV FSSplitRight

if !exists('g:vscode') && has('nvim')
lua require'hop'.setup { keys = 'etovxqpdygfblzhckisuran', jump_on_sole_occurrence = false }
nnoremap ,w :HopWord<CR>
endif

xmap s <Plug>VSurround
let g:html_indent_inctags = "body,head,tbody"

let g:NERDCreateDefaultMappings = 0
nmap <Leader>cc <Plug>NERDCommenterSexy
xmap <Leader>cc <Plug>NERDCommenterSexy
nmap <Leader>cl <Plug>NERDCommenterAlignLeft
xmap <Leader>cl <Plug>NERDCommenterAlignLeft
nmap <Leader>uc <Plug>NERDCommenterUncomment
xmap <Leader>uc <Plug>NERDCommenterUncomment

if exists("*expand_region#custom_text_objects")
  call expand_region#custom_text_objects({
        \ "\/\\n\\n\<CR>": 1,
        \ 'a]' :1, 'ab' :1, 'aB' :1, 'a"' :1, 'a''': 1,
        \ 'ii' :0, 'ai' :0,
        \ 'ic' :0, 'ac' :0, })
endif
xmap L <Plug>(expand_region_expand)
xmap H <Plug>(expand_region_shrink)

" Use * to Multiple Search word under cusor
nnoremap <silent> * :execute ':Search \<' . expand('<cword>') . '\>'<cr>
if !exists('g:vscode') && !has('nvim')
  nnoremap <Leader>/ :Search<Space>
endif
let g:MultipleSearchMaxColors = 16

if has('nvim') && !exists('g:vscode')
  nnoremap <C-P> <cmd>lua require('telescope.builtin').find_files{prompt_prefix='🔍'}<cr>
  nnoremap <leader>/ <cmd>lua require('telescope.builtin').live_grep{prompt_prefix='🔍'}<cr>
  nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers{prompt_prefix='🔍'}<cr>
  nnoremap <leader>fr <cmd>lua require('telescope.builtin').oldfiles{prompt_prefix='🔍'}<cr>
  nnoremap <leader>ft <cmd>lua require('telescope.builtin').treesitter{prompt_prefix='🔍'}<cr>
  lua << EOF
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-s>"] = "file_split",
        ["<Esc>"] = "close",
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      }
    }
  },
}
EOF
elseif !exists('g:vscode')
  nmap <Leader>fr :CtrlPMRU<CR>
  nmap <Leader>fb :CtrlPBuffer<CR>
  nmap <Leader>ff :CtrlP .<CR>
  nmap <Leader>px :CtrlPClearAllCaches<CR>
  let g:ctrlp_cache_dir = $HOME . '/.vimtmp/ctrlp'
  if executable('ag')
    " avoid mistakenly execution on my home directory
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g "" --ignore-dir={node_modules,site-packages,dist-packages,Document,Documents,Work}'
  endif
   let g:ctrlp_prompt_mappings = {
      \ 'AcceptSelection("h")': ['<c-x>', '<c-cr>', '<c-s>'],
      \ 'AcceptSelection("v")': ['<c-v>', '<RightMouse>'],
      \ 'PtrCurRight()': ['<right>'],
      \ }
endif

func! RangerChooser()
  let arg0 = has('gui_running') ? "urxvt -e " : " "
  exec "silent !" . arg0 . " ranger --choosefile=/tmp/chosenfile " . expand("%:p:h")
  if filereadable('/tmp/chosenfile')
    exec 'edit ' . system('cat /tmp/chosenfile')
    call system('rm /tmp/chosenfile')
  endif
  redraw!
endfunc

" f]]
" UI And Format Plugin: f[[
" highlight words under cursor
let g:matchmaker_enable_startup = 1

if ! has('gui_running')            " to cooperate with gvim_color_css
  let g:rbpt_max            = 16
  let g:rbpt_loadcmd_toggle = 0
  au VimEnter * silent! RainbowParenthesesToggle
  au Syntax * silent! RainbowParenthesesLoadRound
  au Syntax * silent! RainbowParenthesesLoadSquare
  " to work with css3-syntax
  au Syntax * if &ft != "css" | silent! RainbowParenthesesLoadBraces | endif
  let g:rbpt_colorpairs = [['brown', 'RoyalBlue3'], ['Darkblue', 'SeaGreen3'],
        \ ['darkgray', 'DarkOrchid3'], ['darkgreen', 'firebrick3'], ['darkcyan', 'RoyalBlue3'],
        \ ['darkred', 'SeaGreen3'], ['darkmagenta', 'DarkOrchid3'], ['brown', 'firebrick3'],
        \ ['gray', 'RoyalBlue3'], ['darkmagenta', 'DarkOrchid3'], ['darkred', 'DarkOrchid3'],
        \ ['Darkblue', 'firebrick3'], ['darkgreen', 'RoyalBlue3'], ['darkcyan', 'SeaGreen3']]
endif

nmap <Leader>xml :%s/></>\r</g<CR>gg=G
" vim-jsbeautify
nmap <Leader>js :call JsBeautify()<CR>:set ft=js<CR>
nmap <Leader>css :call CSSBeautify()<CR>
nmap <Leader>html :call HtmlBeautify()<CR>
let s:rootDir           = fnamemodify(expand("<sfile>"), ":h")
let g:jsbeautify_file   = fnameescape(s:rootDir."/.vim/bundle/js-beautify/beautify.js")
let g:htmlbeautify_file = fnameescape(s:rootDir."/.vim/bundle/js-beautify/beautify-html.js")
let g:cssbeautify_file  = fnameescape(s:rootDir."/.vim/bundle/js-beautify/beautify-css.js")

let g:indentLine_enabled = 0
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#A4E57E'
" toggle indent
nnoremap <leader>ti :IndentLinesToggle<CR>:set list! lcs=tab:\\|\<Space><CR>
" f]]

" Window Plugins: f[[
let g:win_width = 22
if 0  " https://github.com/stevearc/aerial.nvim/issues/81
lua << EOF
require('aerial').setup({max_width = {30, 0.2}})
EOF
  nmap <Leader>tl :AerialToggle<CR>
else
  nmap <Leader>tl :TagbarToggle<CR>
  let g:tagbar_width = g:win_width
  let g:tagbar_autofocus = 1
  let g:tagbar_indent = 1
endif

" toggle file
if has('nvim')
  lua << EOF
require("nvim-tree").setup({
  view = {
    width = 25,
    mappings = { list = {
      { key = "l", action = "edit" },
      { key = "h", action = "close_node" },
    }}
  }
})
-- https://github.com/kyazdani42/nvim-tree.lua/discussions/1115
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
      vim.cmd "quit"
    end
  end
})
EOF
  nmap <Leader>fm :NvimTreeToggle <CR>
else
  nmap <Leader>fm :NERDTreeToggle <CR>
  let g:NERDTreeWinSize       = g:win_width
  let g:NERDTreeShowBookmarks = 1
  let g:NERDTreeBookmarksFile = '~/.vim/NERDTreeBookmarks'
  let g:NERDTreeHijackNetrw   = 0
  let NERDTreeIgnore          = ['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
endif

nmap <Leader>ut :GundoToggle<CR>
let g:gundo_width = g:win_width
let g:gundo_preview_bottom = 1

let g:pydoc_open_cmd = 'vsplit'
let g:pydoc_cmd = '/usr/bin/pydoc'
let g:pydoc_highlight = 0                             " don't highlight searching word

" <LocalLeader>r to refresh output window
nnoremap ! :Clam<space>
vnoremap ! :ClamVisual<space>

" Use `:ScreenShell ipython` to open a parallel python shell
let g:ScreenImpl = 'Tmux'
let g:ScreenShellHeight = 20
let g:ScreenShellTerminal = g:my_term
nnoremap <LocalLeader>se :ScreenSend<CR>

" local vimrc overwrite the global one
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

if has('nvim')
    tnoremap <Esc> <C-\><C-n>
endif

" VSCode specifics:
if exists('g:vscode')
  let g:python_recommended_style = 0  " https://github.com/asvetliakov/vscode-neovim/issues/152
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

  au FileType python nnoremap <Leader>rr :call VSCodeNotify('python.execInTerminal')<CR>
endif
