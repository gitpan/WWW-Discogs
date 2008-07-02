package WWW::Discogs::Parser;

use strict;
use warnings;

use XML::Parser;
use WWW::Discogs::Release;
use WWW::Discogs::Artist;
use WWW::Discogs::Label;

use constant {TRUE => 1, FALSE => 0};

sub new {
	my $class = shift;
	my $self = {
		version	=> '1.0',
		xml 	=> XML::Parser->new(Style => 'Objects'),
		return	=> undef,
		error	=> undef,
		errormsg => undef,
	};

	bless $self, $class;
}

sub parse {
	my ($self, $content) = @_;
	my $res = $self->{xml}->parse($content);
	if ($res->[0]{stat} eq 'ok') {
		for my $child (@{ $res->[0]{Kids} }) {
			if ((ref $child) =~ /release$/) {
				$self->parse_release($child);
			}
			elsif ((ref $child) =~ /artist$/) {
				$self->parse_artist($child);
			}
			elsif ((ref $child) =~ /exactresults/) {
				$self->parse_exactresults($child);
			}
			elsif ((ref $child) =~ /searchresults/) {
				$self->parse_searchresults($child);
			}
			elsif ((ref $child) =~ /label$/) {
				$self->parse_label($child);
			}
		}
	}
	return $self->{return};
}

sub parse_label {
	my ($self, $node) = @_;
	$self->{return} = WWW::Discogs::Label->new;

	for my $child (@{ $node->{Kids} }) {
		if ((ref $child) =~ /name$/) {
			$self->{return}->set_name($child->{Kids}[0]{Text});
		}
		elsif ((ref $child) =~ /images$/) {
			$self->parse_images($child);
		}
		elsif ((ref $child) =~ /parentLabel$/) {
			$self->{return}->set_parentLabel($child->{Kids}[0]{Text});
		}
		elsif ((ref $child) =~ /releases$/) {
			for (@{ $child->{Kids} }) {
				$self->{return}->add_release($_->{id});
			}
		}
		elsif ((ref $child) =~ /sublabels$/) {
			for (@{ $child->{Kids} }) {
				$self->{return}->add_sublabel($_->{Kids}[0]{Text});
			}
		}
	}
}

sub parse_release {
	my ($self, $node) = @_;

	$self->{return} = WWW::Discogs::Release->new(
		id => $node->{id},
		accepted => $node->{accepted}
	);

	for my $child (@{ $node->{Kids} }) {
		if ((ref $child) =~ /images$/) {
			$self->parse_images($child);
		}
		elsif ((ref $child) =~ /artists$/) {
			$self->parse_artists($child);
		}
		elsif ((ref $child) =~ /title$/) {
			$self->{return}->set_title($child->{Kids}[0]{Text});
		}
		elsif ((ref $child) =~ /labels$/) {
			$self->parse_labels($child);
		}
	}
}

sub parse_artist {
	my ($self, $node) = @_;
	$self->{return} = WWW::Discogs::Artist->new;
	for my $child (@{ $node->{Kids} }) {
		if ((ref $child) =~ /images$/) {
			$self->parse_images($child);
		}
		elsif ((ref $child) =~ /name$/) {
			$self->{return}->set_name($child->{Kids}[0]{Text});
		}
		elsif ((ref $child) =~ /realname$/) {
			$self->{return}->set_realname($child->{Kids}[0]{Text});
		}
		elsif ((ref $child) =~ /releases$/) {
			for (@{ $child->{Kids} }) {
				$self->{return}->add_release($_->{id});
			}
		}
	}
}

sub parse_exactresults {
	my ($self, $node) = @_;
	if (ref $self->{return} ne 'ARRAY') {
		$self->{return} = [];
	}
	for my $child (@{ $node->{Kids} }) {
		if ((ref $child) =~ /result$/) {
			push @{ $self->{return} }, {
				type	=> $child->{type},
				title	=> $child->{Kids}[0]{Kids}[0]{Text},
				any		=> $child->{Kids}[1]{Kids}[0]{Text},
			};
		}
	}
}

sub parse_searchresults {
	my ($self, $node) = @_;
	if (ref $self->{return} ne 'ARRAY') {
		$self->{return} = [];
	}
	for my $child (@{ $node->{Kids} }) {
		if ((ref $child) =~ /result$/) {
			push @{ $self->{return} }, {
				type	=> $child->{type},
				title	=> $child->{Kids}[0]{Kids}[0]{Text},
				uri		=> $child->{Kids}[1]{Kids}[0]{Text},
				summary	=> $child->{Kids}[2]{Kids}[0]{Text},
			};
		}
	}
}

sub parse_images {
	my ($self, $node) = @_;
	for my $child (@{ $node->{Kids} }) {
		if ((ref $child) =~ /image$/) {
			$self->{return}->add_image($child->{uri});
		}
	}
}

sub parse_artists {
	my ($self, $node) = @_;
	for my $child (@{ $node->{Kids} }) {
		if ((ref $child) =~ /artist$/) {
			for (@{ $child->{Kids} }) {
				if ((ref $_) =~ /name$/) {
					$self->{return}->add_artist($_->{Kids}[0]{Text});
				}
			}
		}
	}
}

sub parse_labels {
	my ($self, $node) = @_;
	for my $child (@{ $node->{Kids} }) {
		if ((ref $child) =~ /label$/) {
			$self->{return}->add_label($child->{name}, $child->{catno});
		}
	}
}

1;
