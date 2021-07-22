=head
Author: Lalitha Viswanathan
Org: Tata Consultancy Services
Script for parsing blast results 
=cut
$file=@ARGV[0];
print $file."\n";
open(fh,$file);
chomp($string=<fh>);
$found=0;
while($string)
{
	chomp($string);
	if($string =~ m/Query=/)
	{
		$t=$string;
		#once i find a line containing "Query=" read the next lines till a line "Sequence producing significant alignments" is obtained
		while(1)
		{
			$string=<fh>;
			if($string =~ m/Sequences producing significant/)
			{last;}	
		}
		#the lines after this line will just print the results of alignment and print e-value for each
		#flag is required so that query statement is printed only once
		$flag=0;
		while(1)
		{
			$string=<fh>;
			if($string =~ m/>/)
			{
			print $string;
			last;}
			#read line and split it to get e-value
			@arr1=split(/\s+/,$string);
			$t =~ s/,|Query=//;
			$arr1[0]=~ s/,//;
			print "Alignment of $t with : ";	
			print "$arr1[0] Eval : $arr1[2]\n";
		}
	}
		elsif($string=~ m/>/)
		{
		        print $string."\n";
			$string=<fh>;
			$string=<fh>;
			$string=<fh>;
			#this third line contains the evalue;
			#parse this third line
			@arr2= split(/Expect = /,$string);
		        $string=<fh>; $string=<fh>; $string=<fh>; 
		}
	   	elsif($string=~ m/Query:/)
	   	{
			$string=~ s/Query://;
	   		print $string."\n";	
		}
		elsif($string=~ m/Sbjct:/)
	  	{
			$string=~ s/Sbjct://;	
	   		print $string."\n";	
	  	}			    	
$string=<fh>;
}
close(fh);
