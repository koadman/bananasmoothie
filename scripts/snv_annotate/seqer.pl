#!/usr/bin/env perl
use strict;
use warnings;
use Bio::SeqIO;

my $lenny = 0;
my $inseq = Bio::SeqIO->new(-file   => "<$ARGV[0]",-format => "genbank"); 
while (my $seq = $inseq->next_seq) {
	my $acc = $seq->accession_number;
	for my $feat_object ($seq->get_SeqFeatures) {          
	   next unless $feat_object->primary_tag eq "CDS";          
	   for my $tag ($feat_object->get_all_tags) {
		next unless $tag eq "protein_id";
	      for my $value ($feat_object->get_tag_values($tag)) {
		my $location = $feat_object->location;
		my $ss = $location->strand < 0 ? "-" : "+";
		my $start = $location->start;
		$start--;# if $start > 1;
		my $end = $location->end;
		print ">$value|$value|$value|$value|$acc.1|$ss|$start|$end\n";
		my $seqy = $feat_object->spliced_seq->seq();
		$seqy = $feat_object->spliced_seq->revcom()->seq() if $ss eq "-";
		$lenny += length($seqy);
		print $seqy."\n";
	      }          
	   }       
	}	
}
print STDERR "total coding bases: $lenny\n";
