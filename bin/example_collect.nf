workflow {
  sample_ch = Channel.fromFilePairs("./data/reads/*_{1,2}.fastq.gz", checkIfExists:true)
                .collect()
  sample_ch.view()
}
