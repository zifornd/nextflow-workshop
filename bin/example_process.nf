#!/usr/bin/env nextflow
params.input = "/home/sinrasu/sinrasu-test/*_{1,2}.fastq.gz"

process FASTQC {

    tag "$meta.id"
    cpus 2
    memory 1.GB

    conda "bioconda::fastqc=0.11.9"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/fastqc:0.11.9--0' :
        'biocontainers/fastqc:0.12.1--hdfd78af_0' }"

    input:
    tuple val(meta), path(reads)

    output:
    tuple val(meta), path("*.html"), emit: html
    tuple val(meta), path("*.zip") , emit: zip

    script:
    """
    fastqc $reads
    """
}

workflow {
    sample_ch = Channel.fromFilePairs(params.input, checkIfExists: true)
    sample_ch.view()
    FASTQC(sample_ch)
}