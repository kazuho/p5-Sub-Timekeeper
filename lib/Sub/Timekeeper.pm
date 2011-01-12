package Sub::Timekeeper;

use strict;
use warnings;

require Exporter;
use Time::HiRes ();

our $VERSION = '0.01';

our @ISA = qw(Exporter);
our @EXPORT_OK = qw(timekeeper);
our %EXPORT_TAGS = (
    all => [ @EXPORT_OK ],
);

sub timekeeper {
    my $elapsed = \$_[0]; shift;
    my $subref = shift;
    
    my $start = Time::HiRes::time;
    if (wantarray) {
        my @r = $subref->(@_);
        $$elapsed = Time::HiRes::time - $start;
        return @r;
    } else {
        my $r = $subref->(@_);
        $$elapsed = Time::HiRes::time - $start;
        return $r;
    }
}

1;
__END__

=head1 NAME

Sub::Timekeeper - calls a function with a stopwatch

=head1 SYNOPSIS

    use Sub::Timekeeper qw(timekeeper);

    my $val = timekeeper(my $timeout, sub {
        ...
        return $retval;
    });

    my @arr = timekeeper(my $timeout, sub {
        ...
        return @retarr;
    });

=head1 DESCRIPTION

The module exports the C<timekeeper> function, that can be used to measure the time spent to execute a function.  The timeout is set to the first argument in seconds (as a floating point value).

=head1 AUTHOR

Kazuho Oku

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

See <http://www.perl.com/perl/misc/Artistic.html>

=cut
