package WWW::Discogs::Search;

use strict;
use warnings;

sub new {
	my ($class, %opts) = @_;
	bless \%opts, $class;
}

sub exactresults {
	my $self = shift;
	return $self->{exactresults}{result};
}

sub searchresults {
	my $self = shift;
	return $self->{searchresults}{result};
}

1;
