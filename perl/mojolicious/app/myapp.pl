#!/usr/bin/env perl 

use FindBin;
require Mojolicious::Commands;

BEGIN { unshift @INC, "$FindBin::Bin/lib" }

Mojolicious::Commands->start_app('myapp');

=pod

=head1 SYNOPSIS

This is the program that starts the app.

=head2 WAYS TO RUN YOUR APPLICATION

=over 3

   morbo myapp.pl

Uses the Mojolicious development daemon. Logs to stdout.

=back

=over 3

   myapp.pl daemon

Same as using morbo.

=back

=over 3
   
   hypnotoad myapp.pl

Starts running in hypnotoad production server.

=back

=over 3

   myapp.pl test

Run application test suite.

=back

=head2 NOTES

The shebang, env perl finds *your* perl which may be /usr/bin/perl, or may be a
perlbrew perl.

=head2 LICENSE

The MIT License (MIT)

Copyright (c) 2014 Neil H Watson

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

=cut
