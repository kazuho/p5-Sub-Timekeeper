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
