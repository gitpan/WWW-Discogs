package WWW::Discogs::Label;

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

sub set_name {
	my ($self, $name) = @_;
	$self->{name} = $name;
}

sub name {
	my $self = shift;
	return $self->{name};
}

sub set_parentLabel {
	my ($self, $parentLabel) = @_;
	$self->{parentLabel} = $parentLabel;
}

sub parentLabel {
	my $self = shift;
	return $self->{parentLabel};
}

sub add_sublabel {
	my ($self, $sublabel) = @_;
	$self->{sublabels} = $sublabel;
}

sub sublabels {
	my $self = shift;
	return $self->{sublabels};
}

sub add_release {
	my ($self, $release) = @_;
	push @{ $self->{releases} }, $release;
}

sub releases {
	my $self = shift;
	return $self->releases;
}

1;
