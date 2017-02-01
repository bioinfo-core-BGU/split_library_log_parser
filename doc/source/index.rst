====================================================
Welcome to split_library_log_parser's documentation!
====================================================

**Author**: Menachem Sklarz

**Date**:   24/1/2017

Why should I need this?
-------------------------


Usage
---------

Simple! Just execute the following:::

    Rscript parse_split_library_log.R   \
        --input split_library_log.txt   \
        --output split_library_log.tsv   
    
Where:

--input file        Path to split_library_log.txt
--output file       Path to tab-delimited output file

Dependencies
-------------

Please make sure you have the following libraries installed in your R version:

* magrittr
* optparse
* tools



