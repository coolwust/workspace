set number
set colorcolumn=80
set hlsearch
set tabpagemax=30
set wildmode=longest,list

" How many columns a <tab> character counts for in vim editor, whereas <space>
" character is always counts for one column.
set tabstop=4

" How many columns text is indented when you press >>, <<, ==, may mix <tab> and
" <space> characters to archive appropriate amount of columnes.
set shiftwidth=4

" How many columns when you press a tab key, may mix <tab> and <space> characters
" to archive appropriate amount of columnes.
set softtabstop=4

" Always use <space> characters in 'shiftwidth' and 'softtabstop' and any other
" keystrokes depending on those two (i_ctrl-T and i_ctrl-D depends on shiftwidth).
set expandtab

" Does nothing more than copy the indentation from the previous line, when
" starting a new line.
set autoindent

" Copy the structure of the existing lines indent when autoindenting a new line.
set copyindent

autocmd FileType yaml setlocal shiftwidth=2
autocmd FileType pug setlocal shiftwidth=2
autocmd FileType javascript setlocal shiftwidth=2
autocmd FileType json setlocal shiftwidth=2
autocmd FileType html setlocal shiftwidth=2
autocmd FileType sh setlocal shiftwidth=2
autocmd FileType css setlocal shiftwidth=2
autocmd FileType scss setlocal shiftwidth=2
autocmd FileType go setlocal tabstop=4 softtabstop=4 noexpandtab
autocmd FileType make setlocal tabstop=4 softtabstop=4 noexpandtab
autocmd FileType typescript setlocal shiftwidth=2
autocmd FileType dockerfile setlocal tabstop=4 softtabstop=4 noexpandtab
" autocmd FileType go autocmd BufWritePost * silent !go fmt %
" autocmd BufRead *.sh set ft=

" The peachpuff colorscheme overrides the highlight, so we have to override it
" in autocmd. Also we use the color in numbers, as the color in name does not
" work properly.
autocmd ColorScheme peachpuff highlight MatchParen cterm=none ctermbg=none ctermfg=9
autocmd ColorScheme peachpuff highlight ColorColumn cterm=none ctermfg=none ctermbg=8
autocmd ColorScheme peachpuff highlight Folded cterm=none ctermfg=none ctermbg=8

colorscheme peachpuff
syntax on

" It automatically inserts one extra level of indentation in some cases.
" set smartindent

" It hides buffers instead of closing them. This means that you can have unwritten
" changes to a file and open a new file using :e without being forced to write
" or undo your changes first. Also, undo buffers and marks are preserved while
" the buffer is open.
" set hidden
