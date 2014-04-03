python <<EOF
import os
fptr = None
fname = os.getenv("HOME") + '/.vimrc'
def append_char():
	import vim
	global fptr
	if fptr is None:
		fptr = open(fname)

	for _ in range(2):
		c = vim.current
		ch = fptr.read(1)
		if ch == '\n':
			c.buffer.append('')
		else:
			c.buffer[-1] += ch
		c.window.cursor = (len(c.buffer), len(c.buffer[-1]))
EOF

fun DoAutoType()
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
	inoremap<silent> A <ESC>:python append_char() <CR>i
	inoremap<silent> B <ESC>:python append_char() <CR>i
	inoremap<silent> C <ESC>:python append_char() <CR>i
	inoremap<silent> D <ESC>:python append_char() <CR>i
	inoremap<silent> E <ESC>:python append_char() <CR>i
	inoremap<silent> F <ESC>:python append_char() <CR>i
	inoremap<silent> G <ESC>:python append_char() <CR>i
	inoremap<silent> H <ESC>:python append_char() <CR>i
	inoremap<silent> I <ESC>:python append_char() <CR>i
	inoremap<silent> J <ESC>:python append_char() <CR>i
	inoremap<silent> K <ESC>:python append_char() <CR>i
	inoremap<silent> L <ESC>:python append_char() <CR>i
	inoremap<silent> M <ESC>:python append_char() <CR>i
	inoremap<silent> N <ESC>:python append_char() <CR>i
	inoremap<silent> O <ESC>:python append_char() <CR>i
	inoremap<silent> P <ESC>:python append_char() <CR>i
	inoremap<silent> Q <ESC>:python append_char() <CR>i
	inoremap<silent> R <ESC>:python append_char() <CR>i
	inoremap<silent> S <ESC>:python append_char() <CR>i
	inoremap<silent> T <ESC>:python append_char() <CR>i
	inoremap<silent> U <ESC>:python append_char() <CR>i
	inoremap<silent> V <ESC>:python append_char() <CR>i
	inoremap<silent> W <ESC>:python append_char() <CR>i
	inoremap<silent> X <ESC>:python append_char() <CR>i
	inoremap<silent> Y <ESC>:python append_char() <CR>i
	inoremap<silent> Z <ESC>:python append_char() <CR>i
	inoremap<silent> ; <ESC>:python append_char() <CR>i
	inoremap<silent> ' <ESC>:python append_char() <CR>i
	inoremap<silent> , <ESC>:python append_char() <CR>i
	inoremap<silent> . <ESC>:python append_char() <CR>i
	inoremap<silent> [ <ESC>:python append_char() <CR>i
	inoremap<silent> ] <ESC>:python append_char() <CR>i
	inoremap<silent> <CR> <ESC>:python append_char() <CR>i
	inoremap<silent> \ <ESC>:python append_char() <CR>i
	inoremap<silent> <space> <ESC>:python append_char() <CR>i

	inoremap<silent> 1  <ESC>:python append_char() <CR>i
	inoremap<silent> 2  <ESC>:python append_char() <CR>i
	inoremap<silent> 3  <ESC>:python append_char() <CR>i
	inoremap<silent> 4  <ESC>:python append_char() <CR>i
	inoremap<silent> 5  <ESC>:python append_char() <CR>i
	inoremap<silent> 6  <ESC>:python append_char() <CR>i
	inoremap<silent> 7  <ESC>:python append_char() <CR>i
	inoremap<silent> 8  <ESC>:python append_char() <CR>i
	inoremap<silent> 9  <ESC>:python append_char() <CR>i
	inoremap<silent> 0  <ESC>:python append_char() <CR>i
endfun
