"===================================
"LATEX SECTION
"===================================

setlocal textwidth=72

" Add chapter tag
nmap ,c <HOME>v$"zdi\chapter{<ESC>"zp$a}<ESC>

" Add section tag
nmap ,s <HOME>v$"zdi\section{<ESC>"zp$a}<ESC>

" Add subsection tag
nmap ,ss <HOME>v$"zdi\section{<ESC>"zp$a}<ESC>

" Add textt tag
nmap ,t <HOME>v$"zdi\texttt{<ESC>"zp$a}<ESC>

" Insert item tag
nmap ,i I\item <ESC>

" Create item lists
nmap ,l vip :s/^\(.*\)$/\\item \1/g<CR><C-C>:noh<CR>

" verbatim block
vmap ,v "zdO\being{verbatim}<CR><ESC>"zgp<ESC>o\end{verbatim}}<ESC>




