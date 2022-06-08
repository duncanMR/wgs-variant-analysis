#!/bin/bash
set -e
set -u
set -o pipefail

#This script takes a sample name as its first argument

if [ "$#" -ne 1 ]
then
    echo "error: 1 argument required, you provided $#"
    exit 1
fi
vcf_hg19="$1.vcf"
vcf_hg38="$1_hg38.vcf"
vcf_rejects="$1_rejects.vcf"
echo "$1 Sample"
#count rows which are not metadata
echo "$(grep -cv "^#" $vcf_hg19) TotalVariantsHG19"
echo "$(grep -cv "^#" $vcf_hg38) TotalVariantsHG38"
echo "$(grep -cv "^#" $vcf_rejects) TotalLiftoverRejects"
echo "$(grep -c "PASS" $vcf_hg19) TotalPASSVariantsHG19"
echo "$(grep -c "PASS" $vcf_hg38) TotalPASSVariantsHG38"

#extract info column, split annotations into separate lines with sed,
#count unique annotations
grep -v "^#" $vcf_rejects | cut -f7 | sed 's/;/\n/g'| sort | uniq -c\
             | grep -E "CannotLift|IndelStraddles|MismatchedRef|NoTarget"

