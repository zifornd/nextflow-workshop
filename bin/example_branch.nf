workflow {
    params.input = "data/samplesheet.csv"

    Channel.fromPath(params.input)
      .splitCsv(header: true)
      .map{ row -> [[sample:row.sample,strand:row.type],[row.fastq_1,row.fastq_2]]}
      .branch{ meta, reads ->
        single: meta.strand == "single"
        paired: meta.strand == "paired"
      }
      .set { samples }
    samples.single.view()
}
