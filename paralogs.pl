=head
Author: Lalitha Viswanathan
Wrapper for finding paralogs using blast (Calls formatdb and then blastall)
=cut
#print "in the first line of file\n";
if($#ARGV<1)
{
	print "Usage is in the form <inputfile name> <database name> <cutoff>\n";
	exit(0);
}
$inputfile=@ARGV[0];
$database=@ARGV[1];
if(@ARGV[2])
{
	$cutoff=@ARGV[2];
}
else
{
	$cutoff=1e-50;
}
print $inputfile." ". $database." ".$cutoff."\n";
$outputfile=$inputfile.".out";
system(`./formatdb -i $database -p F`);
print "after formatting database\n";
system(`./blastall -i $inputfile -d $database -p blastn -o $outputfile -e $cutoff`);
print "after performing blast\n";
system(`perl paralogs.pl $outputfile >> processed_results`);
print "after putting the parsed output into processed results.\n";
