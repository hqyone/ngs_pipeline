process fastqc{
    //tag "$meat.id"
    label 'process_medium'

    cpus 2
    memory "10G"
    container 'pegi3s/fastqc'

    publishDir "/home/hqyone/mnt/2tb/code/dock_nextflow/data_final", mode:'copy'
    input:

        tuple val(sample), file(fq1) //from datasets
    output:
        file("*.zip")
        file("*.html")
    
    script:
        """
            fastqc -t ${task.cpus} $fq1
        """
}