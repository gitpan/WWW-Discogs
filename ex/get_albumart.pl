#!/usr/bin/perl

use strict;
use warnings;

use lib '../lib';
use WWW::Discogs;

my $discogs = WWW::Discogs->new(apikey => '5b4bea98ec');
if (my $artist = $discogs->artist('Ween')) {
	for (@{ $artist->releases }) {
		my $release = $discogs->release($_);
		if ($release->images) {
			print $release->title . "\n". $release->images->[0] . "\n\n";
		}
	}
}
