#!/usr/bin/perl
use strict;
use Tie::File;

die "Usage: $0 <tree.hed> <stat> <fulllist> <tiedlist> <trees>\n" unless @ARGV == 5;
my ($treehed, $stats, $fulllist, $tiedlist, $trees) = @ARGV;

$stats =~ s/\\/\//g;
$fulllist =~ s/\\/\//g;
$tiedlist =~ s/\\/\//g;
$trees =~ s/\\/\//g;

tie my @lines, 'Tie::File', $treehed || die "can't open file tree.hed:$!";
$lines[0] = "RO 100 "."\"$stats\"";
$#lines -= 5;
push @lines, "AU "."\"$fulllist\"";
push @lines, "";
push @lines, "CO "."\"$tiedlist\"";
push @lines, "";
push @lines, "ST "."\"$trees\"";
untie @lines;
