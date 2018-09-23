"===================================
"Markdown SECTION
"===================================

"create html header lines (h1 to h6)
nmap,1 <HOME>I# <ESC>
nmap,2 <HOME>I## <ESC>
nmap,3 <HOME>I### <ESC>
nmap,4 <HOME>I#### <ESC>
nmap,5 <HOME>I##### <ESC>
nmap,6 <HOME>I###### <ESC>

"create html list items
nmap ,l vip :s/^\(.*\)$/1. \1/g<CR><C-C>:noh<CR>

setlocal tabstop=4 shiftwidth=4
setlocal tabstop=4 shiftwidth=4
