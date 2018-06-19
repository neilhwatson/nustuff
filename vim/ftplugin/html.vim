"===================================
"HTML SECTION
"===================================

set matchpairs+=<:>
:syntax match xComment /<!.*/

" Box comments
nnoremap <buffer> <leader>mc !!boxes -d html-cmt<CR>
vnoremap <buffer> <leader>mc !boxes -d html-cmt<CR>
" Remove comments
nnoremap <buffer> <leader>xc !!boxes -r -d html-cmt<CR>
vnoremap <buffer> <leader>xc !boxes -r -d html-cmt<CR>

"html comment current line
map ,c I<!--<ESC>A--><ESC>

"html header
map ,h i<html><CR><head><CR><meta name="keywords" content=""><CR><meta name="Author" content="Neil H Watson"><CR><title></title><CR></head><CR><body><CR><ESC>:3>3<CR>

"html footer
map ,f :i</body><CR></html><C-C>

"create html header lines (h1 to h6)
nmap ,1 <HOME>v$"zdi<h1><ESC>"zp$a</h1><ESC>
nmap ,2 <HOME>v$"zdi<h2><ESC>"zp$a</h2><ESC>
nmap ,3 <HOME>v$"zdi<h3><ESC>"zp$a</h3><ESC>
nmap ,4 <HOME>v$"zdi<h4><ESC>"zp$a</h4><ESC>
nmap ,5 <HOME>v$"zdi<h5><ESC>"zp$a</h5><ESC>
nmap ,6 <HOME>v$"zdi<h6><ESC>"zp$a</h6><ESC>

"create html list items
nmap ,l vip :s/^\(.*\)$/\t<li>\1<\/li>/g<CR><C-C>:noh<CR>

"add html bold tags
vmap ,b "zdi<b><ESC>"zpgviw<ESC>a</b><ESC>

"add html code tags
vmap ,c "zdi<code><ESC>"zp<ESC>a</code><ESC>

"add html name tags
vmap ,n "zdi<name="<ESC>"zp<ESC>a"></a><ESC>

"add html paragraph tags
nmap ,p <HOME>v$"zdi<p><ESC>"zp$a</p><ESC>

"create html table from ;; delimited table
nmap ,t vip :s/^/<tr>/<CR> gv :s/$/<\/tr>/<CR> gv :s/<tr>/<tr>\r\t<td>/<CR> gvip :s/<\/tr>/<\/td>\r<\/tr>/<CR> gvip :s/;;/<\/td>\r\t<td>/g<CR><C-C>

iab ht http://<C-R>=Eatchar('\s')<CR>
iab ah <a href="<C-R>=Eatchar('\s')<CR>
iab mailto <a href="mailto:"></a>


