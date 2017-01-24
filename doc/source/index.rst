.. split_library_log_parser documentation master file, created by
   sphinx-quickstart on Tue Jan 24 08:21:38 2017.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome to split_library_log_parser's documentation!
====================================================

**Author**: Menachem Sklarz

**Date**:   24/1/2017

Why should I need this?
-------------------------

When using QIIME, one of the first steps is the ``split_libraries_fastq.py`` script which *performs demultiplexing of Fastq sequence data where barcodes and sequences are contained in two separate fastq files*, while also doing some basic quality testing.

This step creates a log file, *split_library_log.txt*, which contains statistics about the number of reads per sample that passed the various tests and manipulations.

``parse_split_library_log.R`` converts this text file into a tsv table, which is more convenient for comparison between the samples etc. 

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



