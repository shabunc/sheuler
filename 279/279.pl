#!/opt/local/bin/perl
use strict;
use warnings;

use POSIX;

use Data::Dumper qw( Dumper );
use List::Util qw( max );

sub triangle_test {
    my ($a, $b, $c) = @_;
    return $a + $b > $c and $a + $c > $b and $b + $c > $a;
}

sub geron {
    my ($a, $b, $c) = @_;
    my $s = ($a + $b + $c) / 2;
    my $res = $s * ($s - $a) * ($s - $b) * ($s - $c);
    return $res;
}

sub tri  {
    my $p = shift;
    my $lima = floor(($p - 1)/2);
    my @res = ();
    foreach (1 .. $lima) {
        my $a = $_;
        foreach (max($a, $lima - $a + 1) .. $lima) {
            print $a, "..", $_, "\n";
            push @res, [$a, $_];
        }
    }
    @res;
}

sub all {
    my $p = shift;
    my $total = 0;
    my $valid = 0;
    tri($p);
    #print Dumper tri($p);
    print "\n";
    print "$p:\n\t total => $total\n\t valid => $valid\n ==============\n";
}

sub main  {
    my $a = 3;
    my $b = 10;
    all(9);
    return;
    foreach my $p ($a..$b) {
        all($p);
    }
}

main();
