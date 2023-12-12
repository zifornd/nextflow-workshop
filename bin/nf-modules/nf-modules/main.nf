#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// Include workflow
include { TRIMALIGN } from "/home/diya/nf-modules/workflows/trimalign"


workflow {
    TRIMALIGN()
}