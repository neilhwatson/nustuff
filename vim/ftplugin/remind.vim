" remind short cuts
iab r REM
iab m MSG
iab pri PRIORITY
iab pro PROJECT
iab con CONTEXT
" 3 letter day (Mon)
iab d <c-r>=strftime("%a")<cr> 
" today month day year
iab t <c-r>=strftime("%b %d %Y")<cr>
iab q %"%"
iab rem REM MSG "%"%
"Replace REM to MSG with REM today's date and MSG.  
"Then append DONE to task.
nmap ,d :s/^REM.*MSG//<cr>I<c-r>=strftime("%b %d %Y")<cr> MSG <esc>IREM <esc>A DONE<esc><<


