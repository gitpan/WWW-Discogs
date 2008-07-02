use strict;
use warnings;

use Test::More tests => 6;

BEGIN { use_ok 'WWW::Discogs' }

my $apikey = '5b4bea98ec';

my $discogs = WWW::Discogs->new(apikey => $apikey)
	or diag("couldn't create object: $!");

is(ref $discogs, 'WWW::Discogs', "Object creation");

my $url = $discogs->_create_url('search', {q => 'query param', type => 'all'});
is($url, "http://www.discogs.com/search?q=query%20param&type=all&api_key=$apikey&f=xml", "Search URL");

$url = $discogs->_create_url('release/1');
is($url, "http://www.discogs.com/release/1?api_key=$apikey&f=xml", "Release URL");

$url = $discogs->_create_url('artist/Ween');
is($url, "http://www.discogs.com/artist/ween?api_key=$apikey&f=xml", "Artist URL");

$url = $discogs->_create_url('label/Svek');
is($url, "http://www.discogs.com/label/svek?api_key=$apikey&f=xml", "Artist URL");
