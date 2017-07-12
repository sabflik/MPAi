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

my $script = "script.scp";
#print $OutputDir.$script."\n";

open(STDOUT, '>', $OutputDir.$script) or die "can't open file script.scp:$!";

if(-d $InputDir) {
    opendir(DH, "$InputDir") or die "Can't open: $!\n" ;
    #load all the files in $InputDir which have suffix "wav"
    my @list = grep {/$Ext$/ && -f "$InputDir/$_" } readdir(DH) ;
    closedir(DH) ;
    chdir($InputDir) or die "Can't cd dir: $!\n" ;
    foreach my $file (@list){
        PrintFile($InputDir."\\".$file);
    }
} 
elsif(-f $InputDir){
    PrintFile($InputDir);
} 

sub PrintFile {
    my ($fullname) = @_;
    if(-f $fullname){
       my ($name,$path,$suffix) = fileparse($fullname,($Ext)); 
       if($Ext eq "wav" || $Ext eq "WAV"){
           print "\"$path"."$name"."$suffix\" "."\"".$OutputDir."$name"."mfc\"\n" ;
       }
       elsif($Ext eq "mfc" || $Ext eq "MFC"){
           print "\"$path"."$name"."$suffix\"\n";
       }      
    }
}

