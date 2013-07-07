" $Date: Sun Jul 07 20:34:35 2013 +0800
" Author: WuYuxin <ppwwyyxxc@gmail.com>"

set nocompatible                    " Use Vim Settings (Not Vi). This must be first, because it changes other options as a side effect.
syntax on
filetype plugin indent on
if filereadable($HOME . "/.evervim/secret.vim")
    source ~/.evervim/secret.vim    " account info for evervim
endif
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
Bundle 'Color-Scheme-Explorer'
Bundle 'FuzzyFinder'
Bundle 'gprof.vim'
Bundle 'tpope/vim-markdown'
Bundle 'MultipleSearch'
Bundle 'sudo.vim'
Bundle 'rhysd/accelerated-jk'
Bundle 'yonchu/accelerated-smooth-scroll'
Bundle 'tsaleh/vim-align'
Bundle 'sjl/clam.vim'
Bundle 'smilekzs/vim-coffee-script'
Bundle 'Rykka/colorv.vim'
Bundle 'basepi/vim-conque'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'chrisbra/csv.vim'
Bundle 'mrtazz/DoxygenToolkit.vim'
Bundle 'DrawIt'
Bundle 'spolu/dwm.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'kakkyz81/evervim'
Bundle 'terryma/vim-expand-region'
Bundle 'nvie/vim-flake8'
Bundle 'grep.vim'
Bundle 'sjl/gundo.vim'
Bundle 'Yggdroot/indentLine'
Bundle 'digitaltoad/vim-jade'
Bundle 'davidhalter/jedi-vim'
Bundle 'maksimr/vim-jsbeautify'
Bundle 'einars/js-beautify'
Bundle 'L9'
Bundle 'LargeFile'
Bundle 'LaTeX-Box-Team/LaTeX-Box'
Bundle 'groenewege/vim-less'
Bundle 'yueyoum/vim-linemovement'
Bundle 'Mathematica-Syntax-File'
Bundle 'matrix.vim'
Bundle 'Shougo/neocomplcache'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'evanmiller/nginx-vim-syntax'
Bundle 'myhere/vim-nodejs-complete'
Bundle 'ppwwyyxx/vim-PinyinSearch'
Bundle 'spf13/PIV'
Bundle 'Lokaltog/vim-powerline'
Bundle 'fs111/pydoc.vim'
Bundle 'python_match.vim'
Bundle 'tpope/vim-rails'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'ujihisa/rdoc.vim'
Bundle 'ervandew/screen'
Bundle 'tpope/vim-scriptease'
Bundle 'searchfold.vim'
Bundle 'slim-template/vim-slim'
Bundle 'Vladimiroff/vim-sparkup'
Bundle 'mhinz/vim-startify'
Bundle 'wavded/vim-stylus'
Bundle 'ppwwyyxx/vim-SugarCpp'
Bundle 'tpope/vim-surround'
Bundle 'majutsushi/tagbar'
Bundle 'taglist.vim'
Bundle 'tpope/vim-tbone'
Bundle 'glts/vim-textobj-comment'
Bundle 'kana/vim-textobj-indent'
Bundle 'kana/vim-textobj-user'
Bundle 'tomtom/tlib_vim'
Bundle 'tomtom/tmru_vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'Shougo/vimproc'
Bundle 'vim-ruby/vim-ruby'
Bundle 'VisIncr'
Bundle 'gmarik/vundle'
Bundle 'winmanager'
Bundle 'Valloric/YouCompleteMe'
" ---------------------------------------------------------------------
" Environment:
if &term =~ '^screen'                 " fix keymap under screen
    " tmux will send xterm-style keys when its xterm-keys option is on
    exec "set <xUp>=\e[1;*A"
    exec "set <xDown>=\e[1;*B"
    exec "set <xRight>=\e[1;*C"
    exec "set <xLeft>=\e[1;*D"
    "map [F $
    "imap [F $
    "map [H g0
    "imap [H g0
endif
if ! has("gui_running")                " fix alt key under terminal
    for i in range(48, 57) + range(65, 90) + range(97, 122)
        exe "set <A-" . nr2char(i) . ">=" . nr2char(i)
    endfor
endif
set shell=zsh\ -f
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
"set lazyredraw
cmap cd. lcd %:p:h
cmap w!! SudoWrite %

" ---------------------------------------------------------------------
" UI: f[[
set background=light
if has("gui_running")                " for gvim
    set antialias                    " font antialias
    set guifont=inconsolata\ 13
    "set guifont=Monospace\ 12
    set guifontwide=WenQuanYi\ Micro\ Hei\ 13
    set guioptions=aegi                " cleaner gui
    set linespace=3
    set background=dark
    "colo wombat256
    "colo molokai
    colo bocau
    hi CursorColumn guibg=Green
endif
set t_Co=256
au BufEnter * if &buftype == "quickfix" | syn match Error "error:" | endif
hi LineNr ctermfg=134 guifg=#d426ff
hi VertSplit ctermbg=none ctermfg=55 cterm=none
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

" Spell Check:
hi clear SpellBad
hi SpellBad term=standout term=underline cterm=italic ctermfg=none ctermbg=black
hi clear SpellCap
hi SpellCap term=standout term=underline cterm=italic ctermfg=Blue
hi clear SpellLocal
hi SpellLocal term=standout term=underline cterm=italic ctermfg=Blue
hi clear SpellRare
hi SpellRare term=standout term=underline cterm=italic ctermfg=Blue
" Statusline Highlight:
au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=undercurl guisp=Magenta
au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
let g:tex_conceal='adgmb'

set mouse=a
set showcmd                            " display incomplete commands right_bottom
set numberwidth=1
au InsertEnter * set number
set ruler
set rulerformat=%35(%=%r%Y\|%{&ff}\|%{strlen(&fenc)?&fenc:'none'}\ %m\ %l/%L%)
"let &statusline="%<[%{substitute(getcwd(), expand(\"$HOME\"), '~', 'g')}]\ %f\ %=%r%Y\|%{&ff}\|%{strlen(&fenc)?&fenc:'none'}\ %l/%L"
"set statusline+=%#warningmsg#
"set statusline+=%*
set laststatus=2

let g:Powerline_theme='custom'
let g:Powerline_symbols = 'compatible'
let g:Powerline_cache_dir = $HOME . '/.vimtmp/'
let g:Powerline_stl_path_style = 'relative'
let g:Powerline_symbols_override = { 'LINE': ''}
let g:loaded_syntastic_plugin = 0        " disable powerline syntastic
let g:Powerline_mode_n = 'N'
let g:Powerline_mode_i = 'I'
let g:Powerline_mode_v = 'V'
let g:Powerline_mode_V = 'VL'
let g:Powerline_mode_cv = 'VB'
let g:Powerline_mode_s = 'S'
let g:Powerline_mode_S = 'SL'
let g:Powerline_mode_cs = 'SB'

set scrolljump=5                    " lines to scroll with cursor
set scrolloff=5                        " minimum lines to keep at border
set sidescroll=3
set sidescrolloff=3
set nowrap                            " do not wrap long lines
"au Filetype java set wrap            " **HACK** nowrap cause javacomplete to jump when dealing with long file
set whichwrap=b,s,<,>,[,]
"set listchars=nbsp:¬,eol:¶,tab:>-,extends:»,precedes:«,trail:•
set fillchars=vert:*,fold:-,diff:-
if has("patch541")
    set formatoptions+=nMjm            " m: linebreak for Chinese
else
    set formatoptions+=nMm
endif
set splitright splitbelow
set backspace=indent,eol,start        " allow backspace over everything
set smarttab
set autoindent smartindent
set textwidth=100
set tabstop=4 softtabstop=4 shiftwidth=4
set showmatch
set matchtime=0

set hlsearch                        " high light search
set ignorecase smartcase
set incsearch                         " do incremental searching
set magic                             " for regular expressions
" use /[^\x00-\x7F] to search multibytes
" ---------------------------------------------------------------------f]]
" History:
set nobackup noswapfile
set history=200                        " command line history
if has('persistent_undo')
    set undofile                       " keep an undo record separately for every file
    set undolevels=200
    set undodir=~/.vimtmp/undo
endif
au CursorHold,CursorHoldI,BufEnter,WinEnter * checktime
set autoread                           " auto reload file when changes have been detected
set updatetime=500                     " time threshold for CursorHold event
set viminfo+=n$HOME/.vimtmp/viminfo

" ---------------------------------------------------------------------
"" Basic Maps:
let mapleader=" "
let maplocalleader=","
set timeoutlen=300                     " wait for ambiguous mapping
set ttimeoutlen=0                      " wait for xterm key escape
inoremap <c-\> <Esc>
vnoremap <c-\> <Esc>
inoremap jj <ESC>
nnoremap ; :
command -bang -nargs=* Q q<bang>
command -bang -nargs=* -complete=file W w<bang> <args>
command -bang -nargs=* -complete=file Wq wq<bang> <args>
command -bang -nargs=* -complete=file WQ wq<bang> <args>
nnoremap <Tab> i<Tab><Esc>
nnoremap <S-Tab> ^i<Tab><Esc>
xmap / <Esc>/\%V
cnoremap %% <C-R>=expand('%:h').'/'<cr>
nnoremap "gf <C-W>gf
" disable ex mode and help
nnoremap Q <Esc>
nnoremap <F1> :echo<CR>
inoremap <F1> <C-o>:echo<CR>
" ---------------------------------------------------------------------
" Clipboard:                           " + register may be wrong under xterm
nnoremap Y y$
set pastetoggle=<F12>                  " toggle paste insert mode
xnoremap <c-c> "+y
inoremap <c-v> <Esc>:set paste<CR>"+p:set nopaste<CR>i
" insert word of the line above
inoremap <C-Y> <C-C>:let @z = @"<CR>mz
           \:exec 'normal!' (col('.')==1 && col('$')==1 ? 'k' : 'kl')<CR>
           \:exec (col('.')==col('$') - 1 ? 'let @" = @_' : 'normal! yw')<CR>
           \`zp:let @" = @z<CR>a
" delete to blackhole register
nnoremap <Del> "_x
xnoremap <Del> "_d
xnoremap p "_dp
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

" ---------------------------------------------------------------------
" Cursor Movement: f[[
if isdirectory($HOME . "/.vim/bundle/accelerated-jk")        " a variable not assigned
    nmap j <Plug>(accelerated_jk_gj)
    nmap k <Plug>(accelerated_jk_gk)
endif
nnoremap n nzzzo
nnoremap N Nzzzo
nnoremap <c-l> $
nnoremap <c-h> 0
imap <c-h> <Left>
imap <c-j> <Down>
imap <c-k> <Up>
imap <c-l> <Right>
imap <c-e> <End>
imap <c-d> <Home>
inoremap <c-b> <S-Left>
inoremap <a-f> <S-Right>
inoremap <a-b> <S-Left>
cmap <c-l> <Right>
cmap <c-h> <Left>
cmap <a-f> <S-Right>
cmap <c-b> <S-Left>
cmap <a-b> <S-Left>
cmap <c-e> <End>
cmap <c-d> <Home>
"vnoremap << <gv<gv
"vnoremap >> >gv>gv
" Save Cursor Position:
au BufReadPost *
           \ if line("'\"") > 0 && line("'\"") <= line("$") |
           \   exe "normal g`\"" |
           \ endif
" Hint On Moving Cursor:
func HintCursorLine(opr)
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
    if g:last_win != winnr() || diff > 2
        set cursorline
    endif
    let g:last_pos  = cur_pos
    let g:last_line = cur_line
    let g:last_win  = winnr()
endfunc
" Highlight Chosen Columns:
func ToggleColorColumn(col)
    let col_num = (a:col == 0) ? virtcol(".") : a:col
    let cc_list = split(&cc, ',')
    if count(cc_list, string(col_num)) <= 0
        exec "set cc+=".col_num
    else
        exec "set cc-=".col_num
    endif
endfunc
hi ColorColumn ctermbg=red
"au CursorMoved,BufWinEnter * call HintCursorLine(1)		" this greatly affects performance ...
au CursorHold,CursorHoldI,BufLeave,WinLeave * call HintCursorLine(0)
nmap <LocalLeader>c :call ToggleColorColumn(0)<CR>

" ---------------------------------------------------------------------f]]
" Auto Fill Brackets:                  " probably you won't like this
inoremap " ""<Left>
inoremap ' ''<Left>
au Filetype tex,txt,lrc silent! iunmap '
inoremap ( ()<Left>
inoremap { {}<Left>
inoremap [ []<Left>
inoremap () ()
inoremap {} {}
inoremap [] []
au Filetype vim silent! iunmap "
au Filetype vim silent! iunmap ""
" ---------------------------------------------------------------------
" Multi Window:
nmap <c-w><Right> 4<c-w>>
nmap <c-w><Left> 4<c-w><
nmap <c-w><Down> 4<c-w>+
nmap <c-w><Up> 4<c-w>-
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
" ---------------------------------------------------------------------
" Switch Buffer:
nnoremap <a-Down> :bn! <CR>
nnoremap <a-Up> :bp! <CR>
inoremap <a-Down> <ESC>:bn! <CR>
inoremap <a-Up> <ESC>:bp! <CR>
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
map ： :

func Replace_Chn()                     " for writing latex
    let chinese={"（" : "(" , "）" : ")" , "，" : ",", "；" : ";", "：" : ":", "？" : "?", "！" : "!", "“" : "\"", "’" : "'" ,"”" : "\"", "℃" : "\\\\textcelsius", "μ" : "$\\\\mu$"}
    for i in keys(chinese)
        silent! exec '%substitute/' . i . '/'. chinese[i] . '/g'
    endfor
endfunc
nnoremap <leader>sch :call Replace_Chn()<cr>

" Fcitx:
func Fcitx_enter()
    if (getline('.')[col('.') - 1] >= "\x80")
        call system("fcitx-remote -o")
		return | endif
    if (getline('.')[col('.') - 2] >= "\x80")
        call system("fcitx-remote -o")
    endif
endfun
autocmd InsertLeave * call system("fcitx-remote -c")
autocmd InsertEnter * call Fcitx_enter()

" ---------------------------------------------------------------------f]]
" Delete Trailing	 Whitespaces On Saving:
func DeleteTrailingWhiteSpace()
    normal mZ
    %s/\s\+$//e
    normal `Z
endfunc
au BufWrite * if &ft != 'mkd' | call DeleteTrailingWhiteSpace() | endif

" ---------------------------------------------------------------------
" Extract And Inline Variable:
func ExtractVariable()
    let name = input("Variable name: ")
    if name == '' | return | endif
    " Enter visual mode (not sure why this is needed since we're already in visual mode anyway)
    normal! gv

    exec "normal c" . name
    exec "normal! O" . name . " = "
    normal! $p
endfunction
func InlineVariable()
    " Copy the variable under the cursor into the 'a' register
    exec "normal \"zyiw"
    normal 2daW
    exec "normal \"xd$"
    normal dd
    " Go to the end of the previous line so we can start our search for the
    " usage of the variable to replace. Doing '0' instead of 'k$' doesn't
    " work; I'm not sure why.
    normal k$
    exec '/\<' . @z . '\>'
    exec ':.s/\<' . @z . '\>/' . @x
endfunction
xnoremap <leader>rv :call ExtractVariable()<cr>
nnoremap <leader>ri :call InlineVariable()<cr>

" ---------------------------------------------------------------------
" Log For Debugging Vimscript:
func ToggleVerbose()
    if !&verbose
        exe "!rm /tmp/vimlog"
        set verbosefile=/tmp/vimlog
        set verbose=10
    else | set verbose=0 | set verbosefile= | endif
endfunc
nmap <Leader>tv :call ToggleVerbose()<CR>
"set verbosefile=/tmp/vimlog
"set verbose=15

" ---------------------------------------------------------------------
" Head Update:
fun LastMod()
    let l:line = line(".")                            " save cursor position
    let l:col = col(".")
    let l = min([line("$"), 8])
    exec '1,' . l . 'substitute/' . '^\(.*Date:\).*$' . '/\1 ' . strftime('%a %b %d %H:%M:%S %Y %z') . '/e'
    exec '1,' . l . 'substitute/' . '^\(.*File:\).*$' . '/\1 ' . expand('<afile>:t') . '/e'
    call cursor(l:line, l:col)
endfun
au BufWritePre,FileWritePre * call LastMod()

" ---------------------------------------------------------------------
" Toggle Hex Mode:
func ToggleHex()
    let l:modified=&mod | let l:oldreadonly=&readonly
    setl ro
    let l:oldmodifiable=&modifiable | let &modifiable=1
    if ! exists("b:editHex") || !b:editHex
        let b:oldft=&ft | let b:oldbin=&bin
        setl binary
        let &ft="xxd" | let b:editHex=1
        %!xxd
    else
        let &ft=b:oldft | let b:editHex=0
        if !b:oldbin | setl nobinary | endif
        %!xxd -r
    endif
    " restore values for modified and read only state
    let &mod=l:modified | let &readonly=l:oldreadonly | let &modifiable=l:oldmodifiable
endfunc
nmap <Leader>hex :call ToggleHex()

" ---------------------------------------------------------------------
" Diff Current Buffer With Correspondent Saved File:
func DiffWithSaved()
    let ft=&filetype
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . ft
endfunc
com DiffSaved call DiffWithSaved()
nnoremap <Leader>df :call DiffWithSaved()<CR>

" ---------------------------------------------------------------------
" Set Title:        " TODO for normal type of file f[[
func GenerateHead(line)
    let Comment   = {"cpp": "\//","sh": "#", "python": "#", "tex": "%","c": "\//", "ruby": "#", "java": "\//"}
    let AuthorStr = "Author: Yuxin Wu <ppwwyyxxc@gmail.com>"
    let ft        = &filetype
    let Head_List = [Comment[ft]. " File:",Comment[ft]. " Date:",Comment[ft]. " ".AuthorStr]
    call append(a:line, Head_List)
endfunc
func SetTitle()
    let file_name = expand("%:t")
    let file_head = expand("%:t:r")
    if &ft == 'sh'
        call setline(1, "#!/bin/bash")
        call GenerateHead(1)
        normal G
    elseif file_name =~ "^[^.]*\.hh*[px]*$"
        call GenerateHead(0)
        call append(line("$"), ["#pragma once", ""])
        normal G
    elseif &ft == 'cpp'
        call GenerateHead(0)
        call append(line("$"), ["#include <iostream>","#include <cstdlib>","#include <cstring>","#include <cstdio>","#include <algorithm>", "using namespace std;"," "])
        normal G
    elseif &ft == 'java'
        call GenerateHead(0)
        call append(line("$"), ["public class ". file_head . "{", "\tpublic static void main(){", "\t}", "}"])
        normal jjj
    elseif &ft == 'python'
        0put=\"#!/usr/bin/env python2\<nl># -*- coding: UTF-8 -*-\"
        call GenerateHead(2)
        normal G
    elseif &ft == 'ruby'
        0put=\"#!/usr/bin/env ruby\<nl># coding: utf-8\"
        call GenerateHead(2)
        normal G
    elseif &ft == 'tex'
        call GenerateHead(0)
        normal G
    elseif &ft == 'html'
        call setline(1, "html:5")
        normal $
        call feedkeys("\<C-z>")                                " call sparkup
    endif
endfunc
au BufNewFile *.* call SetTitle()
au BufNewFile Makefile exec ":r ~/programming/cpp/Makefiles/Makefile"

" ---------------------------------------------------------------------f]]
" Make For Programming: f[[
"for gprof
command -nargs=* Makepg call Make_arg("g++ % -o %:r -pg -Wall -std=c++11", <f-args>)

func Make()                        " silent make with quickfix window popup
    if &ft == 'cpp'
        if filereadable(getcwd() . "/Makefile")
            let &makeprg="make"
        elseif  filereadable(getcwd() . "/../Makefile")
            let &makeprg="make -C .."
        endif
    endif
    make
    " silent make ?
    redraw!
    for i in getqflist()
        if i['valid']
            cwin | winc p | return
        endif
    endfor
endfunc

func FindMakefile()
    exec "cd " . expand ("%:p:h")
    while ! filereadable(getcwd() . "/Makefile") && getcwd () != "/"
        cd ..
    endw
    :!make
endfunc

au Filetype gnuplot let &makeprg="gnuplot % ; feh ./*"
au Filetype dot let &makeprg="dot -Tpng -O -v % ; feh %.png"
au Filetype php let &makeprg="php %"
au Filetype r let &makeprg="R <% --vanilla"
func InstantRun()
    if &ft == 'python'
        if matchstr(getline(1), 'python2') == ""
            :!python %
        else
            :!python2 %
        endif
    elseif &ft == 'ruby'
        :!ruby %
    elseif &ft == 'sh'
        :!bash %
    elseif &ft == 'cpp'
        :!gdb -tui %<
    elseif &ft == 'java'
        :! java %<
    elseif &ft == 'javascript'
        :! node %
    elseif &ft == 'coffee'
        :! coffee %
	else | call Make() | endif
endfunc
nnoremap <Leader>rr :call InstantRun() <CR>
nnoremap <Leader>mk :call Make()<CR>
nnoremap <Leader>mr :!make run <CR>
nnoremap <Leader>make :call FindMakefile()<CR>

" ---------------------------------------------------------------------f]]
" Completetion And Tags: f[[
set wildmenu                                         " command-line completion
set wildmode=list:longest,full
set wildignore+=*.o,*.exe,main,*.pyc,*.aux,*.toc     " don't add .class for javacomplete searching for Reflection.class
set wildignore+=*.git,*.svn,*.hg
set wildignore+=*.sqlite3
set wildignore+=*~,*.bak,*.sw
set completeopt=menu,preview,longest
set complete=.,w,b,u
set path+=./include,                                 " path containing included files for searching variables
" Prevent the first completion result to be chosen, only needed for C++?
inoremap <C-O> <C-X><C-O><C-P>
inoremap <C-P> <C-X><C-P>
set dict+=$HOME/.vim/static/dict_with_cases          " use c-X c-K to open dictionary completion
set tags=.tags
nmap <Leader>tag :!ctags -R -f .tags --c++-kinds=+p --fields=+iaS --extra=+q . <CR><CR> :TlistUpdate <CR>:NeoComplCacheCachingTags<CR>

let g:ycm_global_ycm_extra_conf = $HOME . "/.vim/static/ycm_extra_conf.py"
let g:ycm_key_detailed_diagnostics = "<Leader>yd"
let g:ycm_key_invoke_completion = "<F5>"
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<Enter>']
let g:ycm_confirm_extra_conf = 0
let g:ycm_cache_omnifunc = 0

func Neo_Toggle(mode)
    let i = index(g:neocomplcache_disabled_sources_list._, a:mode)
    if i == -1 | call add(g:neocomplcache_disabled_sources_list._, a:mode)
    else | call remove(g:neocomplcache_disabled_sources_list._, i)
    endif
endfunc
nnoremap <Leader>neo :call Neo_Toggle('omni_complete')<CR>
nnoremap <Leader>ned :call Neo_Toggle('dictionary_complete')<CR>
"inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "\<CR>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-e>  pumvisible() ? neocomplcache#close_popup(). "\<End>" : "\<End>"
inoremap <expr><BS>  neocomplcache#smart_close_popup()."\<C-h>"
au CursorMovedI,InsertLeave * if pumvisible() == 0| silent! pclose| endif        " auto close preview window
let g:neocomplcache_enable_at_startup = 0
let g:neocomplcache_use_vimproc = 4
"au Filetype python let g:neocomplcache_disable_auto_complete = 1                " to cooperate with jedi-vim
let g:neocomplcache_disable_auto_complete = 0
let g:neocomplcache_enable_auto_select = 0
let g:neocomplcache_sources_list = {}
let g:neocomplcache_sources_list._ = ['_']
let g:neocomplcache_disabled_sources_list = {"_" : ['dictionary_complete'], "txt": [] }
let g:neocomplcache_dictionary_filetype_lists = {'_' : $HOME . "/.vim/static/english_dict"}
let g:neocomplcache_auto_completion_start_length = 2
au Filetype txt let g:neocomplcache_auto_completion_start_length = 4
let g:neocomplcache_enable_camel_case_completion = 1
au Filetype txt let g:neocomplcache_enable_camel_case_completion = 0             " for speed
let g:neocomplcache_enable_smart_case = 0                                        " 'smartcase' don't support my lower-case dict
let g:neocomplcache_enable_underbar_completion = 1                               " a_b for axxb
let g:neocomplcache_enable_fuzzy_completion = 1
let g:neocomplcache_fuzzy_completion_start_length = 3
let g:neocomplcache_temporary_dir = $HOME . "/.vimtmp/neocomplcache"
let g:neocomplcache_text_mode_filetypes = {'txt': 1}
let g:neocomplcache_source_completion_length = {'omni_complete': '3'}
"let g:neocomplcache_enable_prefetch = 1
let g:neocomplcache_same_filetype_lists = {"_": "_"}
let g:neocomplcache_omni_patterns = {}
let g:neocomplcache_omni_functions= {}
let g:neocomplcache_omni_patterns.coffee = '[^. \t]\.\%(\h\w*\)\?'               " for nodejscomplete working in coffee
let g:neocomplcache_omni_patterns.r = '[[:alnum:].\\]\+'
let g:neocomplcache_omni_functions.r = 'rcomplete#CompleteR'
let g:neocomplcache_omni_patterns.java = '\h\w*\%(\.)\h\w*'
let g:neocomplcache_force_omni_patterns = {}

" These are useless since clang_complete are integrated in YCM
"let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w+'
"let g:neocomplcache_omni_patterns.cpp = g:neocomplcache_force_omni_patterns.cpp
"let g:clang_close_preview = 1
"let g:clang_user_options = '-std=c++11 -Iinclude -include include/*.*'          " the last is necessary to complete class member
"let g:clang_complete_macros = 1
"let g:clang_complete_copen = 1
"let g:clang_debug  = 1
"let g:clang_snippets = 1
"let g:clang_trailing_placeholder = 1

let g:jedi#use_tabs_not_buffers = 0
let g:jedi#rename_command = "<Leader>rn"

let g:sparkup = '~/.vim/bundle/sparkup/sparkup'
let g:sparkupExecuteMapping = '<C-z>'
" <C-n> to jump to next empty tag

let g:rubycomplete_buffer_loading = 0	" TODO
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

" ---------------------------------------------------------------------f]]
" Open Browser:
func Browser ()
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
" Some Small Functions:
" Copy,Backup,Evening,Nowrap,VirtualEdit,Line,Noh,Sync,pagejoin,pageq
nmap <Leader>cp :!xclip -i -selection clipboard % <CR><CR>
nnoremap <Leader>bk :!mkdir -p vim_backup; cp % vim_backup/%_bk --backup=numbered <CR>

nmap <Leader>ev :if exists('g:colors_name') && (g:colors_name != "default")<CR>colo default<CR>else<CR>colo aqua<CR>endif<CR><CR>
nmap <Leader>nw :set wrap!<CR>
nmap <Leader>rd :redraw!<CR>
nnoremap <Leader>-- o<C-R>=printf('%s%s', printf(&commentstring, ' '), repeat('-', 90))<CR><Home><Esc>
nnoremap <silent> <Leader>no :noh <CR>:call clearmatches()<CR>:silent! SearchBuffersReset<CR>
nmap <Leader>syn :vsplit<bar>wincmd l<bar>exe "norm! Ljz<c-v><cr>"<cr>:set scb<cr>:wincmd h<cr> :set scb<cr>

nnoremap <Leader>pj v}gJj0
nnoremap <leader>pq gqip

nnoremap <Leader>sd :! sdcv `echo <cword> \| sed -e 's/[^[:alnum:]]//g'` <CR>

nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" ---------------------------------------------------------------------
" Misc Plugins: f[[
" :ColorSchemeExplorer to use colorschemeexplorer
" <Leader>di / ds to use DrawIt
" <Leader>mar to mark
" :Rmodel / :Rcontroller ... to use rails
" surround: ds/cs in normal mode, s in visual mode
" :I in block-visual mode to use VisIncr
" <Leader>tt to Align latex table
" <Leader>t=  <Leader>T=  to Align = (left or right)
" <Leader>z/Z/iz to fold/restore/reverse_fold search result
" Tyank, Twrite, Tput to use tbone for tmux
" {count}zS to show highlight
let g:alternateSearchPath = 'sfr:../src,sfr:../include,sfr:../,sfr:./include'
command NOTE EvervimNotebookList
command Badapple so ~/.vim/badapple/badapple.vim
let g:EasyMotion_leader_key = ','
xmap s <Plug>VSurround
let g:html_indent_inctags = "body,head,tbody"

" <Leader>cv to use ColorV
let g:colorv_cache_file = $HOME . '/.vimtmp/colorv_cache_file'
let g:colorv_cache_fav = $HOME . '/.vimtmp/colorv_cache_fav'

let g:NERDCreateDefaultMappings = 0
nmap <Leader>cc <Plug>NERDCommenterSexy
xmap <Leader>cc <Plug>NERDCommenterSexy
nmap <Leader>cl <Plug>NERDCommenterAlignLeft
xmap <Leader>cl <Plug>NERDCommenterAlignLeft
nmap <Leader>uc <Plug>NERDCommenterUncomment
xmap <Leader>uc <Plug>NERDCommenterUncomment

let g:gitgutter_enabled = 0
nnoremap <Leader>gs :GitGutterEnable<CR>

if exists("*expand_region#custom_text_objects")
    call expand_region#custom_text_objects({
      \ "\/\\n\\n\<CR>": 1,
      \ 'a]' :1, 'ab' :1, 'aB' :1, 'a"' :1, 'a''': 1,
      \ 'ii' :0, 'ai' :0,
      \ 'ic' :0, 'ac' :0,
      \ }) | endif
xmap K <Plug>(expand_region_expand)
xmap J <Plug>(expand_region_shrink)

" Use * to Multiple Search word under cusor
nnoremap <silent> * :execute ':Search \<' . expand('<cword>') . '\>'<cr>
nnoremap <Leader>/ :Search<Space>
let g:MultipleSearchMaxColors = 16

let g:tmru_file = $HOME . "/.vimtmp/tmru_file"
nmap <Leader>ru :TRecentlyUsedFiles<CR>

let g:accelerated_jk_acceleration_limit = 500
let g:accelerated_jk_acceleration_table = [10, 20, 30, 35, 40, 45, 50]

nnoremap <Leader>gr :Regrep <CR><CR><CR><CR>
let Grep_Skip_Files = '.tags tags'

let g:fuf_keyOpenVsplit             = "<C-l>"
let g:fuf_keyOpenTabpage            = "<C-t>"
let g:fuf_buffer_keyDelete          = "<C-d>"
let g:fuf_autoPreview               = 1
let g:fuf_mrufile_maxItem           = 200
let g:fuf_modesDisable              = ['mrucmd', 'bookmarkfile', 'bookmarkdir', 'buffertag', 'help', 'dir']
let g:fuf_dataDir                   = '~/.vimtmp/vim-fuf-data'
let g:fuf_coveragefile_prompt       = '>Project[]>'
let g:fuf_coveragefile_globPatterns = ['**/.*', '**/*', '../*', '../.*']
let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|orig|swp|d)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
let g:fuf_coveragefile_exclude = '\v\~$|\.(o|exe|dll|bak|orig|swp|d)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|node_modules.*'
nmap <Leader>ff :FufFile<CR>
nmap <Leader>fp :FufCoverageFile<CR>
nmap <Leader>ft :FufTag<CR>
nmap <silent> <C-]> :FufTagWithCursorWord!<CR>
nmap <Leader>fr :FufMruFile<CR>
nmap <Leader>fb :FufBuffer<CR>
nmap <Leader>fl :FufLine<CR>
nmap <Leader>fj :FufJumpList<CR>
nmap <Leader>fc :FufChangeList<CR>
nmap <Leader>fw [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Use SSave, SLoad SDelete to restore session
let g:startify_session_dir = '~/.vimtmp/startify'
let g:startify_bookmarks = [ '~/.vimrc', '~/.zshrc', '~/.aliasrc']
let g:startify_skiplist = ['COMMIT_EDITMSG', 'doc/.*txt', 'git/index']

nmap <Leader>ps :call PinyinSearch()<CR>
nnoremap ? :call PinyinSearch()<CR>
nmap <Leader>pn :call PinyinNext()<CR>
let g:PinyinSearch_Dict = $HOME . "/.vim/bundle/PinyinSearch/PinyinSearch.dict"

"let g:syntastic_cpp_compiler         = 'clang++'
"let g:syntastic_cpp_compiler_options = ' -std=c++11 -fopenmp -Iinclude -DMAGICKCORE_HDRI_ENABLE=0 -DMAGICKCORE_QUANTUM_DEPTH=16 -DMAGICKCORE_HDRI_ENABLE=0 -DMAGICKCORE_QUANTUM_DEPTH=16 -DMAGICKCORE_HDRI_ENABLE=0 -DMAGICKCORE_QUANTUM_DEPTH=16 -I/usr/include/ImageMagick-6'
"let g:syntastic_loc_list_height      = 5
"let g:syntastic_stl_format           = "Err:%fe %e,%w"
"let g:syntastic_mode_map             = { 'mode': 'active', 'active_filetypes': [], 'passive_filetypes': ['html', 'zsh', 'tex', 'java', 'cpp'] }
"let g:syntastic_python_checker_args  = '--ignore=W402'
" f]]
" UI And Format Plugin: f[[
let g:DoxygenToolkit_briefTag_pre = "@Synopsis  "
let g:DoxygenToolkit_paramTag_pre = "@Param "
let g:DoxygenToolkit_returnTag    = "@Returns   "
let g:DoxygenToolkit_blockHeader  = "--------------------------------------------------------------------------"
let g:DoxygenToolkit_blockFooter  = "----------------------------------------------------------------------------"

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
nnoremap <leader>ig :IndentLinesToggle<CR>:set list! lcs=tab:\\|\<Space><CR>
" f]]

" Window Plugins: f[[
let g:win_width = 22
nmap <Leader>tl :TlistToggle <CR>
au Filetype cpp,c    nmap <Leader>tl :TagbarToggle<CR>
let Tlist_WinWidth                = g:win_width
let Tlist_Sort_Type               = 'name'
let Tlist_Exit_OnlyWindow         = 1
let Tlist_GainFocus_On_ToggleOpen = 0
let Tlist_Enable_Fold_Column      = 0

nmap <Leader>fm :NERDTreeToggle <CR>
let g:NERDTreeWinSize       = g:win_width
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeBookmarksFile = '~/.vim/NERDTreeBookmarks'
let g:NERDTreeHijackNetrw   = 0
let NERDTreeIgnore          = ['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']

nnoremap <Leader>wm :set splitright!<CR>:WMToggle <CR>:set splitright!<CR>:q<CR>:140wincmd <<CR><C-w>=
let g:winManagerWidth        = g:win_width
let g:persistentBehaviour    = 0
let g:winManagerWindowLayout = 'NERDTree|TagList'
let g:NERDTree_title         = "[NERDTree]"
func NERDTree_Start()
    exe 'NERDTree'
endfunc
func NERDTree_IsValid()
    return 1
endfunc

nmap <Leader>ut :GundoToggle<CR>
let g:gundo_width = g:win_width
let g:gundo_preview_bottom = 1

let g:pydoc_open_cmd = 'vsplit'
let g:pydoc_cmd = '/usr/bin/pydoc2'
let g:pydoc_highlight = 0                             " don't highlight searching word

let g:ConqueTerm_StartMessages = 0
let g:ConqueTerm_CWInsert = 1
nnoremap <Leader>ip :ConqueTermVSplit ipython2<CR>

" <LocalLeader>r to refresh output window
nnoremap ! :Clam<space>
vnoremap ! :ClamVisual<space>

let g:dwm_map_keys = 0
nmap <Leader>fo :call DWM_Focus()<CR>

" Use `:ScreenShell ipython` to open a parallel python shell
let g:ScreenImpl = 'Tmux'
let g:ScreenShellHeight = 20
let g:ScreenShellTerminal = g:my_term
nnoremap <LocalLeader>se :ScreenSend<CR>

" ---------------------------------------------------------------------f]]
" Mapping For Programming: (These should've been moved to ftplugin) f[[
func Tex_Block(label)
    let Blk_Dict={"e": "enumerate","d": "description", "m": "matrix", "c": "cases",
                \ "f": "figure", "t": "table", "tt": "tabular", "eq": "equation*", "mp": "minipage"}
	let blk_text = (has_key(Blk_Dict, a:label)) ? Blk_Dict[a:label ] : a:label
    call append(line('.') - 1,["\\begin{". blk_text ."}","","\\end{". blk_text ."}"])
    normal kk
    startinsert
endfunc
func Tex_Formula_init()
    inoremap <buffer> <c-f> \dfrac{}{}<Esc>2hi
    inoremap <buffer> <c-r> \sqrt{}<Left>
    inoremap <buffer> <c-Left> \Leftrightarrow<Space>
    inoremap <buffer> <c-Right> \Rightarrow<Space>
    inoremap <buffer> \left \left<Space>\right<Esc>5hi
    inoremap <buffer> ... \cdots<Space>

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
    inoremap <buffer> `R \mathbb{R}
    inoremap <buffer> `s \sigma
    inoremap <buffer> `v \varphi
endf
func Tex_init()
    setl nocursorline                                " for performance
    hi clear Conceal
    let &conceallevel=has("gui_running") ? 1: 2        " conceal problem for gvim
    setl concealcursor=
    setl sw=2 sts=2 expandtab
    setl textwidth=150
    setl errorformat=aaaaaaa                        " disable quickfix

    inoremap <buffer> $$ $<Space>$<Left>
    inoremap <buffer> " ``''<Left><Left>
    nmap <buffer> <Leader>" xi``<Esc>,f"axi''<Esc>
	call Tex_Formula_init()

    inoremap <buffer> \[ \[<Space>\]<Left><Left>
    inoremap <buffer> \{ \{<Space>\}<Left><Left>
    inoremap <buffer> \langle \langle<Space><Space>\rangle<Esc>7hi
    inoremap <buffer> \verb \verb<Bar><Bar><Left>
    inoremap <buffer> \beg \begin{}<Left>
    inoremap <buffer> \bb <Esc>:call Tex_Block("")<Left><Left>
    inoremap <buffer> \bbt <Esc>:call Tex_Block("t")<CR><Up><End>[H]<Down>\centering<CR>\caption{\label{tab:}}<Esc>k:call Tex_Block("tabular")<CR>
    inoremap <buffer> \bbf <Esc>:call Tex_Block("f")<CR><Up><End>[H]<Down>\centering<CR>\includegraphics[width=\textwidth]{res/}<CR>\caption{\label{fig:}}<Esc>
    inoremap <buffer> \bbm <Esc>:call Tex_Block("mp")<CR><Up><End>[b]{0.46\linewidth}<Down>\centering<CR>\includegraphics[width=\textwidth]{res/}<CR>\caption{\label{fig:}}<Esc>
    inoremap <buffer> \bf \textbf{}<Left>
    xmap <buffer> \bbe di\bbe<CR><Tab><Esc>pj
    xmap <buffer> \bbd di\bbd<CR><Tab><Esc>pj
    xmap <buffer> \bf s}i\textbf<Esc>
    xmap <buffer> \em s}i\emph<Esc>
    xmap <buffer> <Leader>tab :s/\s\+/ \&/g<CR>gv:s/$/\\\\/g<CR>gv<Space>tt

    let g:LatexBox_no_mappings = 1
    " Plugin: LaTeX-Box
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
endfunc
func C_grammar_init()
    inoremap <buffer> while<Space> while<Space>()<Left>
    inoremap <buffer> { {}<Left><CR><CR><Up><Tab>
    inoremap <buffer> if<Space> if<Space>()<Left>
    inoremap <buffer> for<Space> for<Space>()<Left>
endfunc
func C_init()
    "call textobj#user#plugin('cif', { 'code': {
    "\     'pattern': ['if ', '$'],
    "\     'select-i': 'if',
    "\   }})
    set tags+=~/.vim/static/cpp                        " core in cpp
    set tags+=/home/cpp_lib_tags                    " all libs
    abbr #i #include
    set syntax=cpp11.doxygen
    let &makeprg="clang++ % -g -Wall -Wextra -O0 -std=c++11 -o %<"
    call C_grammar_init()
    syn keyword cppType real_t Vec Vec2D Vector Matrix Plane Sphere Geometry Ray Color Img imgptr
    syn keyword cppSTL priority_queue hypot isnormal isfinite isnan shared_ptr make_shared numeric_limits move
    syn keyword cppSTLType T
    "setl ofu=ClangComplete
    "inoremap <c-[> <Esc>:python updateSnips()<CR>
endfunc
func Python_init()
    let &makeprg="pylint --reports=n --output-format=parseable %"
    setl expandtab
    setl ts=4 sw=4 sts=4
    setl textwidth=78
    set concealcursor=
    syn keyword pythonDecorator self
    nmap <buffer> <F8> :call Flake8()<CR>

    " Jedi work with neo:
    setl ofu=jedi#complete switchbuf=useopen
    inoremap <buffer> . .<C-X><C-O><C-P>
endfunc
func Ruby_init()
    let &makeprg="ruby -c %"
    imap <C-CR> <CR><CR>end<Esc>-cc
    setl expandtab
    setl ts=2 sw=2 sts=2
endfunc
func Java_init()
    let &makeprg="javac %"
    syn keyword javaType String Integer Double Pair Collection Collections List Boolean Triple ArrayList Entry LinkedList Map HashMap Set HashSet TreeSet TreeMap Iterator Iterable Comparator Arrays ListIterator
    let java_comment_strings = 1
    let java_mark_braces_in_parens_as_errors= 1
    let java_ignore_javadoc = 1
    let java_minlines = 150
    call C_grammar_init()
endfunc
func CS_init()
    call C_grammar_init()
    syn keyword csType var
endfunc
func Js_init()
    let &makeprg="node %"
    setl ts=2 sw=2 sts=2
    call C_grammar_init()
endfunc
au FileType tex :call Tex_init()
au FileType mkd :call Tex_Formula_init()
au FileType cpp,c,yacc,lex :call C_init()
au FileType cs :call CS_init()
au FileType python :call Python_init()
au FileType ruby :call Ruby_init()
au FileType java :call Java_init()
au FileType javascript :call Js_init()
au FileType r :call C_grammar_init()

" ---------------------------------------------------------------------f]]
" FileType Commands:
au BufWritePost .Xresources silent !xrdb %
au BufWritePost .tmux.conf silent !tmux source %
au BufRead tmux.conf,.tmux* setl ft=tmux
au BufNewFile,BufRead *.json setl ft=json syntax=txt
au BufNewFile,BufRead /tmp/dir*,/tmp/tmp* setl ft=txt syntax=txt   " for vidir
au BufWritePost,BufWrite __doc__ setl ft=txt
au BufNewFile,BufRead *.mako setl ft=mako
au BufNewFile,BufRead *.md,*.markdown setl ft=mkd
au BufNewFile,BufRead *.jade setl ft=jade
au BufNewFile,BufRead *.styl setl ft=stylus
au BufNewFile,BufRead *.ejs setl ft=ejs
au BufNewFile,BufRead *.gprof setl ft=gprof
au BufNewFile,BufReadPost *.slim setl ft=slim
au BufNewFile,BufRead *.txt,*.doc,*.pdf setl ft=txt
au BufReadPre *.doc,*.class,*.pdf setl ro
au BufReadPost *.doc silent %!antiword "%"
au BufRead *.class exe 'silent %!javap -c "%"' | setl ft=java
au BufReadPost *.pdf silent %!pdftotext -nopgbrk "%" -
au BufNewFile,BufRead *.lrc setl ft=lrc
au Filetype lrc :match Underlined /.\%45v.\+/
au Filetype lrc setl textwidth=45                                  " for display in iphone
au Filetype coffee setl omnifunc=nodejscomplete#CompleteJS
au Filetype coffee,jade setl expandtab
au Filetype vhdl,php,html,xml,zcml,yaml,json,coffee,jade setl tabstop=2 shiftwidth=2 softtabstop=2
au Filetype txt setl textwidth=200
let g:tex_flavor = 'latex'                                         " default filetype for tex
au FileType sh,zsh inoremap ` ``<Left>
au BufWritePost *
            \ if getline(1) =~ "^#!/bin/[a-z]*sh" |
            \   exe "silent !chmod a+x <afile>" |
            \ endif

"au UserGettingBored
