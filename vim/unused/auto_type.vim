python <<EOF
import os
fptr = None
fname = os.getenv("HOME") + '/package'
def append_char():
	import vim
	global fptr
	if fptr is None:
		fptr = open(fname)

	c = vim.current
	ch = fptr.read(1)
	if ch == '\n':
		c.buffer.append('')
	else:
		c.buffer[-1] += ch
	c.window.cursor = (len(c.buffer), len(c.buffer[-1]))
EOF

fun Domap()
	inoremap<silent> a <ESC>:python append_char() <CR>i
	inoremap<silent> b <ESC>:python append_char() <CR>i
	inoremap<silent> c <ESC>:python append_char() <CR>i
	inoremap<silent> d <ESC>:python append_char() <CR>i
	inoremap<silent> e <ESC>:python append_char() <CR>i
	inoremap<silent> f <ESC>:python append_char() <CR>i
	inoremap<silent> g <ESC>:python append_char() <CR>i
	inoremap<silent> h <ESC>:python append_char() <CR>i
	inoremap<silent> i <ESC>:python append_char() <CR>i
	inoremap<silent> j <ESC>:python append_char() <CR>i
	inoremap<silent> k <ESC>:python append_char() <CR>i
	inoremap<silent> l <ESC>:python append_char() <CR>i
	inoremap<silent> m <ESC>:python append_char() <CR>i
	inoremap<silent> n <ESC>:python append_char() <CR>i
	inoremap<silent> o <ESC>:python append_char() <CR>i
	inoremap<silent> p <ESC>:python append_char() <CR>i
	inoremap<silent> q <ESC>:python append_char() <CR>i
	inoremap<silent> r <ESC>:python append_char() <CR>i
	inoremap<silent> s <ESC>:python append_char() <CR>i
	inoremap<silent> t <ESC>:python append_char() <CR>i
	inoremap<silent> u <ESC>:python append_char() <CR>i
	inoremap<silent> v <ESC>:python append_char() <CR>i
	inoremap<silent> w <ESC>:python append_char() <CR>i
	inoremap<silent> x <ESC>:python append_char() <CR>i
	inoremap<silent> y <ESC>:python append_char() <CR>i
	inoremap<silent> z <ESC>:python append_char() <CR>i
	inoremap<silent> ; <ESC>:python append_char() <CR>i
	inoremap<silent> ' <ESC>:python append_char() <CR>i
	inoremap<silent> , <ESC>:python append_char() <CR>i
	inoremap<silent> . <ESC>:python append_char() <CR>i
	inoremap<silent> [ <ESC>:python append_char() <CR>i
	inoremap<silent> ] <ESC>:python append_char() <CR>i
	inoremap<silent> <CR> <ESC>:python append_char() <CR>i
	inoremap<silent> \ <ESC>:python append_char() <CR>i
	inoremap<silent> <space> <ESC>:python append_char() <CR>i
endfun
