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
            my $c = $p - $a - $_;
            push @res, [$a, $_, $c] unless ($c < $_);
        }
    }
    @res;
}

sub all {
    my $p = shift;
    my $total = 0;
    my @res = tri($p);
    $total = $#res;
    print "\n";
    print "$p => $total";
}

sub main  {
    my $a = 3;
    my $b = 1000;
    foreach ($a..$b) {
         all($_);
    }
}

main();
