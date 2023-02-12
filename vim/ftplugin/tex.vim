if exists("b:did_ftplugin")
  finish
endif

let g:tex_flavor = 'latex'                                         " default filetype for tex

setl nocursorline                                " for performance
hi clear Conceal
let &conceallevel=has("gui_running") ? 1: 2        " conceal problem for gvim
set concealcursor=
setl textwidth=99999
set makeef=/dev/null

inoremap <buffer> $$ $<Space>$<Left>
inoremap <buffer> " ``''<Left><Left>
nmap <buffer> <Leader>" xi``<Esc>,f"axi''<Esc>
inoremap <buffer> ... \cdots<Space>

func! Tex_Block(label)
  let Blk_Dict={"e": "enumerate","d": "description", "m": "matrix", "c": "cases",
        \ "f": "figure", "t": "table", "tt": "tabular", "eq": "equation*", "mp": "minipage"}
  let blk_text = (has_key(Blk_Dict, a:label)) ? Blk_Dict[a:label ] : a:label
  call append(line('.') - 1,["\\begin{". blk_text ."}","","\\end{". blk_text ."}"])
  normal kk
  startinsert
endfunc

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

" auto refresh preview
" au BufWritePost *.tex call jobstart("make try")
