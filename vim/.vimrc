" The MIT License (MIT)
" 
" Copyright (c) 2014 Neil H Watson
" 
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
" 
" The above copyright notice and this permission notice shall be included in all
" copies or substantial portions of the Software.
" 
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
" SOFTWARE.

set cursorline
set cursorcolumn
set directory=$HOME/.vim/swap//
set history=50
set ruler
set tabstop=8
set softtabstop=3
set shiftwidth=3
set shiftround
set expandtab
set modeline
set autoindent
set undolevels=100
set showmatch
set showcmd
set number
set textwidth=0
set colorcolumn=78
" for fancy status line plugins
set laststatus=2

let mapleader = "s"

"
" Plugins
"
call plug#begin('~/.vim/plugged')

Plug 'nielsmadan/harlequin'
Plug 'itchyny/lightline.vim'
Plug 'w0rp/ale'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

call plug#end()
" Install with:
":PlugInstall
" Update with:
":PlugUpgrade
"
" End of plugins
"

" autowrite buffer on suspend, buffer switch etc...
set autowrite

colorscheme harlequin

"for scp
"set nocp
let g:netrw_silent=1


"date stamps
"Sunday January 02 2008.
iab dmy  <c-r>=strftime("%A %B %d %Y")<cr>
"20080102
iab ymd  <c-r>=strftime("%Y%m%d")<cr>
"02:32:22
iab hms  <c-r>=strftime("%H:%M:%S")<cr> 

" misc abbs
iab CFE CFEngine

au BufRead,BufNewFile */journal/*.txt set textwidth=78 spell
au BufRead,BufNewFile Makefile* set noexpandtab
"au BufRead,BufNewFile *.py set noexpandtab

" Add help tags
":helptags ~/.vim/doc/
let g:EnableCFE3KeywordAbbreviations=1

"===================================
"FUNCTIONS
"===================================

fun! Getchar()
  let c = getchar()
  if c != 0
    let c = nr2char(c)
  endif
  return c
endfun

fun! Eatchar(pat)
   let c = Getchar()
   return (c =~ a:pat) ? '' : c
endfun

" for aligning equals or fat commas.
if !exists("*Nhw_equal_aligner")
function Nhw_equal_aligner (AOP)
    "Patterns needed to locate assignment operators...
    let ASSIGN_OP   = '=>\?'
    let ASSIGN_LINE = '^\(.\{-}\)\s*\(' . ASSIGN_OP . '\)'

    "Locate block of code to be considered (same indentation, no blanks)
    let indent_pat = '^' . matchstr(getline('.'), '^\s*') . '\S'
    let firstline  = search('^\%('. indent_pat . '\)\@!','bnW') + 1
    let lastline   = search('^\%('. indent_pat . '\)\@!', 'nW') - 1
    if lastline < 0
        let lastline = line('$')
    endif

    "Find the column at which the operators should be aligned...
    let max_align_col = 0
    let max_op_width  = 0
    for linetext in getline(firstline, lastline)
        "Does this line have an assignment in it?
        let left_width = match(linetext, '\s*' . ASSIGN_OP)

        "If so, track the maximal assignment column and operator width...
        if left_width >= 0
            let max_align_col = max([max_align_col, left_width])

            let op_width      = strlen(matchstr(linetext, ASSIGN_OP))
            let max_op_width  = max([max_op_width, op_width+1])
         endif
    endfor

    "Code needed to reformat lines so as to align operators...
    let FORMATTER = '\=printf("%-*s%*s", max_align_col, submatch(1),
    \                                    max_op_width,  submatch(2))'

    " Reformat lines with operators aligned in the appropriate column...
    for linenum in range(firstline, lastline)
        let oldline = getline(linenum)
        let newline = substitute(oldline, ASSIGN_LINE, FORMATTER, "")
        call setline(linenum, newline)
    endfor
endfunction
endif

"
" My maps
"
augroup Java
   autocmd!
   " Box comments
   autocmd Filetype java,groovy nnoremap <buffer> <leader>mc
      \ !!boxes -d java-cmt<cr>
   autocmd Filetype java,groovy vnoremap <buffer> <leader>mc
      \ !boxes -d java-cmt<CR>
   " Remove comments
   autocmd Filetype java,groovy nnoremap <buffer> <leader>xc
      \ !!boxes -r -d java-cmt<CR>
   autocmd Filetype java,groovy vnoremap <buffer> <leader>xc
      \ !boxes -r -d java-cmt<CR>
augroup END

augroup Shell
   autocmd!
   " Box comments
   autocmd Filetype text,yaml,sh,shell,markdown nnoremap <buffer> 
      \ <leader>mc !!boxes -d shell<CR>
   autocmd Filetype text,yaml,sh,shell,markdown vnoremap <buffer> 
      \ <leader>mc !boxes -d shell<CR>
   " Remove comments
   autocmd Filetype text,yaml,sh,shell,markdown nnoremap <buffer> 
      \ <leader>xc !!boxes -r -d shell<CR>
   autocmd Filetype text,yaml,sh,shell,markdown vnoremap <buffer>
      \  <leader>xc !boxes -r -d shell<CR>
augroup END


" update file
nnoremap <leader>u :update<CR>

" splits and windows
" vsplit
nnoremap <leader>v :vsplit<CR>
" move right to next window
nnoremap <leader>l <C-w>l
" move left to next window
nnoremap <leader>h <C-w>h
" swap between splits
nnoremap <leader>x <C-w>x
" equi-space vsplits
nnoremap <leader>= <C-w>=
" Make help window vsplit
autocmd FileType help wincmd L

" buffer control using CtrlP plugin
nnoremap ; :CtrlPBuffer<CR>

" clipboard maps
" yank to system clipboard
nnoremap <leader>c "+y<CR>
" yank buffer to system clipboard
nnoremap <leader>ca :%y+<CR>
" paste from system clipboard
nnoremap <leader>p "+gp

" next and previous errors
noremap <leader>[ :lprevious<CR>
noremap <leader>] :lnext<CR>

" Run buffer on write when enabled
command! Autorun   au BufWritePost <buffer> !%:p
command! Noautorun au! BufWritePost <buffer>
nnoremap <leader>r :!%:p<CR>

" Custom files
"source ~/.vim/autoclosing.vim
