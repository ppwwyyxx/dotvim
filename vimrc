" Author: Yuxin Wu

set nocompatible                    " Use Vim Settings (Not Vi). This must be first, because it changes other options as a side effect.
" Needs to be set before lazy.
let mapleader=" "
let maplocalleader=","
if has('nvim') " Plugins for neovim: f[[
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

-- UI And Basic:
if not vim.g.vscode then
  -- https://github.com/Yggdroot/indentLine/issues/345
  use 'folke/tokyonight.nvim'
  use {'Yggdroot/indentLine', config = function()
    vim.g.indentLine_enabled = 0
    vim.g.indentLine_color_term = 239
    vim.g.indentLine_color_gui = '#A4E57E'
  end }
  use 'vim-scripts/searchfold.vim'
  use 'vim-scripts/LargeFile'
  use {'folke/which-key.nvim', branch = 'main'}
  use {'lambdalisue/suda.vim', cmd = 'SudaWrite'}
  use 'nvim-lualine/lualine.nvim'
  -- https://github.com/folke/lazy.nvim/issues/389
  use {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', event = "BufReadPost",
    opts = {
      -- Do not enable for comment
      ensure_installed = { 'bash', 'c', 'cmake', 'cpp', 'cuda', 'glsl', 'css', 'html', 'javascript', 'json', 'lua', 'make', 'markdown', 'ninja', 'proto', 'python', 'scss', 'typescript', 'vim', 'yaml' },
      highlight = { enable = true, },
    },
    config = function(p, opts) require("nvim-treesitter.configs").setup(opts) end,
  }
  use {'nvim-treesitter/playground', cmd = 'TSHighlightCapturesUnderCursor'}
  use {'dstein64/vim-startuptime', cmd = 'StartupTime'}
end
use 'vim-scripts/MultipleSearch'
use 'ppwwyyxx/vim-PinyinSearch'

-- Window Tools:
if not vim.g.vscode then
  use {'mbbill/undotree', cmd = 'UndotreeToggle'}
  use 'nvim-lua/plenary.nvim'
  use {'nvim-telescope/telescope.nvim', lazy = true, opts = {
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
    config = function(p, opts) 
      require('telescope').setup(opts)
      require('telescope').load_extension('fzf')
    end
  }}
  use {'nvim-telescope/telescope-fzf-native.nvim', build = 'make', branch = 'main', lazy = true }
  use {'nvim-tree/nvim-tree.lua', dependencies = 'nvim-tree/nvim-web-devicons'}
  use {'preservim/tagbar', cmd = 'TagbarToggle'}
end

-- Editing Tools:
use 'rhysd/accelerated-jk'
use 'yonchu/accelerated-smooth-scroll'
use {'tsaleh/vim-align', cmd = {'Align', 'AlignCtrl'} }
use 'tpope/vim-surround'
use 'terryma/vim-expand-region'
if not vim.g.vscode then
  use {'phaazon/hop.nvim',
    opts = { keys = 'etovxqpdygfblzhckisuran', jump_on_sole_occurrence = false },
    keys = {{',w', ':HopWord<cr>', mode='n'}}
  }
  use {'ojroques/vim-oscyank', branch = 'main'}
  -- highlight words under cursor, causes ghost in vscode
  vim.g.matchmaker_enable_startup = 1
  use {'qstrahl/vim-matchmaker'} -- delay loading so it can read the config
end
use 'scrooloose/nerdcommenter'
use {'glts/vim-textobj-comment', dependencies = 'kana/vim-textobj-user'}
use {'kana/vim-textobj-indent', dependencies = 'kana/vim-textobj-user'}
use 'jeetsukumaran/vim-indentwise'

-- Programming:
if not vim.g.vscode then
  use 'ruanyl/vim-gh-line'
  use {'LaTeX-Box-Team/LaTeX-Box', ft = 'tex'}
  use {'derekwyatt/vim-fswitch', ft = {'cpp', 'c'}}
  use {'shime/vim-livedown', ft = 'markdown'}
  use 'neomake/neomake'
  vim.g.gitgutter_sign_modified_removed = '~'
  use 'airblade/vim-gitgutter'
  use {'wakatime/vim-wakatime', cond = vim.fn.filereadable(vim.fn.expand('$HOME/.wakatime.cfg')) == 1 }
  use {'github/copilot.vim', cmd = 'Copilot'}
  -- LSP:
  use 'neovim/nvim-lspconfig'
  use 'folke/lsp-colors.nvim'
  --use 'onsails/lspkind.nvim'
  use { "SmiteshP/nvim-navic", 
    requires = "neovim/nvim-lspconfig",
    opts = { separator = "  " }
  }

  use {'folke/trouble.nvim', lazy = true, dependencies = 'nvim-tree/nvim-web-devicons', opts = {        
    action_keys = {                                                                                     
      open_split = { "<c-s>" }, -- open buffer in new split                                             
      open_tab = {},                                                                                    
    },                                                                                                  
    auto_close = true, -- automatically close the list when you have no diagnostics                     
    use_diagnostic_signs =true, -- enabling this will use the signs defined in your lsp client          
  }, cmd = {'Trouble', 'TroubleToggle'}}                                                                

  -- Syntax:
  use 'dense-analysis/ale'
  use 'vim-scripts/gprof.vim'
  use {'smilekzs/vim-coffee-script', ft = 'coffee'}
  use {'chrisbra/csv.vim', ft = 'csv'}
  use {'digitaltoad/vim-jade', ft = 'jade'}
  use {'maksimr/vim-jsbeautify', ft = {'html', 'javascript', 'css', 'json'}}
  use {'pangloss/vim-javascript', ft = 'javascript'}
  use {'groenewege/vim-less', ft = 'less'}
  use {'fs111/pydoc.vim', ft = 'python'}
  use 'ujihisa/rdoc.vim'
  use {'slim-template/vim-slim', ft = 'slim'}
  use {'wavded/vim-stylus', ft = 'stylus'}
  use {'jeroenbourgois/vim-actionscript', ft = 'actionscript'}
end
if vim.fn.filereadable(vim.fn.stdpath("config") .. "/lua/local_plugin.lua") == 1 then
  use {import = 'local_plugin'}
end
require("lazy").setup(plugins, {
  root = vim.fn.stdpath("config") .. "/bundle"
})

EOF
else  " f]]
" Plugins for pure vim: f[[
syntax on
filetype off            " for vundle
call plug#begin('~/.vim/bundle')
" UI And Basic:
Plug 'vim-scripts/LargeFile'
Plug 'vim-scripts/sudo.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ppwwyyxx/vim-PinyinSearch'

" Window Tools:
Plug 'mbbill/undotree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'preservim/tagbar'

" Editing Tools:
Plug 'rhysd/accelerated-jk'
Plug 'yonchu/accelerated-smooth-scroll'
Plug 'ojroques/vim-oscyank', {'branch': 'main'}
Plug 'qstrahl/vim-matchmaker'
Plug 'scrooloose/nerdcommenter'
" Programming:
Plug 'ruanyl/vim-gh-line'
Plug 'derekwyatt/vim-fswitch', {'for': [ 'cpp', 'c' ] }
Plug 'neomake/neomake'
Plug 'airblade/vim-gitgutter'
Plug 'wakatime/vim-wakatime'
" Syntax:
Plug 'dense-analysis/ale'
call plug#end()
filetype plugin indent on
endif "f]]

" Environment: f[[
if exists('$TMUX')                 " fix keymap under screen
    " tmux will send xterm-style keys when its xterm-keys option is on
    exec "set <xUp>=\e[1;*A"
    exec "set <xDown>=\e[1;*B"
    exec "set <xRight>=\e[1;*C"
    exec "set <xLeft>=\e[1;*D"
endif

set shell=zsh
let g:my_term = 'alacritty'                " for plugins to open window
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
"set lazyredraw
" --------------------------------------------------------------------- f]]
" UI: f[[
set background=light
set title
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)

colo default
if has("nvim") | set termguicolors | else
  " https://github.com/vim/vim/issues/993#issuecomment-255651605
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
if !exists('g:vscode')
  set guicursor=    " neovim mess up with terminal cursor
  if has("nvim")
    set guifont=Monospace:h18
  else
    set guifont=Monospace\ 16
  endif
  set guioptions=aegi                " cleaner gui
endif
if has("gui_running") || exists('g:neovide')   " for gvim/neovide
  colo codedark
  cnoremap <C-S-v> <C-r>*
endif
set t_Co=256
au BufEnter * if &buftype == "quickfix" | syn match Error "error:" | endif
hi Matchmaker guibg=#444444
hi Folded guibg=#444444 guifg=lightblue
hi Search ctermfg=red ctermbg=cyan guibg=#8ca509
hi Visual ctermbg=81 ctermfg=black cterm=none  guibg=#8ae8f6 guifg=black
hi MatchParen ctermbg=yellow ctermfg=black

hi LineNr ctermfg=134 guifg=#d426ff guibg=#24283b
hi VertSplit ctermbg=none ctermfg=55 cterm=none guifg=#65ec9b
hi Pmenu ctermfg=81 ctermbg=16 guibg=NONE guifg=cyan

hi Comment ctermfg=blue guifg=#145ecc
hi String ctermfg=13 guifg=#fd26f8
hi Statement ctermfg=3 gui=none
hi Type gui=none
hi DiffAdd ctermbg=none ctermfg=LightBlue guifg=Green guibg=#2a2a2a
hi DiffDelete guibg=#5a5a5a
hi DiffChange ctermbg=none ctermfg=yellow guifg=orange guibg=#2a2a2a
hi DiffText ctermbg=grey ctermfg=red guifg=#df005f guibg=#0a0a0a
hi gitcommitSummary guifg=white

if has('nvim')
  " treesitter hlgroups:
  hi @variable guifg=white ctermfg=white
  hi @field guifg=white ctermfg=white
  hi link @variable.builtin Special
  hi link @attribute.builtin Special
  au FileType python :hi link @constructor @function  " cannot distinguish

  for group in ["SignColumn", "DiagnosticSignError", "DiagnosticSignWarn", "DiagnosticSignInfo", "DiagnosticSignHint", "GitGutterAdd", "GitGutterChange", "GitGutterDelete"]
    exec "hi" group "guibg=#24283b"
  endfor
  hi DiagnosticSignError guifg=red
  hi DiagnosticSignWarn guifg=orange
  hi DiagnosticSignInfo guifg=lightblue
  hi DiagnosticUnderlineError gui=undercurl
  hi DiagnosticUnderlineWarn gui=undercurl
  hi link ALEErrorSign DiagnosticSignError
  hi link ALEWarningSign DiagnosticSignWarn
  lua << EOF
  -- https://github.com/neovim/neovim/issues/14295#issuecomment-950037927
  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end
EOF
  hi GitGutterDelete guifg=red
  hi GitGutterAdd guifg=green
  hi GitGutterChange guifg=orange
  let g:ale_sign_error = ''
  let g:ale_sign_warning = ''
else
  hi clear ALEError
  hi clear ALEWarning
endif


" Highlight Class and Function names
if !exists('g:vscode')
func! HighlightClasses()
  syn match cCustomClass     "\w\+\s*\(::\)\@="
  hi def link cCustomClass     cppType
endfunc
au syntax c,cpp call HighlightClasses()

" Spell Check:
set spellfile=~/.vim/static/spell.utf-8.add
hi SpellCap guisp=yellow
let g:tex_conceal='adgmb'
endif  " vscode

set mouse=a
set showcmd                            " display incomplete commands right_bottom
set numberwidth=1
if !exists('g:vscode')
set relativenumber
set number
set signcolumn=number
set ruler
set rulerformat=%35(%=%r%Y\|%{&ff}\|%{strlen(&fenc)?&fenc:'none'}\ %m\ %l/%L%)
set laststatus=2
set expandtab
set noshowmode

if has('nvim')
  set cmdheight=0
  lua << END
  local theme = require'lualine.themes.powerline_dark'
  theme.inactive.c.fg = theme.normal.c.fg
  theme.inactive.c.bg = theme.normal.c.bg
  local navic = require("nvim-navic")
  local filenamefmt = function(str)
    -- shorten the path
    local idx = str:find('/google3/')
    if idx ~= nil then str = str:sub(idx + 9) end
    local parts = vim.split(str, '[\\/]+', {trimempty = true})
    for i=1,#parts-2 do
      parts[i] = parts[i]:sub(1, 4)
    end
    return table.concat(parts, "/")
  end

  local show_winbar = function()
    -- show only if window is at top
    return navic.is_available() and vim.fn.winnr('1k') == vim.fn.winnr()
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
      {'filename', shorting_target = 0, path = 1, fmt = filenamefmt, symbols = { modified = '+'} },
      {'diagnostics', sources = {'nvim_diagnostic', 'ale'}},
    },
    lualine_x = {'filetype'}, lualine_y = {}, lualine_z = {'location'}
  },
  winbar = {
    lualine_c = {
      {'filename', symbols = { modified = '+'}, cond = show_winbar },
      { navic.get_location, cond = show_winbar },
    },
  },
  inactive_sections = { 
    lualine_c = {
      {'filename', shorting_target = 0, path = 1, fmt = filenamefmt, symbols = { modified = '+'} },
    },
    lualine_x = {'encoding', 'filetype'}, },
}
END
else
  let g:airline_theme='durant'
  let g:airline_mode_map = {'n': 'N', 'i': 'I', 'R': 'R', 'v': 'V', 'V': 'V'}
  let g:airline_left_sep = '»'
  let g:airline_right_sep = '«'
  let g:airline#extensions#whitespace#enabled = 0
  let g:airline#extensions#ale#enabled = 1
endif
endif  " vscode

set scrolljump=5                       " lines to scroll with cursor
set scrolloff=5                        " minimum lines to keep at border
set sidescroll=3
set sidescrolloff=3
set nowrap                             " do not wrap long lines
set whichwrap=b,s,<,>,[,]
"set listchars=nbsp:¬,eol:¶,tab:>-,extends:»,precedes:«,trail:•
set fillchars=vert:\|,fold:-,diff:-
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
set textwidth=0
set tabstop=2 softtabstop=2 shiftwidth=2
set showmatch matchtime=0

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
set timeoutlen=300                     " wait for ambiguous mapping
set ttimeoutlen=0                      " wait for xterm key escape

nnoremap ; :
let g:no_viewdoc_maps = 1  " Disable the builtin mapping
command! -bang -nargs=* Q q<bang>
command! -bang -nargs=* -complete=file W w<bang> <args>
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>
nnoremap <Tab> i<Tab><Esc>
nnoremap <S-Tab> ^i<Tab><Esc>
if !exists('g:vscode')  " cmap slows down vscode
  cnoremap %% <C-R>=expand('%:h').'/'<cr>
  if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    cmap w!! SudaWrite %
  else
    cmap w!! SudoWrite %
  endif
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
if has("gui_running") || exists('g:neovide')   " for gvim/neovide
  xnoremap <c-c> "+y
else
  xnoremap <C-c> :OSCYank<CR>
endif
inoremap <c-v> <Esc>:set paste<CR>"+p:set nopaste<CR>a
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
nnoremap <C-g> <cmd>TroubleToggle loclist<CR>
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
" Hint On Moving Cursor
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
"au CursorMoved,BufWinEnter * call HintCursorLine(1)    " this greatly affects performance ...
"au CursorHold,CursorHoldI,BufLeave,WinLeave * call HintCursorLine(0)
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
" Pinyin
source $HOME/.vim/chinese.vim
nmap <Leader>ps :call PinyinSearch()<CR>
nnoremap ? :call PinyinSearch()<CR>
nmap <Leader>pn :call PinyinNext()<CR>
let g:PinyinSearch_Dict = $HOME . "/.vim/bundle/vim-PinyinSearch/PinyinSearch.dict"

" Delete Trailing Whitespaces On Saving:
func! DeleteTrailingWhiteSpace()
  normal mZ
  %s/\s\+$//e
  normal `Z
endfunc
nnoremap <Leader>ws :call DeleteTrailingWhiteSpace()<CR>

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
  exec "!xdg-open ".line
  " TODO chrome cannot be run as root
endfunc
nnoremap <Leader>ch :call Browser ()<CR>

" ---------------------------------------------------------------------
" Misc Functions:
" Copy,Backup,Evening,Nowrap,VirtualEdit,Line,Noh,Sync,pagejoin,pageq
nmap <Leader>cp :!yank % <CR>
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
nnoremap <expr> <Leader>no ClearMyHighlight()

" Paragraph join
nnoremap <Leader>pj v}Jj0O
nnoremap <leader>pq gqip

nnoremap <Leader>-- o<C-R>=printf('%s%s', printf(&commentstring, ' '), repeat('-', 90))<CR><Home><Esc>
" change current line to title case
nnoremap <Leader>tc :s/\<\(\w\)\(\w*\)\>/\u\1\L\2/g

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
let g:ale_linters = {'python': ['flake8'], 'sh': ['shellcheck']}
let g:ale_fixers = {'python': ['black']}
let g:ale_python_flake8_options = '--max-line-length 120'
let g:ale_python_black_options = '-l 100'

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
au FileType javascript let &makeprg="node %"
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

" ---------------------------------------------------------------------f]]
" Misc FileType Commands:
au BufRead *.conf setf conf
au BufWritePost .Xresources silent !xrdb %
au BufWritePost .tmux.conf silent !tmux source %
au BufWritePost .xbindkeysrc silent !killall -HUP xbindkeys
au BufWritePost *.desktop,mimeapps.list silent !bash -c 'update-mime-database ~/.local/share/mime'
au BufRead tmux.conf,.tmux* setf tmux
au BufRead /usr/include/* setf cpp
au BufRead SConstruct setf python
au BufRead TARGETS,WORKSPACE setf syntax=python
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
au BufNewFile,BufRead *.lrc setf lrc
au BufNewFile,BufRead *.elv setl ft=zsh syntax=zsh
au BufReadPre *.doc,*.class,*.pdf setl ro
au BufReadPost *.doc silent %!antiword "%"
au BufReadPost *.pdf silent %!pdftotext -nopgbrk "%" -
au BufRead *.class exe 'silent %!javap -c "%"' | setf java
au FileType javascript setl ts=2 sw=2 sts=2
au Filetype lrc :match Underlined /.\%45v.\+/
au Filetype lrc setl textwidth=45                                  " for display in iphone
au FileType json setl foldmethod=syntax
au FileType yaml setl foldmethod=indent foldlevel=99 fml=1
au Filetype txt,crontab setl textwidth=500
au FileType sh,zsh inoremap ` ``<Left>
au BufWritePost *
      \ if getline(1) =~ "^#!/bin/[a-z]*sh" |
      \   exe "silent !chmod a+x <afile>" |
      \ endif


" ---------------------------------------------------------------------
" Misc Plugins: f[[
" <Leader>mar to mark
" surround: ds/cs in normal mode, s in visual mode
" <Leader>tt to Align latex table
" <Leader>t=  <Leader>T=  to Align = (left or right)
" <Leader>z/Z/iz to fold/restore/reverse_fold search result
" Tyank, Twrite, Tput to use tbone for tmux
" {count}zS to show highlight
" <leader>gO to open github repo
if !$DISPLAY | let g:gh_open_command = '' | endif
let g:gh_line_map_default = 0  " disable default map
let g:gh_line_map = '<Leader>gC'
au BufEnter *.cpp let b:fswitchdst = 'hh,h' | let b:fswitchlocs = './,./include,../include'
au BufEnter *.cc let b:fswitchdst = 'hh,h' | let b:fswitchlocs = './include,./,../include'
au BufEnter *.hh let b:fswitchdst = 'cc,cpp' | let b:fswitchlocs = './,../'
au BufEnter *.h let b:fswitchdst = 'cc,cpp' | let b:fswitchlocs = './,../'
command! A FSHere
command! AV FSSplitRight

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

" f]]
" UI And Format Plugin: f[[

nmap <Leader>xml :%s/></>\r</g<CR>gg=G
" vim-jsbeautify
nmap <Leader>js :call JsBeautify()<CR>
nmap <Leader>css :call CSSBeautify()<CR>
nmap <Leader>html :call HtmlBeautify()<CR>

" toggle indent
nnoremap <leader>ti :IndentLinesToggle<CR>:set list! lcs=tab:\\|\<Space><CR>
" f]]
" Window Plugins: f[[
let g:win_width = 22
nmap <Leader>tl :TagbarToggle<CR>
let g:tagbar_width = g:win_width
let g:tagbar_autofocus = 1
let g:tagbar_indent = 1

" toggle file
if has('nvim') && !exists('g:vscode')
  lua << EOF
require("nvim-tree").setup({
  view = {
    width = 25,
    mappings = { list = {
      { key = "l", action = "edit" },
      { key = "h", action = "close_node" },
    }}
  },
  renderer = {
    icons = { glyphs = {
      git = { untracked = "" }
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
  hi NvimTreeSymlink gui=none
  nmap <Leader>fm :NvimTreeToggle <CR>
else
  nmap <Leader>fm :NERDTreeToggle <CR>
  let g:NERDTreeWinSize       = g:win_width
  let g:NERDTreeShowBookmarks = 1
  let g:NERDTreeBookmarksFile = '~/.vim/NERDTreeBookmarks'
  let g:NERDTreeHijackNetrw   = 0
  let NERDTreeIgnore          = ['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
endif

nmap <Leader>ut :UndotreeToggle<CR>
let g:undotree_SplitWidth = g:win_width
let g:undotree_WindowLayout = 2

let g:pydoc_open_cmd = 'vsplit'
let g:pydoc_cmd = '/usr/bin/pydoc'
let g:pydoc_highlight = 0                             " don't highlight searching word
" f]]

" LSP f[[]]
if has('nvim')
lua << EOF

my_lsp_on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  if vim.lsp.formatexpr then -- Neovim v0.6.0+ only.
    vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr")
  end
  if vim.lsp.tagfunc then
    vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
  end

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>TroubleToggle lsp_references<CR>", opts)

  if client.server_capabilities.document_highlight then
    vim.api.nvim_command("augroup LSP")
    vim.api.nvim_command("autocmd!")
    vim.api.nvim_command("autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()")
    vim.api.nvim_command("autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()")
    vim.api.nvim_command("autocmd CursorMoved <buffer> lua vim.lsp.util.buf_clear_references()")
    vim.api.nvim_command("augroup END")
  end

  -- https://github.com/SmiteshP/nvim-navic#%EF%B8%8F-setup
  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end

  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-g>", "<cmd>TroubleToggle workspace_diagnostics<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[e", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]e", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
end
EOF
endif

" VSCode specifics:
if exists('g:vscode')
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
endif

source $HOME/.vim/source_local.vim
