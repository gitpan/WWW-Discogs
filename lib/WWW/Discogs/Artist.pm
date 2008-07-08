package WWW::Discogs::Artist;

use strict;
use warnings;

sub new {
	my ($class, %opts) = @_;
	bless \%opts, $class;
}

sub namevariations {
	my $self = shift;
	return $self->{namevariations}{name};
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

sub releases {
	my $self = shift;
	return $self->{releases}{release};
}

sub name {
	my $self = shift;
	return $self->{name}[0];
}

sub aliases {
	my $self = shift;
	return $self->{aliases}{name};
}

1;
