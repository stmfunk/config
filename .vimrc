filetype on
"filetype plugin on
"filetype indent on " file type based indentation

" Incremental Search selects the best match as you type
set incsearch

" Hides buffers instead of closing them preserving undo
set hidden

" Turn on the modeline checking
set modelines=3

" Ignore all cases in search
set noignorecase

"  Smartly identifies the case off your search if all lowercase matches any case
set smartcase

" Turn on syntax highlighting
syntax on

" Turn on search highlightin
set hlsearch

" Remove line wrapping (EXCELLENT!)
set nowrap

" Set tabs to be two spaces
set tabstop=4

" Replace tabs with spaces
set shiftwidth=4
set expandtab

" Sets filetype specific plugins
"filetype plugin indent on

" Set line numbers to be on. nonumber off"
set number

" To fix the vim multiple undo
set nocompatible

" To display the little line by character ruler in corner"
set ruler

" Smart indenting. We enabled this in order to make html indent correctly"
set smartindent

"This bit will set the tabs ti be normal tabs for make files
"autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

"This bit will set the tabs ti be normal tabs for make files
"autocmd FileType haskell set expandtab tabstop=8 shiftwidth=4 softtabstop=4 smarttab shiftround nojoinspaces 

" This configures vim to work for prolog files, with the .pro extension
autocmd BufNewFile,BufRead *.pro set filetype=prolog

" This fixes a problem where backspace won't go back over newline
set backspace=eol,indent,start
" Incremental Search selects the best match as you type
set incsearch
" Ignore all cases in search
set noignorecase
"  Puts a four space buffer around the cursor
set scrolloff=4

" Sets filetype specific plugins
filetype plugin indent on

map <Enter> o<ESC>
map gb :bnext<Enter>
map gB :bprev<Enter>

command W w

" This garbage is for alterring the way tabs are visualised but I have
" refined my use of tabs in recent times
"if has('gui')
"set guioptions-=e
"endif
"if exists("+showtabline")
"function MyTabLine()
"let s = ''
"let t = tabpagenr()
"let i = 1
"while i <= tabpagenr('$')
"let buflist = tabpagebuflist(i)
"let winnr = tabpagewinnr(i)
"let s .= '%' . i . 'T'
"let s .= (i == t ? '%1*' : '%2*')
"let s .= ' '
"let s .= i . ':'
"let s .= winnr . '/' . tabpagewinnr(i,'$')
"let s .= ' %*'
"let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
"let bufnr = buflist[winnr - 1]
"let file = bufname(bufnr)
"let buftype = getbufvar(bufnr, 'buftype')
"if buftype == 'nofile'
"if file =~ '\/.'
"let file = substitute(file, '.*\/\ze.', '', '')
"endif
"else
"let file = fnamemodify(file, ':p:t')
"endif
"if file == ''
"let file = '[No Name]'
"endif
"let s .= file
"let i = i + 1
"endwhile
"let s .= '%T%#TabLineFill#%='
"let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
"return s
"endfunction
"set stal=2
"set tabline=%!MyTabLine()
"endif

