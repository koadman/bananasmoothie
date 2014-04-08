#!/bin/bash

#
# commands to get the reference genome and annotate the SNVs called by LoFreq
#
wget ftp://ftp.ncbi.nih.gov/genomes/Bacteria_DRAFT/Bacteroides_faecis_MAJ27_uid86875/NZ_AGDG00000000.scaffold.gbk.tgz
wget ftp://ftp.ncbi.nih.gov/genomes/Bacteria_DRAFT/Bacteroides_faecis_MAJ27_uid86875/NZ_AGDG00000000.scaffold.gff.tgz
tar xzf NZ_AGDG00000000.scaffold.gbk.tgz
cat NZ_AGDG0*.gbk >> allnz.gbk
cat NZ_AGDG0*.gff > allnz.gff
../scripts/snv_annotate/seqer.pl allnz.gbk > allnz_orfs.fa
../scripts/snv_annotate/gff_to_gtfhack.pl < allnz.gff > allnz.gtfhack
~/software/vat-2.0.1/src/gencode2interval < allnz.gtfhack > allnz.interval

find `pwd` -name "*.lf.bz2" -exec ../scripts/snv_annotate/annotator.sh {} \;
