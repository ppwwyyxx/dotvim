if exists("b:did_ftplugin")
  finish
endif

setl textwidth=90
setl expandtab
iabbr ipeb import IPython as IP; IP.embed()
syn keyword pythonDecorator self
nmap <buffer> <F8> :ALEFix<CR>

" VSCode specifics:
if exists('g:vscode')
  let g:python_recommended_style = 0  " https://github.com/asvetliakov/vscode-neovim/issues/152
  au FileType python nnoremap <Leader>rr :call VSCodeNotify('python.execInTerminal')<CR>
endif

" Google style:
" set ts=2 sw=2 sts=2
" let g:python_recommended_style = 0


if executable('pyright')
lua << END
  -- https://github.com/microsoft/pyright/blob/main/docs/settings.md
  -- https://github.com/microsoft/pyright/blob/main/docs/configuration.md
	require'lspconfig'.pyright.setup{
    settings = { python = { analysis = {
      diagnosticMode = 'openFilesOnly',  -- save resource https://github.com/microsoft/pyright/issues/128
      diagnosticSeverityOverrides = {
        reportPrivateImportUsage = 'none', analyzeUnannotatedFunctions = 'false',

        reportOptionalMemberAccess = 'none', reportOptionalSubscript = 'none', reportOptionalCall = 'none',
        reportOptionalIterable = 'none', reportOptionalOperand = 'none', reportOptionalContextManager = 'none'
      },
      typeCheckingMode = 'off'  -- or 'basic'
    } } }
  }
END
endif
