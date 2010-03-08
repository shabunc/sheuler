#!/opt/local/bin/perl
use strict;
use warnings;

use POSIX;

use Data::Dumper qw( Dumper );

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
    foreach my $b ($min .. $max) {
        foreach (($max - $b + 1) .. $b) {
            my $c = $p - $_ - $b;
            unless ($c < $b) {
                push @res, [$_, $b, $c];
            }
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
