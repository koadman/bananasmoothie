#!/bin/bash

#
# commands to run once before this:
# cat NZ_AGDG0*.gbk >> allnz.gbk
# cat NZ_AGDG0*.gff > allnz.gff
# ./seqer.pl allnz.gbk > allnz_orfs.fa
# ./gff_to_gtfhack.pl < allnz.gff > allnz.gtfhack
# ~/software/vat-2.0.1/src/gencode2interval < allnz.gtfhack > allnz.interval

BNAME=`basename $1 .filt.vcf`
./lofreq_to_vcf.pl < $BNAME.filt.vcf > $BNAME.really.vcf
~/software/vat-2.0.1/src/snpMapper allnz.interval allnz_orfs.fa < $BNAME.really.vcf > $BNAME.annot.vcf
