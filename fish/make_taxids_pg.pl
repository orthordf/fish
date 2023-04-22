#!/usr/bin/perl -w
use strict;
use File::Basename;
use Getopt::Std;
my $PROGRAM = basename $0;
my $USAGE=
"Usage: $PROGRAM [-c count_genes]
";

my %OPT;
getopts('c:', \%OPT);

my %N_GENES = ();
if ($OPT{c}) {
    open(COUNT, "$OPT{c}") || die "$!";
    while (<COUNT>) {
        chomp;
        my @f = split(/\t/, $_);
        my $tax = $f[0];
        my $count = $f[1];
        $N_GENES{$tax} = $count;
    }
    close(COUNT);
}

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
    print "$taxid name:$name common:$common";
    if ($N_GENES{$taxid}) {
        my $count = $N_GENES{$taxid};
        my $size = log($count)/log(2);
        $size = sprintf("%.2f", $size);
        print " size:$size count:$count";
    }
    print "\n";
}
close(TAXID);

open(TAXIDS, "taxid_edges") || die "$!";
while (<TAXIDS>) {
    chomp;
    print "$_\n";
}
close(TAXIDS);
