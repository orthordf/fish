#!/usr/bin/perl -w
use strict;
use File::Basename;
use Getopt::Std;
my $PROGRAM = basename $0;
my $USAGE=
"Usage: $PROGRAM
";

my %OPT;
getopts('', \%OPT);

my %FISH = (
    7936 => 1,
    7955 => 1,
    8128 => 1,
    31033 => 1,
    8090 => 1,    
    );

my %COUNT = ();
while (<>) {
    chomp;
    my @f = split(/\t/, $_);
    if (@f != 5) {
        die;
    }
    my $tax1 = $f[0];
    my $tax2 = $f[3];
    if ($FISH{$tax1} || $FISH{$tax2}) {
        if ($COUNT{$tax1}{$tax2}) {
            $COUNT{$tax1}{$tax2}++;
        } else {
            $COUNT{$tax1}{$tax2} = 1;
        }
    }
}

for my $tax1 (keys %COUNT) {
    for my $tax2 (keys %{$COUNT{$tax1}}) {
        my $count = $COUNT{$tax1}{$tax2};
        my $size = log($count)/log(2);
        $size = sprintf("%.2f", $size/2+1);
        print "$tax1 -> $tax2 width:$size count:$count\n";
    }
}
