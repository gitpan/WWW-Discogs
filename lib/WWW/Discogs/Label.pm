package WWW::Discogs::Label;

use strict;
use warnings;

sub new {
	my ($class, %opts) = @_;
	bless \%opts, $class;
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

sub contactinfo {
	my $self = shift;
	return $self->{contactinfo};
}

sub name {
	my $self = shift;
	return $self->{name};
}

sub sublabels {
	my $self = shift;
	return [ keys %{$self->{sublabels}} ];
}

sub releases {
	my $self = shift;
	return $self->{releases}{release};
}

1;
