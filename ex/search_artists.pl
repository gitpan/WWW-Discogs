#!/usr/bin/perl

use strict;
use warnings;

use lib '../lib';
use WWW::Discogs;

my $discogs = WWW::Discogs->new(apikey => '5b4bea98ec');
my $search = $discogs->search('Bill Callahan');
for my $result (@{ $search->exactresults }) {
	if ($result->{type} eq 'artist') {
		my $artist = $discogs->artist($result->{title});
		if ($artist->images) {
			print $artist->name . "\n";
			print $artist->images->[0]{uri} . "\n\n";
		}
	}
}
