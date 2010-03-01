#!/opt/local/bin/perl
use strict;
use warnings;

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
    my $s = $p/2;
    my $total = 0;
    my $valid = 0;
    my $general = "";
    foreach my $a (1..$p - 1) {
        my $bc = $p - $a;
        foreach my $b (1..$bc - 1) {
            my $c = $bc - $b;
            $total++;
            #print $a, $b, $c, "\n"; 
        }
    }
    print "\n";
    print "$p:\n\t total => $total\n\t valid => $valid\n ==============\n";
}

sub main  {
    my $a = 0;
    my $b = 1000;
    foreach my $p ($a..$b) {
        all($p);
    }
}

main();
