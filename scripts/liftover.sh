#!/bin/bash
set -e
set -u
set -o pipefail

if [ "$#" -ne 1 ]
then
    echo "error: 1 argument required, you provided $#"
    exit 1
fi

sample=$(basename -s .vcf $1)

gatk LiftoverVcf --CHAIN hg19ToHg38.over.chain.gz \
       --INPUT ${sample}.vcf -OUTPUT ${sample}_hg38.vcf \
       --REFERENCE_SEQUENCE Homo_sapiens_assembly38.fasta \
       --REJECT ${sample}_rejects.vcf \
       --java-options "-Xmx4G" \
       --MAX_RECORDS_IN_RAM 10000 > >(tee ${sample}.log) 2>&1
