sample_sheet = "/home/hqyone/mnt/2tb/code/dock_nextflow/data-raw/sample_sheet.csv"
samples = Channel.fromPath(sample_sheet)
                .splitCsv(header:true, sep:",")
                .map {row->tuple(row.sample_id, file(row.fastq1))}.view()

process fastqc {
    //tag "$meat.id"
    label 'process_medium'

    cpus 2
    memory "10G"
    container 'pegi3s/fastqc'
    input:
        set (val(sample), path(fq1)) from samples
    output:
        file ("*.zip") into zips
        //file("*.html") //into htmls
    script:
        """
            fastqc -t ${task.cpus} $fq1
        """

}

process ECHO_META_NAME{
    input: 
        file (zipfile) from zips.toList().merge()
    script:
        """
            echo ${zipfile}
        """   
}



// process minimap2{
//     container "nanozoo/minimap2"
//     input:

//     script:
//         """
//             minimap2 --version
//         """
// }

// workflow run_fastqc{
//     take:
//         sample_sheet
//     emit:
//         fastqc_out
//     main:
//         samples = Channel.fromPath(sample_sheet)
//                 .splitCsv(header:true, sep:",")
//                 .map {row->tuple(row.sample_id, file(row.fastq1))}.view()
//         fastqc(samples)
// }

// workflow{
//     sample_sheet = "/home/hqyone/mnt/2tb/code/dock_nextflow/data-raw/sample_sheet.csv"
//     samples = Channel.fromPath(sample_sheet)
//                 .splitCsv(header:true, sep:",")
//                 .map {row->tuple(row.sample_id, file(row.fastq1))}.view()
//     //run_fastqc(sample_sheet)
//     // if run_fastqc(sample_sheet) 
//     // {
//     //     ECHO_META_NAME()
//     //     minimap2()
//     // }
//     out1 = fastqc_1(samples)
//     a(out1)
    
// }
workflow{
    sample_sheet = "/home/hqyone/mnt/2tb/code/dock_nextflow/data-raw/sample_sheet.csv"
    samples = Channel.fromPath(sample_sheet)
                .splitCsv(header:true, sep:",")
                .map {row->tuple(row.sample_id, file(row.fastq1))}.view()
    out1=fastqc1(samples)
    a(out1.zips.toList())
}