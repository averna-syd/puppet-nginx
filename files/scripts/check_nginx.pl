#!/usr/bin/env perl

use strict;
use warnings;

use Getopt::Long;
use Pod::Usage;

my %OPTS;

GetOptions( \%OPTS, 'service|s=s', 'verbose|v', 'help|h', 'man|m' );
pod2usage( -exitstatus => 0, -verbose => 2 ) if $OPTS{man};


if ( $OPTS{service} )
{
    check_nginx( \%OPTS );
}
else
{
    die pod2usage(1);
}


sub check_nginx
{
    my $opts = shift;

    open ( my $fh, '-|', $opts->{service} . q{ configtest} ) || die $!;
        my $result = do { local $/; <$fh> };
    close ( $fh );

    print $result if ( $opts->{verbose} );

    my $exit_code = ( $? >> 8 );

    exit $exit_code;
};


__END__

=head1 NAME

B<check_nginx.pl> - A simple script that will check the nginx config.


=head1 SYNOPSIS

 check_nginx.pl --service <path to init script> --verbose


=head1 OPTIONS

=over 8

=item B<-s, --service>
The path to the nginx init script.

=item B<-v, --verbose>
If true, will print out any error messages.

=item B<-h, --help>
Prints a brief help message.

=item B<-m, --man>
Prints the full manual page.


=back

=head1 DESCRIPTION

A simple script that will check the nginx config.

=head1 AUTHOR

Sarah Fuller, C<< <sarah at averna.id.au> >>

=cut
