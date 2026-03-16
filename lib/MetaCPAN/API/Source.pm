use strict;
use warnings;
package MetaCPAN::API::Source;

our $VERSION = '0.53';

use Carp;
use Moo::Role;
use namespace::autoclean;

# /source/{author}/{release}/{path}
sub source {
    my $self  = shift;
    my %opts  = @_ ? @_ : ();
    my $url   = '';
    my $error = "Provide 'author' and 'release' and 'path'";

    %opts or croak $error;

    if (
        defined ( my $author  = $opts{'author'}  ) &&
        defined ( my $release = $opts{'release'} ) &&
        defined ( my $path    = $opts{'path'}    )
      ) {
        $url = "source/$author/$release/$path";
    } else {
        croak $error;
    }

    $url = $self->base_url . "/$url";

    my $result = $self->ua->get($url);
    $result->{'success'}
        or croak "Failed to fetch '$url': $result->{'reason'} - $result->{'content'}";

    return $result->{'content'};
}

1;

__END__

=head1 NAME

MetaCPAN::API::Source - Source information for MetaCPAN::API

=head1 DESCRIPTION

This role provides MetaCPAN::API with fetching of source files.

=head1 METHODS

=head2 source

    my $source = $mcpan->source(
        author  => 'DOY',
        release => 'Moose-2.0201',
        path    => 'lib/Moose.pm',
    );

Searches MetaCPAN for a module or a specific release and returns the plain
source.
