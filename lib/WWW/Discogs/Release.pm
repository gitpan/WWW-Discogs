package WWW::Discogs::Release;

use strict;
use warnings;

sub new {
	my ($class, %opts) = @_;
	bless \%opts, $class;
}

sub country {
	my $self = shift;
	return $self->{country};
}

sub images {
	my $self = shift;
	return $self->{images}{image};
}

sub primary_images {
	my $self = shift;
	return [ grep {$_->{type} eq 'primary'} @{$self->{images}{image}} ];
}

sub secondary_images {
	my $self = shift;
	return [ grep {$_->{type} eq 'secondary'} @{$self->{images}{image}} ];
}

sub styles {
	my $self = shift;
	return $self->{styles}{style};
}

#TODO make DateTime object
sub released {
	my $self = shift;
	return $self->{released};
}

sub tracklist {
	my $self = shift;
	my $tracklist = $self->{tracklist}{track};
	return $tracklist;
}

sub formats {
	my $self = shift;
	return [ map {$_->{name}} @{$self->{formats}{format}} ];
}

sub artists {
	my $self = shift;
	return $self->{artists}{artist};
}

sub notes {
	my $self = shift;
	return $self->{notes};
}

sub extraartists {
	my $self = shift;
	return $self->{extraartists}{artist};
}

sub genres {
	my $self = shift;
	return $self->{genres}{genre};
}

sub labels {
	my $self = shift;
	return $self->{labels}{label};
}

sub title {
	my $self = shift;
	return $self->{title};
}

sub id {
	my $self = shift;
	return $self->{id};
}

2;
