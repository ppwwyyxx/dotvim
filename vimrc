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
use {'folke/tokyonight.nvim', lazy = false, opts = {
  on_colors = function(c)
    c.gitSigns = { add = '#00dd00', change = '#00c0ff', delete = '#ff3030' }
    c.ui_bg = '#24283b'
  end,
  on_highlights = function(hl, c)
    for k in pairs(hl) do
      -- Only keep the following, others are set by 'default' colorscheme.
      -- See https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/theme.lua
      if vim.startswith(k, "Cmp") or vim.startswith(k, "WhichKey") then goto continue end
      if vim.startswith(k, "Lsp") or vim.startswith(k, "@lsp") then goto continue end
      if vim.startswith(k, "Diagnostic") then goto continue end
      if vim.startswith(k, "@string") or vim.startswith(k, "@text") then goto continue end
      if vim.startswith(k, "GitGutter") then
        hl[k]["bg"] = c.ui_bg; goto continue
      end
      hl[k] = nil
      ::continue::
    end
    for _, k in ipairs({"Pmenu", "TreesitterContext", "TreesitterContextLineNumber", "SignColumn"}) do
      hl[k] = { bg = c.ui_bg }
    end
    for _, k in ipairs({"Error", "Warn", "Hint", "Info"}) do
      hl["DiagnosticSign" .. k] = { bg = c.ui_bg, fg = hl["Diagnostic" .. k ].fg}
    end
    hl["CmpPmenu"] = {bg = c.ui_bg, fg = '#c9f0f0'} -- For nvim-cmp completion
    hl["TreesitterContextLineNumber"]["fg"] = c.ui_bg  -- Hide line number
  end }}
use {'glepnir/dashboard-nvim', event = 'VimEnter', opts = {
  theme = 'hyper',
  config = {
    week_header = { enable = true },
    shortcut = {
      { desc = ' Recent Files', group = 'Label',
        action = 'Telescope oldfiles', key = 'r' },
      {
        desc = ' dotfiles', group = 'Number', key = 'd',
        action = function()
          local resolve = function(path)
            local path = vim.fs.normalize(path)
            local truepath = vim.fn.resolve(path)
            return (truepath ~= path) and vim.fs.dirname(truepath) or ''
          end
          require('telescope.builtin').find_files{
            layout_strategy = 'vertical',
            find_command = {
              "rg", "--files", resolve('~/.vimrc'), resolve('~/.zshrc'), "--hidden",
              "--glob", "!pixmaps", "--glob", "!.git"
            }}
        end },
    },
  },
}}
-- https://github.com/Yggdroot/indentLine/issues/345
use {'Yggdroot/indentLine', config = function()
  vim.g.indentLine_enabled = 0
  vim.g.indentLine_color_term = 239
  vim.g.indentLine_color_gui = '#A4E57E'
end }
use {'vim-scripts/searchfold.vim', keys = {'<Leader>z'}}
use 'vim-scripts/LargeFile'
use {'folke/which-key.nvim', branch = 'main'}
use {'lambdalisue/suda.vim', cmd = 'SudaWrite'}
use 'nvim-lualine/lualine.nvim'
-- https://github.com/folke/lazy.nvim/issues/389
use {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', event = "BufReadPost",
  opts = {
    -- Do not enable for comment
    ensure_installed = { 'bash', 'c', 'cmake', 'cpp', 'cuda', 'glsl', 'css', 'html', 'javascript', 'json', 'lua', 'make', 'markdown', 'ninja', 'proto', 'python', 'rst', 'scss', 'typescript', 'vim' },
    highlight = { enable = true, },
    context_commentstring = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
  },
  config = function(p, opts) require("nvim-treesitter.configs").setup(opts) end,
  dependencies = 'JoosepAlviste/nvim-ts-context-commentstring'
}
use {'nvim-treesitter/playground', cmd = 'TSHighlightCapturesUnderCursor'}
use {'nvim-treesitter/nvim-treesitter-context',
     opts = { min_window_height = 20, max_lines = 3 },
     event = "BufReadPost" }
use {'dstein64/vim-startuptime', cmd = 'StartupTime'}
use 'vim-scripts/MultipleSearch'
use 'ppwwyyxx/vim-PinyinSearch'

-- Window Tools:
use {'mbbill/undotree', cmd = 'UndotreeToggle'}
use 'nvim-lua/plenary.nvim'
use {'nvim-telescope/telescope.nvim', lazy = true, opts = {
  defaults = {
    prompt_prefix = '🔍',
    layout_strategy = 'flex',
    layout_config = {
      width = 0.9,
      flex = { flip_columns = 120 },
      horizontal = { preview_width = 0.6 },
      vertical = { preview_height = 0.3 }
    },
    path_display = { truncate = 2 },
    mappings = {
      i = {
        ["<C-s>"] = "file_split",
        ["<Esc>"] = "close",
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      }
    },
  }},
  config = function(p, opts)
    require('telescope').setup(opts)
    require('telescope').load_extension('fzf')
    require('telescope').load_extension('aerial')
  end,
  cmd = 'Telescope'
}
use {'nvim-telescope/telescope-fzf-native.nvim', build = 'make', branch = 'main', lazy = true }
use {'nvim-tree/nvim-tree.lua', dependencies = 'nvim-tree/nvim-web-devicons'}
use {'preservim/tagbar', cmd = 'TagbarToggle'}
use {'stevearc/aerial.nvim', opts = {
  attach_mode = 'global',
  autojump = true,
  placement = 'edge',
  highlight_on_hover = true,
  ignore = {filetypes = {'vim'}},
  nav = { autojump = true },
}}
use {'ii14/neorepl.nvim', commit = 'bc819bb42edca9c4a6b6e5d00f09f94a49c3b735', lazy = true }
use {'NvChad/nvim-colorizer.lua', ft = {'css', 'html', 'vim'},
     opts = { user_default_options = { names = false } } }


-- Editing Tools:
use {'rhysd/accelerated-jk', lazy = false }
use {'yonchu/accelerated-smooth-scroll', lazy = false }
use {'tsaleh/vim-align', cmd = {'Align', 'AlignCtrl'} }
use 'tpope/vim-surround'
use {'phaazon/hop.nvim',
  opts = { keys = 'etovxqpdygfblzhckisuran', jump_on_sole_occurrence = false },
  keys = {{',w', ':HopWord<cr>', mode='n'}}
}
use {'ojroques/vim-oscyank', branch = 'main'}
vim.g.matchmaker_enable_startup = 1 -- highlight words under cursor
use {'qstrahl/vim-matchmaker'} -- delay loading so it can read the config
use 'preservim/nerdcommenter'
use {'glts/vim-textobj-comment', dependencies = 'kana/vim-textobj-user'}
use {'kana/vim-textobj-indent', dependencies = 'kana/vim-textobj-user'}

-- Programming:
use {'ruanyl/vim-gh-line', event = 'VimEnter'} -- delay init to pickup configs.
use {'f-person/git-blame.nvim', opts = { enabled = false, date_format = '%r' }}
use {'LaTeX-Box-Team/LaTeX-Box', ft = 'tex'}
use {'derekwyatt/vim-fswitch', ft = {'cpp', 'c'}}
use {'shime/vim-livedown', ft = 'markdown'}
use 'neomake/neomake'
use {'airblade/vim-gitgutter', event = 'VimEnter'}
use {'wakatime/vim-wakatime', cond = vim.fn.filereadable(vim.fn.expand('$HOME/.wakatime.cfg')) == 1 }

-- LSP:
use {'neovim/nvim-lspconfig', lazy = true}
use {'onsails/lspkind.nvim', config = function()
  require("lspkind").init({ symbol_map = { Class = "", Struct = "", Copilot = " " } })
  -- https://github.com/zbirenbaum/copilot-cmp#highlighting--icon
  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})
end, event = "LspAttach" }

-- use { 'github/copilot.vim', cmd = 'Copilot', config = function() vim.g.copilot_no_tab_map = true end }
use { "zbirenbaum/copilot.lua", opts = { suggestion = { enabled = false }, panel = { enabled = false } }}
use { "zbirenbaum/copilot-cmp", config = function () require("copilot_cmp").setup() end }
use 'hrsh7th/cmp-path'
use 'hrsh7th/cmp-buffer'
use { 'hrsh7th/cmp-nvim-lsp', dependencies = {'hrsh7th/cmp-vsnip', 'hrsh7th/vim-vsnip', 'hrsh7th/cmp-nvim-lsp-signature-help' }, event = "LspAttach" }
use { 'hrsh7th/cmp-nvim-lua', ft = {'lua', 'vim'}}
use 'hrsh7th/cmp-cmdline'
use { 'hrsh7th/nvim-cmp' }

use {'folke/trouble.nvim', lazy = true, dependencies = 'nvim-tree/nvim-web-devicons', opts = {
  action_keys = {
    open_split = { "<c-s>" }, -- open buffer in new split
    open_tab = {},
  },
  auto_close = true, -- automatically close the list when you have no diagnostics
  use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
}, cmd = {'Trouble', 'TroubleToggle', 'TroubleClose'}}

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

if vim.fn.filereadable(vim.fn.stdpath("config") .. "/lua/local_plugin.lua") == 1 then
  use {import = 'local_plugin'}
end

-- List vim-specific plugins so they don't get cleaned.
for _, p in ipairs({'vim-airline/vim-airline', 'vim-airline/vim-airline-themes', 'ctrlpvim/ctrlp.vim', 'scrooloose/nerdtree'}) do
  use {p, lazy = true}
end

require("lazy").setup(plugins, {
  root = vim.fn.stdpath("config") .. "/bundle",
  -- defaults = { lazy = true },
})

EOF
else  " f]]
" Plugins for pure vim: f[[
syntax on
filetype off            " for vundle
call plug#begin('~/.vim/bundle')
" UI And Basic:
Plug 'vim-scripts/LargeFile'
Plug 'lambdalisue/suda.vim'
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
Plug 'preservim/nerdcommenter'
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
set titlelen=20
set titlestring=%f

" First load default, then overwrite misc with tokyonight
colo default
if has("nvim") | set termguicolors | else
  " https://github.com/vim/vim/issues/993#issuecomment-255651605
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
set guicursor=    " neovim mess up with terminal cursor
if has("nvim")
  colo tokyonight-night
  set guifont=Monospace:h18
else
  set guifont=Monospace\ 16
  if has("gui_running")   " for gvim/neovide
    colo codedark
    cnoremap <C-S-v> <C-r>*
  endif
endif
set guioptions=aegi                " cleaner gui
set t_Co=256
au BufEnter * if &buftype == "quickfix" | syn match Error "error:" | endif
hi Matchmaker guibg=#444444
hi Folded guibg=#444444 guifg=lightblue
hi Search ctermfg=red ctermbg=cyan guibg=#8ca509
hi MatchParen ctermbg=yellow ctermfg=black
hi Visual ctermbg=81 ctermfg=black cterm=none guibg=#0a6886 guifg=NONE

hi LineNr ctermfg=134 guifg=#d426ff guibg=#24283b
hi VertSplit ctermbg=none ctermfg=55 cterm=none guifg=#65ec9b
hi PmenuSel guifg=lightgreen

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
  hi TreesitterContextBottom gui=underdashed guisp=lightgreen

  lua << EOF
  -- https://github.com/neovim/neovim/issues/14295#issuecomment-950037927
  --   looks weird in some terminals
  local signs = { Error = "", Warn = "", Hint = "", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end
EOF
else
  hi clear ALEError
  hi clear ALEWarning
endif

" Spell Check:
set spellfile=~/.vim/static/spell.utf-8.add
hi SpellCap guisp=yellow
let g:tex_conceal='adgmb'

set mouse=a
set showcmd                            " display incomplete commands right_bottom
set numberwidth=1
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

  require('lualine').setup {
  options = {
    theme = theme,
    component_separators = { left = '', right = ''},
    --section_separators = { left = '', right = ''},
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = {{'mode', fmt = function(str) return str:sub(1,1) end }},
    lualine_b = {'branch', {'diff', symbols = {added = ' ', modified = ' ', removed = ' '} } },
    lualine_c = {
      {'filename', shorting_target = 0, path = 1, fmt = filenamefmt, symbols = { modified = ''}, padding={left=0,right=1} },
      {'diagnostics', sources = {'nvim_diagnostic', 'ale'}},
    },
    lualine_x = {'filetype'}, lualine_y = {}, lualine_z = {{'location', padding = {left=0, right=1}} }
  },
  inactive_sections = {
    lualine_c = {
      {'filename', shorting_target = 0, path = 1, fmt = filenamefmt, symbols = { modified = ''} },
    },
    lualine_x = {'encoding', 'filetype'}, },
  extensions = {'nvim-tree', 'trouble'}
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

set scrolljump=5                       " lines to scroll with cursor
set scrolloff=5                        " minimum lines to keep at border
set sidescroll=3
set sidescrolloff=3
set nowrap                             " do not wrap long lines
set whichwrap=b,s,<,>,[,]
set breakat=\ ^I!@*-+;,.?
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
cnoremap %% <C-R>=expand('%:h').'/'<cr>
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif
cmap w!! SudaWrite %
cnoremap cd. lcd %:p:h
nnoremap "gf <C-W>gf
" disable ex mode, help and c-a
nnoremap Q <Esc>
nnoremap <F1> <Esc>
inoremap <F1> <Esc>
nnoremap <C-a> <Esc>
vnoremap <CR> <Esc>

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
  vnoremap <C-c> :OSCYankVisual<CR>
endif
inoremap <c-v> <Esc>:set paste<CR>"+p:set nopaste<CR>a
" insert word of the line above
inoremap <C-Y> <C-C>:let @z = @"<CR>mz
      \:exec 'normal!' (col('.')==1 && col('$')==1 ? 'k' : 'kl')<CR>
      \:exec (col('.')==col('$') - 1 ? 'let @" = @_' : 'normal! yw')<CR>
      \`zp:let @" = @z<CR>a
" delete to blackhole register
nnoremap <Del> "_x
vnoremap <Del> "_d
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
set switchbuf=split
nnoremap <C-g> <cmd>TroubleClose<CR><cmd>cclose<CR><cmd>pclose<CR>
nnoremap <Leader>xx <cmd>Trouble<CR>
nnoremap ]e :lnext<CR>
nnoremap [e :lprev<CR>

" ---------------------------------------------------------------------
" Cursor Movement: f[[
if isdirectory($HOME . "/.vim/bundle/accelerated-jk")        " a variable not assigned
  nmap j <Plug>(accelerated_jk_gj)
  nmap k <Plug>(accelerated_jk_gk)
endif
let g:accelerated_jk_acceleration_limit = 500
let g:accelerated_jk_acceleration_table = [10, 20, 30, 35, 40, 45, 50]

nnoremap n nzzzv
nnoremap N Nzzzv
inoremap <c-h> <Left>
inoremap <c-j> <Down>
inoremap <c-k> <Up>
inoremap <c-l> <Right>
imap <c-e> <End>
imap <c-a> <Home>
inoremap <c-b> <S-Left>
inoremap <a-f> <Esc>lwi
inoremap <a-b> <Esc>bi
cmap <c-j> <Down>
cmap <c-k> <Up>
cmap <a-f> <S-Right>
cmap <c-b> <S-Left>
cmap <a-b> <S-Left>
cmap <c-e> <End>
cmap <c-a> <Home>
" undoable C-U, C-W
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>
vnoremap << <gv<gv
vnoremap >> >gv>gv
" Save Cursor Position:
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
command ToggleColorColumn call ToggleColorColumn(0)

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
command DeleteTrailingWhiteSpace call DeleteTrailingWhiteSpace()
au BufWritePre * call DeleteTrailingWhiteSpace()

" ---------------------------------------------------------------------
" Log For Debugging Vimscript:
func! ToggleVimscriptVerbose()
  if !&verbose
    exe "!rm /tmp/vimlog"
    set verbosefile=/tmp/vimlog
    set verbose=10
  else | set verbose=0 | set verbosefile= | endif
endfunc
command ToggleVimscriptVerbose call ToggleVimscriptVerbose()<CR>

" ---------------------------------------------------------------------
" Diff Current Buffer With Correspondent Saved File:
func! DiffWithSaved()
  let ft=&filetype
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . ft
endfunc
command! DiffWithSaved call DiffWithSaved()
nnoremap <Leader>df :call DiffWithSaved()<CR>

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
  return ":let v:hlsearch=0\<CR>:silent! SearchBuffersReset\<CR>"
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
set completeopt=menu,menuone,preview,longest
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
if has('nvim')
  let g:ale_use_neovim_diagnostics_api = 1
endif
let g:ale_linters = {'python': ['flake8'], 'sh': ['shellcheck']}
let g:ale_fixers = {'python': ['black']}
" Only enable hard errors https://flake8.pycqa.org/en/latest/user/error-codes.html
let g:ale_python_flake8_options = '--max-line-length 120 --select F8,F402,F404,F405'
let g:ale_python_black_options = '-l 100'


if has('nvim')
  lua << EOF
local cmp = require("cmp")
cmp.setup({
  snippet = { expand = function(args) vim.fn["vsnip#anonymous"](args.body) end, },
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-u>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping(function(fallback)
      cmp.mapping.close()
      fallback()
    end, {"i"}),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),

    -- https://github.com/zbirenbaum/copilot-cmp#tab-completion-configuration-highly-recommended
    ["<Tab>"] = vim.schedule_wrap(function(fallback)
      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
      end
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end),
    --["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), {"i", "c"}),
  }),

  sources = {
    { name = "copilot", group_index = 2 },
    { name = "nvim_lsp", group_index = 2 },
    { name = 'nvim_lsp_signature_help', group_index=1 },
    { name = "path", group_index = 3 },
    { name = "buffer", keyword_length = 5, group_index = 3 },
    { name = "nvim_lua", group_index = 3 },
  },

  window = {
    completion = { winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenu" },
    documentation = { winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenu", border = "rounded" }
  },

  formatting = {
    format = require("lspkind").cmp_format({
      mode = "symbol",
      with_text = true,
      maxwidth = 40, -- half max width
      menu = {
        buffer = "[Buf]", path = "[Path]",
        nvim_lsp = "[LSP]", nvim_lua = "[Vim]",
      },
    }),
  },

  experimental = { ghost_text = true },
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'cmdline', option = { ignore_cmds = { 'Man', '!' } } }
  }),
  matching = { disallow_fuzzy_matching = true, disallow_partial_matching = true },
  completion = { keyword_length = 3 },
  formatting = { fields = {'abbr'} },
  window = { completion = { border = "rounded" } },
})

cmp.setup.filetype({ 'text', 'help'}, {
  sources = {{ name = 'path' }, { name = 'buffer'} }
})
EOF
endif

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
func! InstantRun()
  if &ft == 'python' | :!python %
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
au BufRead TARGETS,WORKSPACE setf syntax=python | setl expandtab
au BufNewFile,BufRead config.fish set ft=sh               " syntax for fish config file
au BufNewFile,BufRead *.json setl ft=json syntax=txt
au BufNewFile,BufRead /tmp/dir*,/tmp/tmp*,/tmp/*edir.sh setf txt | setl ts=4           " for vidir / vimv / edir
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
au FileType make setl noexpandtab
au FileType yaml setl foldmethod=indent foldlevel=99 fml=1
au Filetype txt,crontab setl textwidth=500
au FileType sh,zsh inoremap ` ``<Left>
" https://github.com/martinvonz/jj/discussions/2413
au BufRead *.jjdescription
  \ syn match jjcommitComment "^JJ: .*$" contains=@NoSpell |
  \ hi def link jjcommitComment Comment

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
" <leader>gC to open github repo
let g:gh_open_command = ''
let g:gh_git_remote = 'origin'  " default remote
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
if !has('nvim')
  nnoremap <Leader>/ :Search<Space>
endif
let g:MultipleSearchMaxColors = 16

if has('nvim')
  hi TelescopeSelection gui=underdashed guifg=#6e68ee
  hi TelescopePromptCounter guifg=orange
  nnoremap <C-P> <cmd>Telescope find_files<cr>
  nnoremap <M-x> <cmd>Telescope commands<cr>
  nnoremap <leader>/ <cmd>Telescope live_grep<cr>
  nnoremap <leader>fb <cmd>Telescope buffers<cr>
  nnoremap <leader>fr <cmd>Telescope oldfiles<cr>
  nnoremap <leader>ft <cmd>Telescope treesitter<cr>
else
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
command JsBeautify call JsBeautify()
nmap <Leader>css :call CSSBeautify()<CR>
command CssBeautify call CSSBeautify()
nmap <Leader>html :call HtmlBeautify()<CR>
command HtmlBeautify call HtmlBeautify()

" toggle indent
nnoremap <leader>ti :IndentLinesToggle<CR>:set list! lcs=tab:\\|\<Space><CR>

" GitGutter
" TODO: cycle https://github.com/airblade/vim-gitgutter#cycle-through-hunks-in-current-buffer
nnoremap ]d :silent GitGutterNextHunk<CR>
nnoremap [d :silent GitGutterPrevHunk<CR>
if has('nvim')
" Disable symbols and use linenr
let g:gitgutter_highlight_linenrs = 1
let g:gitgutter_signs = 0
let g:gitgutter_sign_modified = ''
let g:gitgutter_sign_added = ''
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_modified_removed = g:gitgutter_sign_modified
command GitGutterDiffLast let g:gitgutter_diff_base = 'HEAD~1' | GitGutterEnable
else
endif
" f]]
" Window Plugins: f[[
let g:win_width = 22
let g:tagbar_width = g:win_width
let g:tagbar_autofocus = 1
let g:tagbar_indent = 1
let g:tagbar_compact = 1
nmap <Leader>tl :AerialToggle!<CR>

" toggle file
if has('nvim')
  lua << EOF
require("nvim-tree").setup({
  view = { width = 25 },
  on_attach = function(bufnr)
    local api = require('nvim-tree.api')
    local opts = { buffer = bufnr, silent = true, nowait = true }
    api.config.mappings.default_on_attach(bufnr)
    vim.keymap.set('n', 'l', api.node.open.edit, opts)
    vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts)
  end,
  renderer = {
    icons = { glyphs = {
      git = { untracked = "" }
    }}
  }
})

-- https://github.com/nvim-tree/nvim-tree.lua/issues/1368
vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local invalid_win = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match("NvimTree_") ~= nil then
        table.insert(invalid_win, w)
      end
    end
    if #invalid_win == #wins - 1 then
      -- Should quit, so we close all invalid windows.
      for _, w in ipairs(invalid_win) do vim.api.nvim_win_close(w, true) end
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

if has('nvim')
lua << EOF
  vim.api.nvim_create_user_command(
    'NeoRepl',
    function()
      local buf = vim.api.nvim_get_current_buf()
      local win = vim.api.nvim_get_current_win()
      vim.cmd('split')
      require('neorepl').new{lang = 'lua', buffer = buf, window = win}
      vim.cmd('resize 10 | setl winfixheight')
      require('cmp').setup.buffer({ enabled = false })
    end, {})
EOF
endif
" f]]

" LSP f[[
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

  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]e", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "gr", "<cmd>TroubleToggle lsp_references<CR>", opts)
  vim.keymap.set("n", "<C-g>", "<cmd>TroubleToggle workspace_diagnostics<CR>", opts)

  if client.server_capabilities.document_highlight then
    vim.api.nvim_command("augroup LSP")
    vim.api.nvim_command("autocmd!")
    vim.api.nvim_command("autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()")
    vim.api.nvim_command("autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()")
    vim.api.nvim_command("autocmd CursorMoved <buffer> lua vim.lsp.util.buf_clear_references()")
    vim.api.nvim_command("augroup END")
  end
end
vim.api.nvim_create_autocmd('LspAttach', {
  -- https://neovim.io/doc/user/lsp.html
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    my_lsp_on_attach(client, bufnr)
  end
})
EOF
command LspAddWorkspaceFolder lua vim.lsp.buf.add_workspace_folder()
command LspListWorkspaceFolder lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
endif
" ------------------------------------------------------------------------------------------ f]]

source $HOME/.vim/source_local.vim
