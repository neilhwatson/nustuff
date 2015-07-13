#!/usr/bin/perl

=pod

=head1 SYNOPSYS

An example of using Mojo::UserAgent to parse an Atom feed.

=cut

use strict;
use warnings;
use feature 'say';
use Mojo::UserAgent;

sub atom_feed
{
   my ( $arg ) = @_;

   # Set defaults
   #                If option given              Use option          Else default
   my $newer_than = exists $arg->{newer_than} ? $arg->{newer_than} : 6000;
   my $url       = $arg->{url};
   my @events;

   my $ua = Mojo::UserAgent->new();
   my $feed = $ua->get( $url ) or warn "Get feed error with [$url]";
   for my $e ( $feed->res->dom( 'entry' )->each )
   {
      my $title = $e->title->text;
      my $link  = $e->link->{href};

      if ( $title =~ m/\A\w+ \s+ # Start with any word
         \#\d{4,5} # bug number
         \s+
         \( (Open|Closed|Merged|Rejected|Unconfirmed) \) # Status of bug
         /ix 
      )
      {
         push @events, $title .", ". $link;
      }
   }
   say $_ foreach ( @events );
   return \@events;
}

atom_feed({ url => 'https://dev.cfengine.com/projects/core/activity.atom' });

