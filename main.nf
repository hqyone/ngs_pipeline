nextflow.enable.dsl=2

include { fastqc } from './modules/fastqc/main_old'
include { ECHO_META_NAME} from './modules/mod_test/main'

workflow{
    sample_sheet = "../code/ngs_pipeline/test/sample_sheet.csv"
    samples = Channel.fromPath(sample_sheet)
                .splitCsv(header:true, sep:",")
                .map {row->tuple(row.sample_id, file(row.fastq1))}.view()
    out1=fastqc(samples)
    ECHO_META_NAME(out1.zips.toList())
}