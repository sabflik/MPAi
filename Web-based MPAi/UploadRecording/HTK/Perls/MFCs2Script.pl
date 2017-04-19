#!/usr/bin/perl
use strict;
use File::Basename;
use warnings;
#use open ':encoding(iso-8859-1)';
#use open IO => ':encoding(utf-8)';

die "Usage: $0 <input dir> <extion> <output dir>\n" unless @ARGV == 3;
my $InputDir = $ARGV[0] ;
my $Ext = $ARGV[1] ;
my $OutputDir = $ARGV[2];

opendir(DH, "$InputDir") or die "Can't open: $!\n" ;

open(STDOUT, ">", "$OutputDir"."\\Train.scp") or die "can't open file Train.scp:$!";

#load all the files in $InputDir which have suffix "mfc"
my @list = grep {/$Ext$/ && -f "$InputDir/$_" } readdir(DH) ;
closedir(DH) ;
chdir($InputDir) or die "Can't cd dir: $!\n" ;
foreach my $file (@list){
    my $Basename = basename($file,($Ext));
    print "\"$InputDir"."$file\"\n";
}