#!/usr/bin/env nextflow

process TRIMMOMATIC {

    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/trimmomatic:0.39--hdfd78af_2':
        'biocontainers/trimmomatic:0.39--hdfd78af_2' }"

    input:
    tuple val(meta), path(reads)

    output:
    tuple val(meta), path("*.paired.trim*.fastq.gz")   , emit: trimmed_reads
    tuple val(meta), path("*.unpaired.trim_*.fastq.gz"), optional:true, emit: unpaired_reads
    tuple val(meta), path("*.log")                     , emit: log
    tuple val(meta), path("*.summary")                 , emit: summary
    path "versions.yml"                                , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = "ILLUMINACLIP:${params.trimmomatic_illuminaclip} SLIDINGWINDOW:${params.trimmomatic_sliding_window} MINLEN:${params.trimmomatic_min_length}"
    def prefix = meta
    def trimmed = params.single_end ? "SE" : "PE"
    def output = params.single_end ?
        "${prefix}.SE.paired.trim.fastq.gz" // HACK to avoid unpaired and paired in the trimmed_reads output
        : "${prefix}.paired.trim_1.fastq.gz ${prefix}.unpaired.trim_1.fastq.gz ${prefix}.paired.trim_2.fastq.gz ${prefix}.unpaired.trim_2.fastq.gz"
    // TODO Give better error output
    def qual_trim = task.ext.args2 ?: ''
    """
    trimmomatic \\
        $trimmed \\
        -threads $task.cpus \\
        -phred33 \\
        -trimlog ${prefix}.log \\
        -summary ${prefix}.summary \\
        $reads \\
        $output \\
        $qual_trim \\
        $args

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        trimmomatic: \$(trimmomatic -version)
    END_VERSIONS
    """
}
