#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// Include workflow
include { TRIMALIGN } from "workflows/trimalign"


workflow {
    TRIMALIGN()
}