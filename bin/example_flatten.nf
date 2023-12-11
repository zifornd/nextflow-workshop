input_ch = Channel.from(["path/file1.fastq", "path/file2.fastq"], ["path/file3.fastq", "path/file4.fastq"], ["path/file5.fastq", "path/file6.fastq"])

input_ch
    .flatten()
    .view()
