use strict;
use warnings;

use Test::More tests => 3;

BEGIN { use_ok 'WWW::Discogs', 'WWW::Discogs::Parser' }

my $apikey = '5b4bea98ec';

my $discogs = WWW::Discogs->new(apikey => $apikey)
	or diag("couldn't create object: $!");

is(ref $discogs, 'WWW::Discogs', "Object creation");

my $rel = $discogs->release(1);
is($rel->title, 'Stockholm', "Compare release name");
