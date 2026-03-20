#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// CHANNEL
sample_ch = Channel.fromFilePairs(params.input, checkIfExists: true)
fasta_ch = Channel.fromPath(params.fasta, checkIfExists: true)


// Include modules

include { CUTADAPT }    from "../modules/cutadapt"
include { TRIMMOMATIC } from "../modules/trimmomatic"


// Include subworkflow

include { BOWTIE2 }    from "../subworkflows/bowtie2"


// WORKFLOW
workflow TRIMALIGN {

    CUTADAPT (sample_ch)
    TRIMMOMATIC (sample_ch)
    BOWTIE2 (fasta_ch,CUTADAPT.out.reads,TRIMMOMATIC.out.trimmed_reads)

}

workflow.onComplete{

    println "SUCCESSFUL"

}
