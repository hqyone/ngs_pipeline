nextflow.enable.dsl=2

//include { fastqc } from './modules/fastqc/main_old'
//include { ECHO_META_NAME} from './modules/mod_test/main'

//fq1= "/home/hqyone/mnt/2tb/code/dock_nextflow/data-raw/test.fastq"
//samples = Channel
                //.fromPath('/home/hqyone/mnt/2tb/code/dock_nextflow/data-raw/*.fastq')
                //.map { file -> tuple(file.baseName, file) }


// process fastqc{
//     cpus 2
//     memory "10G"
//     container 'pegi3s/fastqc'

//     publishDir "/home/hqyone/mnt/2tb/code/dock_nextflow/data_final", mode:'copy'
//     input:
//         set val(sample), file(fq1) from datasets
//     output:
//         file("${sample}_fastqc.zip") into fastqc_files
    
//     script:
//         """
//             fastqc -t ${task.cpus} $fq1
//         """
// }

// sample_sheet = "/home/hqyone/mnt/2tb/code/dock_nextflow/data-raw/sample_sheet.csv"
// samples = Channel.fromPath(sample_sheet)
//                 .splitCsv(header:true, sep:",")
//                 .map {row->tuple(row.sample_id, file(row.fastq1))}.view()

// process fastqc1 {
//     //tag "$meat.id"
//     label 'process_medium'

//     cpus 2
//     memory "10G"
//     container 'pegi3s/fastqc'

//     publishDir "/home/hqyone/mnt/2tb/code/dock_nextflow/data_final", mode:'copy'
//     input:
//         tuple val(sample), file(fq1) from samples
//     output:
//         tuple val(sample),file("*.zip") emit: zips
//         tuple val(sample), file("*.html") emit: htmls
    
//     script:
//         """
//             fastqc -t ${task.cpus} $fq1
//         """
// }

process fastqc1 {
    //tag "$meat.id"
    label 'process_medium'

    cpus 2
    memory "10G"
    container 'pegi3s/fastqc'
    input:
        tuple(val(sample), path(fq1)) //from samples
    output:
        path("*.zip"), emit: zips //into zips
        //file("*.html") //into htmls
    script:
        """
            fastqc -t ${task.cpus} $fq1
        """

}

process a{
    input: 
        file (zipfile)  //from zips.toList().merge()
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
    sample_sheet = "../code/ngs_pipeline/test/sample_sheet.csv"
    samples = Channel.fromPath(sample_sheet)
                .splitCsv(header:true, sep:",")
                .map {row->tuple(row.sample_id, file(row.fastq1))}.view()
    out1=fastqc1(samples)
    a(out1.zips.toList())
}