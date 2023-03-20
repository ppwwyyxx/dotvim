" About Chinese:
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
  let chinese={"（" : "(" , "）" : ")" , "，" : ",", "；" : ";", "：" : ":","？" : "?", "！" : "!", "“" : "\"", "’" : "'" , "”" : "\"", "℃" : "\\\\textcelsius", "μ" : "$\\\\mu$"}
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
autocmd InsertEnter * call Fcitx_enter()
