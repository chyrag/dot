" $Id: dot.vimrc 461545 2011-08-21 06:42:06Z ib-builder $
"
" Format code the Juniper way
"
set tabstop=8
set softtabstop=4
set shiftwidth=4

" my own settings (chirag)
set backspace=2 laststatus=2 incsearch autowrite autoindent nobackup
set joinspaces magic report=0 nomodeline showcmd ruler visualbell
set dictionary=/usr/share/dict/words

" Do not set "expandtabs", it will prevent you from properly formatting code.
set noexpandtab

" Format code the Juniper way (for *.c and *.h only)
"
set cinoptions=(0

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  if v:version > 600
    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on
  endif

  autocmd BufNewFile,BufReadPre,BufEnter,FileReadPre *.c,*.c[cpx]?[px]?,*.h[px]?  set wrap cin ai

  " For all text files set 'textwidth' to 79 characters.
  autocmd FileType text setlocal textwidth=79
  autocmd BufNewFile,BufRead *.txt setlocal textwidth=79

  " DDL/ODL/errmsg files should follow c plugins
  autocmd BufNewFile,BufRead *.dd     setf c
  autocmd BufNewFile,BufRead *.odl    setf c
  autocmd BufNewFile,BufRead *.errmsg setf c
endif " has("autocmd")


" Format KNF [kernel normal form] (see 'man style') for FreeBSD based code.
"  autocmd Bufenter,BufNewFile,BufReadPre,FileReadPre *.c,*.c[cpx]?[px]?,*.h[px]?[px]? set tabstop=8
"  autocmd Bufenter,BufNewFile,BufReadPre,FileReadPre *.c,*.c[cpx]?[px]?,*.h[px]?[px]? set formatoptions="croql"
"  autocmd Bufenter,BufNewFile,BufReadPre,FileReadPre *.c,*.c[cpx]?[px]?,*.h[px]?[px]? set cinoptions=':0,>2s,n0,e0,p2s,(2s,t0,=2s'
"  autocmd Bufenter,BufNewFile,BufReadPre,FileReadPre *.c,*.c[cpx]?[px]?,*.h[px]?[px]? set comments=sr:/*,mb:*,el:*/,://


" Make  <ESC>:make  work as expected.
set makeprg=mk

set tags=/volume/build/junos/head/daily/current/TAGS

set showmode

" Syntax
syntax on

" code keywords (for, while, return etc) are ugly yellow and dark blue,
" which look okay on a light background, but unbearable on a dark background.
" The following changes the C statements to green, and comments to `brown' which
" looks like more like dull yellow to me
hi Statement    term=bold cterm=NONE ctermfg=DarkGreen ctermbg=NONE gui=bold guifg=#ffff60 guibg=NONE
hi Comment      term=bold cterm=NONE ctermfg=brown     ctermbg=NONE gui=bold guifg=#ffff60 guibg=NONE

" Make "show list" more useful.
set listchars+=tab:^-
set listchars+=trail:`

" The C code keywords (for, while, return etc) are ugly yellow and dark blue,
" which look okay on a light background, but unbearable on a dark background.
" The following changes the C statements to green, and comments to `brown' which
" looks like more like dull yellow to me
"hi Statement    term=bold cterm=NONE ctermfg=DarkGreen ctermbg=NONE gui=bold guifg=#ffff60 guibg=NONE
"hi Comment      term=bold cterm=NONE ctermfg=brown     ctermbg=NONE gui=bold guifg=#ffff60 guibg=NONE

" The following bindings require vcscommand.vim which is available at
" http://www.vim.org/scripts/script.php?script_id=90
nnoremap <silent> <F7> :VCSDiff<CR>
nnoremap <silent> <F9> :VCSBlame<CR>

"
" Macro to format text: maps C-f
" WARNING: do not use this if you use Control-F to move around
"
map <C-f> gqapk$
map! <C-f> <ESC>gqapkA
map <C-q> bi'<ESC>wwhi'<ESC>
map! <C-q> <ESC>bi'<ESC>wwhi'

