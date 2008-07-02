use inc::Module::Install;

name			'WWW-Discogs';
abstract		'Interfaces with discogs.com API';
author			'Lee Aylward <lee@laylward.com>';
version			'0.01';
license			'perl';
perl_version	'5.006';

requires		'LWP::UserAgent';
requires		'URI';
requires		'XML::Parser';

test_requires	'Test::More';

WriteAll;
