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
    my @res = ();
    for my $a (1 .. floor($p/4)) {
        for my $b (ceil(($p - 2*$a)/2) .. floor($p/2)) {
            print "$a $b ", $p - $a - $b, "\n";
            push @res, [$a, $b, $p - $a - $b];
        }
    }   
    for my $a (floor($p/4) + 1 .. floor($p/2)) {
        for my $b ($a .. floor($p/2)) {
            print "$a $b ", $p - $a - $b, "\n";
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
    print "$total \n";
    return;
    if ($Euler::279::TRI->[$p] != $total) {
        #print 'Error!!!', "\n";
    }
}

sub main  {
    my $b = $ARGV[$#ARGV];
    my $a = $#ARGV ? $ARGV[0] : $b;
    all($_) for ($a..$b);
}

main();
