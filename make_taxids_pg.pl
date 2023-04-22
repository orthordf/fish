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

open(TAXID, "taxid.tsv") || die "$!";
while (<TAXID>) {
    chomp;
    my @f = split(/\t/, $_, -1);
    if (@f != 3) {
        die;
    }
    my $taxid = $f[0];
    my $name = $f[1];
    my $common = $f[2];
    if ($common eq "") {
        $common = '""';
    }
    print "$taxid name:$name common:$common\n";
}
close(TAXID);

open(TAXIDS, "taxid_pairs") || die "$!";
while (<TAXIDS>) {
    chomp;
    my @f = split(/\t/, $_);
    if (@f != 2) {
        die;
    }
    my $taxid1 = $f[0];
    my $taxid2 = $f[1];
    print "$taxid1 -> $taxid2 :hasOrthologs\n";
}
close(TAXIDS);
