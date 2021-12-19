process fastqc{
    //tag "$meat.id"
    label 'process_medium'

    cpus 2
    memory "10G"
    container 'pegi3s/fastqc'

    publishDir "/home/hqyone/mnt/2tb/code/dock_nextflow/data_final", mode:'copy'
    input:
        tuple(val(sample), path(fq1)) //from samples
    output:
        path("*.zip"), emit: zips //into zips
    
    script:
        """
            fastqc -t ${task.cpus} $fq1
        """
}