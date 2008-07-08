package WWW::Discogs;

use strict;
use warnings;

use LWP::UserAgent;
use URI;
use URI::Escape;
use URI::QueryParam;
use Compress::Zlib;
use XML::Simple;
use Encode;
use Data::Dumper;

use WWW::Discogs::Release;
use WWW::Discogs::Artist;
use WWW::Discogs::Label;
use WWW::Discogs::Search;

use constant {TRUE => 1, FALSE => 0};

use 5.008;
our $VERSION = '0.03';

=head1 NAME

WWW::Discogs

=head1 DESCRIPTION

Interface with discogs.com api

=head1 SYNOPSIS
	use WWW:Discogs;

	my $client = WWW::Discogs->new(apikey => 1234567);

	# Print all artist images from a search
	#
	my $results = $client->search("Ween");
	
	for my $result (@$results) {
		if ($result->{type} eq 'artist') {
			my $artist = $client->artist( $result->{title} );
			print "$_\n" for @{ $artist->images };
		}
	}

	# Print all the album covers for an artist
	#
	my $artist = $client->artist("Ween");
	for my $releaseid (@{ $artist->releases }) {
		my $release = $client->release($releaseid);
		print "$_\n" for @{ $release->images };
	}
=cut

=head1 METHODS

=cut

=head2 new( %params )

Create a new instance. Takes a hash which must contain an 'apikey' item. You may also
provide an 'apiurl' item to change the url that is queried (default is www.discogs.com).

=cut
sub new {
	my ($class, %opts) = @_;
	my $self = {
		apiurl	=> $opts{apiurl} || 'http://www.discogs.com',
		apikey	=> $opts{apikey},
		ua		=> LWP::UserAgent->new,
	};
	return bless $self, $class;
}

=head2 search( $searchstring )

Returns a I<Discogs::Search> object.

=cut

sub search {
	my ($self, $query, $type) = @_;
	my $res = $self->_request('search', {
		q		=> $query,
		type	=> $type || 'all',
	});
	
	if ($res->is_success) {
		my $xml = XMLin($res->content, ForceArray => ['result']);
		if ($xml->{stat} eq 'ok') {
			return WWW::Discogs::Search->new(%$xml);
		}
	}

	return FALSE;
}

=head2 release( $release_id )

Returns a I<Discogs::Release> object. You can get a $release_id from a search,
artist, or label.

=cut

sub release {
	my ($self, $release) = @_;
	if ($release =~ /^\d+$/) {
		my $res = $self->_request("release/" . uri_escape($release));
		if ($res->is_success) {
			my $xml = XMLin($res->content, ForceArray => [ 
				'image',		'style',	'track',
				'format',		'note',		'description',
				'extraartist',	'genre',	'artist',
				'label',
			],KeyAttr => []);
			if ($xml->{stat} eq 'ok' and exists $xml->{release}) {
				return WWW::Discogs::Release->new(%{$xml->{release}});
			}
		}
	}
	
	return FALSE;
}

=head2 artist( $artist_name )

Returns a I<Discogs::Artist> object. You can get the exact name of an artist
from a search result's title.

=cut

sub artist {
	my ($self, $artist) = @_;
	my $res = $self->_request("artist/" . uri_escape($artist));
	if ($res->is_success) {
		my $xml = XMLin($res->content,
			ForceArray => ['image','name'], KeyAttr => ['name']);
		if ($xml->{stat} eq 'ok' and exists $xml->{artist}) {
			return WWW::Discogs::Artist->new(%{$xml->{artist}});
		}
	}

	return FALSE;
}

=head2 label( $label_name )

Returns a Discogs::Label object. You can get the exact name of a label
from a search result's title.

=cut

sub label {
	my ($self, $label) = @_;
	my $res = $self->_request("label/" . uri_escape($label));
	if ($res->is_success) {
		my $xml = XMLin($res->content, ForceArray => [
			'release','image','sublabels'], KeyAttr => ['label']);
		if ($xml->{stat} eq 'ok' and exists $xml->{label}) {
			return WWW::Discogs::Label->new(%{$xml->{label}});
		}
	}
	
	return FALSE;
}

sub _request {
	my ($self, $path, $params) = @_;
	my $url = $self->_create_url($path,$params);
	my $res = $self->{ua}->get($url, 'Accept-Encoding' => 'gzip');
	if ($res->is_success) {
		if ($res->content_encoding and $res->content_encoding eq 'gzip') {
			$res->content(Compress::Zlib::memGunzip( $res->content ));
		}
	}
	return $res;
}

sub _create_url {
	my ($self, $path, $params) = @_;

	$params->{f} = 'xml';
	$params->{api_key} = $self->{apikey};

	my $uri = URI->new($self->{apiurl},"http");
	$uri->path($path);
	$uri->query_form_hash($params);

	return $uri->canonical->as_string;
}

=head1 AUTHOR

Lee Aylward <lee@laylward.com>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
