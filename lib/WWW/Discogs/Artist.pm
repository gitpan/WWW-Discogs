package WWW::Discogs::Artist;

use strict;
use warnings;

sub new {
	my ($class, %opts) = @_;
	bless {}, $class;
}

sub add_image {
	my ($self, $uri) = @_;
	push @{$self->{images}}, $uri;
}

sub images {
	my $self = shift;
	return $self->{images};
}

sub set_name {
	my ($self, $name) = @_;
	$self->{name} = $name;
}

sub name {
	my $self = shift;
	return $self->{name};
}

sub set_realname {
	my ($self, $realname) = @_;
	$self->{realname} = $realname;
}

sub realname {
	my $self = shift;
	return $self->{realname};
}


sub add_release {
	my ($self, $release) = @_;
	push @{ $self->{releases} }, $release;
}

sub releases {
	my $self = shift;
	return $self->{releases};
}

1;
