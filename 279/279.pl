#!/opt/local/bin/perl
use strict;
use warnings;

use POSIX;

use Data::Dumper qw( Dumper );
use List::Util qw( min );

use Euler::279;

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
    my $max = floor(($p - 1)/2);
    my $min = ceil(($max + 1)/2);
    my @res = ();
    my $maxmin = floor($p/3);
    foreach my $b ($min .. $maxmin) {
        foreach (($max - $b + 1) .. $b) {
            push @res, [$_, $b, $p - $_ - $b];
        }
    };
    foreach my $b ($maxmin + 1 .. $max) {
        foreach (($max - $b + 1) .. $p - 2*$b) {
            push @res, [$_, $b, $p - $_ - $b];
        }
    }
    @res;
}

sub all {
    my $p = shift;
    my @res = tri($p);
    my $total = $#res;
    if ($Euler::279::TRI->[$p] != $total) {
        print 'Error!!!', "\n";
    }
}

sub main  {
    my $a = 3;
    my $b = $ARGV[0];
    foreach ($a..$b) {
         all($_);
    }
}

main();
