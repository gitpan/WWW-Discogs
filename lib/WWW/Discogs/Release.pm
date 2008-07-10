package WWW::Discogs::Release;

use strict;
use warnings;

=head1 NAME

WWW::Discogs::Release

=head1 METHODS

=cut

sub new {
	my ($class, %opts) = @_;
	bless \%opts, $class;
}

=head2 title

returns the title

=cut
sub title {
	my $self = shift;
	return $self->{title};
}

=head2 artists

returns an arrayref of artist names

=cut
sub artists {
	my $self = shift;
	return $self->{artists}{artist};
}


=head2 images

Returns an arrayref of images

=cut
sub images {
	my $self = shift;
	return $self->{images}{image};
}

=head2 primary_images

Returns an arrayref of the primary images

=cut
sub primary_images {
	my $self = shift;
	return [ grep {$_->{type} eq 'primary'} @{$self->{images}{image}} ];
}

=head2 secondary_images

returns an arrayref of the secondary images

=cut
sub secondary_images {
	my $self = shift;
	return [ grep {$_->{type} eq 'secondary'} @{$self->{images}{image}} ];
}

=head2 styles

returns an arrayref of styles

=cut
sub styles {
	my $self = shift;
	return $self->{styles}{style};
}

=head2 released

returns the date

=cut
#TODO make DateTime object
sub released {
	my $self = shift;
	return $self->{released};
}

=head2 tracklist

returns an arrayref of tracks

=cut
sub tracklist {
	my $self = shift;
	my $tracklist = $self->{tracklist}{track};
	return $tracklist;
}

=head2 extraartists

returns an arrayref of artists

=cut
sub extraartists {
	my $self = shift;
	return $self->{extraartists}{artist};
}

=head2 genres

returns an arrayref of genre names

=cut
sub genres {
	my $self = shift;
	return $self->{genres}{genre};
}

=head2 labels

returns an arrayref of labels

=cut
sub labels {
	my $self = shift;
	return $self->{labels}{label};
}


=head2 country

Returns the country

=cut
sub country {
	my $self = shift;
	return $self->{country};
}

=head2 formats

returns an arrayref of formats

=cut
sub formats {
	my $self = shift;
	return [ map {$_->{name}} @{$self->{formats}{format}} ];
}

=head2 id

returns the discogs ID for the album

=cut
sub id {
	my $self = shift;
	return $self->{id};
}

=head2 notes

returns an arrayref of notes

=cut
sub notes {
	my $self = shift;
	return $self->{notes};
}

1;
