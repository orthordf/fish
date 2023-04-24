#!/usr/bin/perl -w
use strict;
use File::Basename;
use Getopt::Std;
my $PROGRAM = basename $0;
my $USAGE=
"Usage: $PROGRAM [-c count_genes] taxid.tsv
";

my %OPT;
getopts('c:', \%OPT);

if (!@ARGV) {
    print STDERR $USAGE;
    exit 1;
}
my ($TAXID) = @ARGV;

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

my %CHECKED_NODE = ();
open(TAXIDS, "taxid_edges") || die "$!";
while (<TAXIDS>) {
    chomp;
    my @f = split();
    my $tax1 = $f[0];
    my $tax2 = $f[2];
    $CHECKED_NODE{$tax1} = 1;
    $CHECKED_NODE{$tax2} = 1;
    print "$_\n";
}
close(TAXIDS);

open(TAXID, "$TAXID") || die "$!";
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
    if ($CHECKED_NODE{$taxid}) {
        print "$taxid :Organism name:$name common:$common";
        if ($N_GENES{$taxid}) {
            my $count = $N_GENES{$taxid};
            my $size = log($count)/log(2);
            $size = sprintf("%.2f", $size);
            print " size:$size count:$count";
        }
        print "\n";
    }
}
close(TAXID);
