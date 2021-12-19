process minimap2{
    container "nanozoo/minimap2"
    input:

    script:
        """
            minimap2 --version
        """
}