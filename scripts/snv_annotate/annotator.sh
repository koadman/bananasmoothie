#!/bin/bash

BNAME=`basename $1 .filt.lf.bz2`
bzcat $BNAME.filt.lf.bz2 | ../scripts/snv_annotate/lofreq_to_vcf.pl > $BNAME.vcf
~/software/vat-2.0.1/src/snpMapper allnz.interval allnz_orfs.fa < $BNAME.vcf > $BNAME.annot.vcf
