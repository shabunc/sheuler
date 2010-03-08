#!/opt/local/bin/perl
use strict;
use warnings;

use POSIX;

use Data::Dumper qw( Dumper );
use List::Util qw( max );

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
    my $lima = floor(($p - 1)/2);
    my @res = ();
    foreach my $a (1 .. $lima) {
        foreach (max($a, $lima - $a + 1) .. $lima) {
            my $c = $p - $a - $_;
            push @res, [$a, $_, $c] unless ($c < $_);
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
    my $a = 0;
    my $b = $ARGV[0];
    foreach ($a..$b) {
         all($_);
    }
}

main();
