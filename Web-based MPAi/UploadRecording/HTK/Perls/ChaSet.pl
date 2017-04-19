#!/usr/bin/perl
use warnings;
use strict;
use Encode;

my @charsets = qw(utf-8 latin1 iso-8859-1 iso-8859-15 utf-16 gb2312 unicode ascii);

# some non-ASCII codepoints:
my $test = "tënei";

for (@charsets){
    open(my $fh, ">>:encoding($_)", encode($_, $test)."\.txt");
    print "$_: " . encode($_, $test)."\n";
    print $fh $_."    ".$test."     ".ord("ë")."\n";
    close $fh;
}