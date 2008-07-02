package WWW::Discogs;

use strict;
use warnings;

use LWP::UserAgent;
use URI::Escape;
use Compress::Zlib;
use WWW::Discogs::Parser;
use Data::Dumper;

use constant {TRUE => 1, FALSE => 0};

sub new {
	my ($class, %opts) = @_;
	my $self = {
		apiurl	=> $opts{apiurl} || 'http://www.discogs.com/',
		apikey	=> $opts{apikey},
		ua		=> LWP::UserAgent->new,
		parser	=> WWW::Discogs::Parser->new,
	};
	return bless $self, $class;
}

sub search {
	my ($self, $query, $type) = @_;
	my $res = $self->_request('search', {
		q		=> $query,
		type	=> $type || 'all',
	});
	
	if ($res->is_success) {
		return $self->{parser}->parse($res->content);
	}

	return FALSE;
}

sub release {
	my ($self, $release) = @_;
	if ($release =~ /^\d+$/) {
		my $res = $self->_request("release/" . uri_escape($release));
		if ($res->is_success) {
			return $self->{parser}->parse($res->content);
		}
	}
	
	return FALSE;
}

sub artist {
	my ($self, $artist) = @_;
	my $res = $self->_request("artist/" . uri_escape($artist));
	if ($res->is_success) {
		return $self->{parser}->parse($res->content);
	}

	return FALSE;
}

sub label {
	my ($self, $label) = @_;
	my $res = $self->_request("label/" . uri_escape($label));
	if ($res->is_success) {
		return $self->{parser}->parse($res->content);
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
	my $paramstring = join "&", map { uri_escape($_) . "=" . uri_escape($params->{$_}) } keys %$params;

	return lc $self->{apiurl} . "$path?$paramstring";
}

1;
