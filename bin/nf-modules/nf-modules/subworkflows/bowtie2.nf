#!/usr/bin/env nextflow

include { BOWTIE2_BUILD    } from '/home/diya/nf-modules/modules/bowtie2_build'
include { BOWTIE2_ALIGN as BOWTIE2_ALIGN_CUTADAPT } from '/home/diya/nf-modules/modules/bowtie2_align'
include { BOWTIE2_ALIGN as BOWTIE2_ALIGN_TRIMMOMATIC } from '/home/diya/nf-modules/modules/bowtie2_align'

workflow BOWTIE2 {
    take:
    fasta_ch // channel: [ path(fasta) ]
    cutadapt_reads
    trimmomatic_reads

    main:
    ch_versions = Channel.empty()

    BOWTIE2_BUILD(fasta_ch)
    ch_versions = ch_versions.mix(BOWTIE2_BUILD.out.versions)

    BOWTIE2_ALIGN_CUTADAPT(cutadapt_reads,BOWTIE2_BUILD.out.index,false,false)
    ch_versions = ch_versions.mix(BOWTIE2_ALIGN_CUTADAPT.out.versions)

    BOWTIE2_ALIGN_TRIMMOMATIC(trimmomatic_reads,BOWTIE2_BUILD.out.index,false,false)
    ch_versions = ch_versions.mix(BOWTIE2_ALIGN_TRIMMOMATIC.out.versions)

    emit:
    indexes = BOWTIE2_BUILD.out.index
    cutdapt_aligned= BOWTIE2_ALIGN_CUTADAPT.out.aligned
    cutadapt_log= BOWTIE2_ALIGN_CUTADAPT.out.log
    trimmomatic_aligned= BOWTIE2_ALIGN_TRIMMOMATIC.out.aligned
    trimmomatic_log= BOWTIE2_ALIGN_TRIMMOMATIC.out.log

    versions = ch_versions                    
}