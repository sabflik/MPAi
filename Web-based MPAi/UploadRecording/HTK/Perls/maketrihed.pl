#!/usr/bin/perl
#
# make a .hed script to clone monophones in a phone list 
# 
# rachel morton 6.12.96

die "Usage: $0 <monolist> <trilist> <output dir>\n" unless @ARGV == 3;
($monolist, $trilist, $output) = @ARGV;

$mktri = $output."mktri.hed";
# open .hed script
open(MONO, $monolist);
# open .hed script
open(HED, ">$mktri");

$trilist =~ s/\\/\//g;
print HED "CL \"$trilist\"\n";

# 
while ($phone = <MONO>) {
       chop($phone);
       if ($phone ne "") { 
	   print HED "TI T_$phone {(*-$phone+*,$phone+*,*-$phone).transP}\n";
       }
   }
