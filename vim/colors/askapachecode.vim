" Vim color file -- askapachecode
" Maintainer: AskApache <webmaster@askapache.com>
" Updated: Wed Feb 22 14:10:54 2012 by galileo@galileo

set t_Co=256
set background=dark
hi clear

if exists("syntax_on")|syntax reset|endif

let g:colors_name="askapachecode"

" Vim >= 7.0 specific colors
if version >= 700
 hi CursorLine ctermbg=236
 hi CursorColumn ctermbg=236
 hi MatchParen ctermfg=157 ctermbg=237 cterm=bold
 hi Pmenu ctermfg=255 ctermbg=238
 hi PmenuSel ctermfg=0 ctermbg=148
endif

" General colors
hi Cursor ctermbg=241
hi Normal ctermfg=253 ctermbg=232
hi NonText ctermfg=244 ctermbg=235
hi LineNr ctermfg=244 ctermbg=232
hi StatusLine ctermfg=253 ctermbg=238 cterm=italic
hi StatusLineNC ctermfg=246 ctermbg=238
hi VertSplit ctermfg=238 ctermbg=238
hi Folded ctermbg=4 ctermfg=248
hi Title ctermfg=254 cterm=bold
hi Visual ctermfg=254 ctermbg=4
hi SpecialKey ctermfg=244 ctermbg=236

hi pythonOperator ctermfg=103

hi Search cterm=NONE




" basic highlight groups (:help highlight-groups) {{{1

" text {{{2
hi Normal ctermfg=white ctermbg=black cterm=NONE
hi Folded ctermfg=lightgray ctermbg=black cterm=underline
hi LineNr ctermfg=darkgray ctermbg=NONE cterm=NONE
hi Directory ctermfg=cyan ctermbg=NONE cterm=NONE
hi NonText ctermfg=yellow ctermbg=NONE cterm=NONE
hi SpecialKey ctermfg=green ctermbg=NONE cterm=NONE

hi DiffAdd ctermfg=white ctermbg=darkblue cterm=NONE
hi DiffChange ctermfg=black ctermbg=darkmagenta cterm=NONE
hi DiffDelete ctermfg=black ctermbg=red cterm=bold
hi DiffText ctermfg=white ctermbg=green cterm=bold


" borders / separators / menus {{{2
hi FoldColumn ctermfg=lightgray ctermbg=darkgray cterm=NONE
hi SignColumn ctermfg=lightgray ctermbg=darkgray cterm=NONE
hi Pmenu ctermfg=white ctermbg=darkgray cterm=NONE
hi PmenuSel ctermfg=white ctermbg=lightblue cterm=NONE
hi PmenuSbar ctermfg=black ctermbg=black cterm=NONE
hi PmenuThumb ctermfg=gray ctermbg=gray cterm=NONE

hi StatusLine ctermfg=black ctermbg=white cterm=bold
hi StatusLineNC ctermfg=darkgray ctermbg=white cterm=NONE
hi WildMenu ctermfg=white ctermbg=darkblue cterm=bold
hi VertSplit ctermfg=white ctermbg=white cterm=NONE

"if &t_Co == 256|hi TabLine ctermfg=15 ctermbg=242 term=underline|else|hi TabLine ctermfg=grey ctermbg=white term=underline|endif
hi TabLine ctermfg=15 ctermbg=242 term=underline
"hi TabLine ctermfg=white ctermbg=white cterm=NONE
hi TabLineFill ctermfg=grey ctermbg=white cterm=NONE
"hi TabLineSel ctermfg=black ctermbg=green cterm=NONE
hi TabLineSel ctermfg=green ctermbg=black term=bold
"hi TabLineSel term=bold cterm=bold
"hi TabLineFill term=reverse cterm=reverse
"hi TabLine term=underline cterm=underline ctermfg=15 ctermbg=242

"hi Menu
"hi Scrollbar
"hi Tooltip


" cursor / dynamic / other {{{2
hi Cursor ctermfg=black ctermbg=white cterm=NONE
hi CursorIM ctermfg=black ctermbg=white cterm=reverse
hi CursorLine ctermfg=NONE ctermbg=NONE cterm=NONE
hi CursorColumn ctermfg=NONE ctermbg=NONE cterm=NONE

hi Visual ctermfg=white ctermbg=lightblue cterm=NONE
hi IncSearch ctermfg=white ctermbg=yellow cterm=NONE
hi Search ctermfg=white ctermbg=darkgreen cterm=NONE


" LISTINGS / MESSAGES {{{2
hi ModeMsg ctermfg=yellow ctermbg=NONE cterm=NONE
hi Title ctermfg=red ctermbg=NONE cterm=bold
hi Question ctermfg=green ctermbg=NONE cterm=NONE
hi MoreMsg ctermfg=green ctermbg=NONE cterm=NONE
hi ErrorMsg ctermfg=white ctermbg=red cterm=bold
hi WarningMsg ctermfg=yellow ctermbg=NONE cterm=bold

hi Directory term=bold ctermfg=4 "{{{
hi ErrorMsg term=standout ctermfg=15 ctermbg=1
hi IncSearch term=reverse cterm=reverse
hi Search term=NONE ctermfg=255 ctermbg=135
hi MoreMsg term=bold ctermfg=2
hi ModeMsg term=bold cterm=bold
hi LineNr term=underline ctermfg=244 ctermbg=232
hi Question term=standout ctermfg=2
hi StatusLine term=bold,reverse cterm=italic ctermfg=253 ctermbg=238
hi StatusLineNC term=reverse cterm=reverse ctermfg=246 ctermbg=238
hi VertSplit term=reverse cterm=reverse ctermfg=238 ctermbg=238
hi Title term=bold cterm=bold ctermfg=254
hi Visual term=reverse ctermfg=254 ctermbg=4
hi VisualNOS term=bold,underline cterm=bold,underline
hi WarningMsg term=standout ctermfg=1
hi WildMenu term=standout ctermfg=0 ctermbg=11
hi Folded term=standout cterm=BOLD ctermfg=7 ctermbg=27
hi FoldColumn term=NONE cterm=NONE ctermfg=75 ctermbg=16
hi IncSearch term=bold,underline cterm=bold,underline ctermfg=7 ctermbg=9
hi DiffAdd term=bold ctermbg=12
hi DiffChange term=bold ctermbg=13
hi DiffDelete term=bold ctermfg=12 ctermbg=14
hi DiffText term=reverse cterm=bold ctermbg=9
hi SpellBad term=reverse ctermbg=9
hi SpellCap term=reverse ctermbg=12
hi SpellRare term=reverse ctermbg=13
hi SpellLocal term=underline ctermbg=14
hi Pmenu ctermfg=255 ctermbg=238
hi PmenuSel ctermfg=0 ctermbg=148
hi PmenuSbar ctermbg=7
hi PmenuThumb cterm=reverse
hi TabLine term=underline cterm=underline ctermfg=0 ctermbg=7
hi TabLineSel term=bold cterm=bold
hi TabLineFill term=reverse cterm=reverse
hi CursorLine term=underline cterm=bold ctermbg=234
hi Cursor ctermbg=241
hi MatchParen term=reverse cterm=bold ctermfg=157 ctermbg=237
hi Error term=reverse ctermfg=15 ctermbg=9





" :hi TabLineSel|hi TabLineFill|hi TabLine
"hi TabLineSel term=bold cterm=bold
"hi TabLineFill term=reverse cterm=reverse
"hi TabLine term=underline cterm=underline ctermfg=15 ctermbg=242
hi ExtraWhitespace ctermbg=red
hi Comment term=none ctermfg=darkgrey
hi Constant term=underline ctermfg=Magenta
hi Special term=bold ctermfg=DarkMagenta
hi Identifier term=underline cterm=bold ctermfg=Cyan
hi Statement term=bold ctermfg=Yellow
hi PreProc term=underline ctermfg=LightBlue
hi Type term=underline ctermfg=LightGreen
hi Repeat term=underline ctermfg=White
hi Operator ctermfg=Red
hi Ignore ctermfg=black
hi Error term=reverse ctermbg=Red ctermfg=White
hi Todo term=standout ctermbg=Yellow ctermfg=Black



" COMMON GROUPS THAT LINK TO DEFAULT HIGHLIGHTING.

hi Function ctermfg=85
hi String ctermfg=204
hi Statement term=bold cterm=bold ctermfg=81
hi Function term=bold cterm=bold ctermfg=32
hi Number ctermfg=129
hi Conditional term=bold cterm=bold ctermfg=47
hi Special term=underline ctermfg=191
hi Normal ctermfg=7
hi PreProc ctermfg=141
" Syntax highlighting
hi Comment ctermfg=244
hi Todo ctermfg=245
hi Boolean ctermfg=148
hi String ctermfg=148
hi Identifier ctermfg=148
hi Function ctermfg=124
hi Type ctermfg=103
hi Statement ctermfg=103
hi Keyword ctermfg=81
hi Constant ctermfg=81
hi Number ctermfg=81
hi Special ctermfg=81
hi PreProc ctermfg=230
" Code-specific colors


" SYNTAX HIGHLIGHTING GROUPS (:HELP GROUP-NAME) {{{2
hi FoldColumn ctermbg=0 ctermfg=2
hi Folded cterm=none ctermfg=2
hi NonText cterm=NONE ctermfg=NONE
hi StatusLine ctermfg=black ctermbg=White cterm=bold
hi StatusLineNC ctermfg=White ctermbg=green cterm=NONE
hi CursorLine cterm=bold term=bold

" FINAL THOUGHTS "{{{2
"syn region myFold start="{" end="}" transparent fold
hi Search term=reverse ctermfg=0 ctermbg=11
hi LineNr term=underline ctermfg=244 ctermbg=232
hi MatchParen ctermfg=15 ctermbg=242
hi String ctermfg=10
hi Constant ctermfg=14
hi Identifier ctermfg=14
hi Operator ctermfg=13
hi NonText cterm=NONE ctermfg=NONE
hi Search cterm=bold ctermbg=99 ctermfg=17
