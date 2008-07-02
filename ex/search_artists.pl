#!/usr/bin/perl

use strict;
use warnings;

use lib '../lib';
use WWW::Discogs;

my $discogs = WWW::Discogs->new(apikey => '5b4bea98ec');
for my $result (@{ $discogs->search('Ween','artist') }) {
	if ($result->{type} eq 'artist') {
		my $artist = $discogs->artist($result->{title});
		print $artist->name . "\n";
		if ($artist->images) {
			print $artist->images->[0] . "\n";
		}
		print "\n";
	}
}
