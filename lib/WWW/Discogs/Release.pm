package WWW::Discogs::Release;

use strict;
use warnings;

sub new {
	my ($class, %opts) = @_;
	bless \%opts, $class;
}

sub add_image {
	my ($self, $uri) = @_;
	push @{$self->{images}}, $uri;
}

sub images {
	my $self = shift;
	return $self->{images};
}

sub set_title {
	my ($self, $title) = @_;
	$self->{title} = $title;
}

sub title {
	my $self = shift;
	return $self->{title};
}

sub add_label {
	my ($self, $label) = @_;
	$self->{label} = $label;
}

sub labels {
	my $self = shift;
	return $self->{labels};
}

sub add_artist {
	my ($self, $artist) = @_;
	push @{ $self->{artists} }, $artist;
}

sub artists {
	my $self = shift;
	return $self->artists;
}

sub set_id {
	my ($self, $id) = @_;
	$self->{id} = $id;
}

sub id {
	my $self = shift;
	return $self->{id};
}

sub set_approved {
	my ($self, $approved) = @_;
	$self->{approved} = $approved;
}

sub approved {
	my $self = shift;
	return $self->{approved}
}

1;
