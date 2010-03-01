#!/opt/local/bin/perl
use strict;
use warnings;

use POSIX;

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

sub all {
    my $p = shift;
    my $total = 0;
    my $valid = 0;
    my $general = "";
    my $bi  = sub {
        my ($p, $limit) = @_;
        map {[$_, $p - $_]} (1..$limit);     
    };
    map {
        my $a = $_->[0];
        map {
            $total++;
            [$a, $_->[0], $_->[1]];
        } &$bi($_->[1], floor($_->[1]/2));
    } &$bi($p, floor(($p-1)/2));
    print "\n";
    print "$p:\n\t total => $total\n\t valid => $valid\n ==============\n";
}

sub main  {
    my $a = 3;
    my $b = 1000;
    foreach my $p ($a..$b) {
        all($p);
    }
}

main();
