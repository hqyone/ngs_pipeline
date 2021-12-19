process ECHO_META_NAME{
    input: 
        file (zipfile)  //from zips.toList().merge()
    script:
        """
            echo ${zipfile}
        """   
}