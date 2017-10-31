# Vim cheatsheet

For vim hacks I've learned.

## Apply Perl commands like s/// to a buffer

    perldo s/x/y/g

Replaces x with y on all lines in the buffer by filtering it
through Perl. This allows for the use of pure Perl regular expressions. In
truth any Perl command will be applied to all lines. See `he perldo` for more
info.

## Write to a file when you forget to sudo

    :w !sudo tee % >/dev/null

## Edit a file remotely over ssh

This is useful when latency is poor.

    vim scp://<hostname>/path/to/file

## Open in existing gvim

    gvim --remote-silent <file>

