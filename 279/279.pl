#!/opt/local/bin/perl
use strict;
use warnings;

use POSIX;

use Data::Dumper qw( Dumper );
use List::Util qw( min max );

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
    my @res = ();
    for my $a (1 .. floor($p/3)) {
        for my $b (max((ceil($p/2) - $a), $a) .. floor (($p - $a)/2)) {
            #print "$a $b ", ($p - $a - $b), "\n";
            push @res, [$a, $b, $p - $a - $b];
        }
    }   
    #print "\n";
    @res;
}

sub all {
    my $p = shift;
    my @res = tri($p);
    my $total = $#res + 1;
    print "$total ";
    return;
    if ($Euler::279::TRI->[$p] != $total) {
        #print 'Error!!!', "\n";
    }
}

sub main  {
    my $a = 3;
    my $b = $ARGV[0];
         all($_) for (3..30);
    print "\n";
}

main();
