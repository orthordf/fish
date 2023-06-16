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
    9606 => 1,
    );

while (<>) {
    chomp;
    $. == 1 and print $_, "\n";
    my @f = split(/\t/, $_);
    my $tax1 = $f[0];
    my $tax2 = $f[3];
    if ($FISH{$tax1} && $FISH{$tax2}) {
        print $_, "\n";
    }
}
