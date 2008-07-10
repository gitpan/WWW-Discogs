package WWW::Discogs::Artist;

use strict;
use warnings;

sub new {
	my ($class, %opts) = @_;
	bless \%opts, $class;
}

=head1 NAME

WWW::Discogs::Artist

=cut

=head1 METHODS

=cut

=head2 name

returns the name of the artist

=cut
sub name {
	my $self = shift;
	return $self->{name}[0];
}

=head2 aliases

returns an arrayref of aliases

=cut
sub aliases {
	my $self = shift;
	return $self->{aliases}{name};
}


=head2 namevariations

returns an arrayref of name variations

=cut
sub namevariations {
	my $self = shift;
	return $self->{namevariations}{name};
}

=head2 images

returns an arrayref of images

=cut
sub images {
	my $self = shift;
	return $self->{images}{image};
}

=head2 primary_images

returns an arrayref of primary images

=cut
sub primary_images {
	my $self = shift;
	return [ grep {$_->{type} eq 'primary'} @{$self->{images}{image}} ];
}

=head2 secondary_images

returns an arrayref of secondary images

=cut
sub secondary_images {
	my $self = shift;
	return [ grep {$_->{type} eq 'secondary'} @{$self->{images}{image}} ];
}

=head2 releases

returns an arrayref of releases

=cut
sub releases {
	my $self = shift;
	return $self->{releases}{release};
}

1;
