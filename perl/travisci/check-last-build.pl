#!/usr/bin/perl

# use JSON;
use Data::Dumper;
use Mojo::UserAgent;
use feature 'say';
use Test::More;
use strict;
use warnings;

# https://api.travis-ci.org/repos/neilhwatson/cfbot/builds.json
my $user    = 'neilhwatson';
my $project = 'cfbot';
my $url     = 'https://api.travis-ci.org/repos/'
   . $user . '/' . $project . '/builds.json';

my $ua         = Mojo::UserAgent->new();
my $reply      = $ua->get( $url )->res->json;
my $last_build = $reply->[0];

say Dumper( $last_build );

say << "END_RESULT";
commit      = $last_build->{commit}
finished_at = $last_build->{finished_at}
END_RESULT

ok( $last_build->{result} == 0, "Build passed" );
