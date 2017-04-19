#!/usr/bin/perl
use strict;
use File::Basename;
use warnings;

die "Usage: $0 <input dir> <output dir>\n" unless @ARGV == 2;
my $InputDir = $ARGV[0] ;
my $OutputDir = $ARGV[1];

open(STDOUT, '>', $OutputDir) or die "can't open file train.scp:$!";

if(-f $InputDir) {
	open(my $fh, '<', $InputDir) or die "Could not open file '$InputDir' $!";
	while (my $row = <$fh>) {
		my($first, $second) = split(/(?<=")\s+(?=")/, $row, 2);
		print $second."\n";
    }
} 


