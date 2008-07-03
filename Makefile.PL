use inc::Module::Install;

name			'WWW-Discogs';
all_from		'lib/WWW/Discogs.pm';
perl_version	'5.008';

requires		'LWP::UserAgent';
requires		'URI';
requires		'XML::Parser';

test_requires	'Test::More';

WriteAll;
