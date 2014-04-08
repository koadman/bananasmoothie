#!/usr/bin/env perl
while(my $line = <STDIN>){
	next if $line =~ /^\#/;
	next unless $line =~ /CDS/;
	my @l = split(/\t/, $line);
	my $gene_id = $1 if $line =~ /Name=(.+?)\;/;
	print STDERR "skipping $line because gene is out-of-frame\n" if($l[7] > 0);
	next if $l[7] > 0; # avoid CDS that start out-of-frame
	print "$l[0]\t$l[1]\t$l[2]\t$l[3]\t$l[4]\t$l[5]\t$l[6]\t$l[7]\tgene_id \"$gene_id\"; transcript_id \"$gene_id\"; transcript_type \"protein_coding\"; gene_type \"protein_coding\"; gene_name \"$gene_id\"; transcript_name \"$gene_id\";\n";
}
