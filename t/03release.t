use strict;
use warnings;

use Test::More tests => 12;
use Encode;

BEGIN { use_ok 'WWW::Discogs', 'WWW::Discogs::Parser' }

my $apikey = '5b4bea98ec';

my $discogs = WWW::Discogs->new(apikey => $apikey);
is(ref $discogs, 'WWW::Discogs', "client");

my $rel = $discogs->release(1);
is(ref $rel, 'WWW::Discogs::Release','release');

is($rel->country, 'Sweden', "name");
is($rel->title, 'Stockholm', "name");
is($rel->released, "1999-03-00");
is($rel->id, 1);

is_deeply($rel->styles, ["Deep House"]);
is_deeply($rel->formats, ["Vinyl"]);
is_deeply($rel->genres, ["Electronic"], "genre");
is_deeply($rel->labels, [{name => "Svek", catno => 'SK032'}], "labels");

for (@{$rel->tracklist}) {
	if ($_->{position} eq "B1") {
		is_deeply($_, {
				position	=> "B1",
				title		=> "Vasastaden",
				duration	=> "6:11" }, 'tracklist');
	}
}
