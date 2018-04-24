function! Marg()
" Convert the current line into a shell case argment line.
   let myarg       = getline('.')
   let myarg_org   = myarg
   let double_dash = ''

   while ( len( myarg ) > 0 )
      let double_dash .= "--" . myarg

      if len( myarg ) > 1
         let double_dash .= " | "
      endif

      let myarg = substitute( myarg, '.$', '', '')
   endwhile

   let single_dash = substitute( double_dash, '--', '-', 'g' )

   call setline( '.', [ double_dash . " |\\" ])
   call append( '.', [  single_dash . ")", "shift", myarg_org . "=$1", ";;" ])
endfunction
