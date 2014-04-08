#!/usr/bin/env perl
# Convert lofreq on stdin to vcf on stdout
print "#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO\n";
while(my $line = <STDIN>){
	chomp $line;
	my @l = split(/\s/, $line);
	my $chr = $1 if $l[0] =~ /(NZ_.+)\|/;
	my $ref = $1 if $l[2] =~ /(.)\>/;
	my $alt = $1 if $l[2] =~ /\>(.)/;
	print "$chr\t$l[1]\tnone\t$ref\t$alt\t30\tPASS\tabundance=$l[3];$l[4]\n";
}
