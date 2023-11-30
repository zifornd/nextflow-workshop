#!/usr/bin/env nextflow

// Channel with explicit values
ch = Channel.of(1, 3, 5, 7)
ch.view { "value: $it" }

// Channel from a list
list = ['hello', 'world']
Channel.fromList(list).view()

// Channel from a text file
Channel.fromPath('./assets/random.txt').splitText().view()

// Channel from file pairs matching a pattern
Channel.fromFilePairs('./data/reads/*_{1,2}.fastq.gz').view()
