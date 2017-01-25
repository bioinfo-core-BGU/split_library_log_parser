library(magrittr)
library(optparse)
library(tools)

# I added this for testing



## Author: Menachem Sklarz
## GITHUB repository: https://github.com/sklarz-bgu/split_library_log_parser.git
## ReadsTheDocs: http://split-library-log-parser.readthedocs.io/en/latest/

# 
# paste("Rscript",
#       "parse_split_library_log.R",
#       "--input",    "split_library_log.txt") %>% system
# paste("Rscript","parse_split_library_log.R","-h") %>% system


args = commandArgs(trailingOnly=TRUE)

option_list = list(
    make_option(c("-i", "--input"), type="character", default="split_library_log.txt", 
                help="Path to split_library_log.txt", metavar="character"),
    make_option(c("-o", "--output"), type="character", default=NULL, 
                help="Path to tab-delimited output file", metavar="character")
); 



opt_parser = optparse::OptionParser(usage = "usage: %prog [options]", 
                                    option_list=option_list,
                                    epilogue="\n\nAuthor: Menachem Sklarz");
opt = optparse::parse_args(opt_parser);


if(!file.exists(opt$input)){
    stop("The input file does not exist!")
}

if(!exists(x = "output",opt)) {
    opt$output <- sprintf("%s.tsv",file_path_sans_ext(opt$input))
    cat(sprintf("No output passed. Writing to %s",opt$output))
}

t1 <- readLines(opt$input)


files <- grep(pattern = "Sequence read filepath",t1,value = T)  %>% 
    strsplit(.," ")                                     %>% 
    lapply(.,function(x) x[4])                          %>% 
    unlist  %>% 
    basename()

total_seqs <- grep(pattern = "Total number seqs written",t1,value = T)  %>% 
    strsplit(.,"\t")                                     %>% 
    lapply(.,function(x) x[2])                          %>% 
    unlist  %>%
    as.numeric

total_input <- grep(pattern = "Total number of input sequences",t1,value = T)  %>% 
    strsplit(.,":")                                     %>% 
    lapply(.,function(x) x[2])                          %>% 
    unlist          %>%
    as.numeric

barcode <- grep(pattern = "Barcode not in mapping file",t1,value = T)  %>% 
    strsplit(.,":")                                     %>% 
    lapply(.,function(x) x[2])                          %>% 
    unlist         %>%
    as.numeric

quality <- grep(pattern = "Read too short after quality truncation",t1,value = T)  %>% 
    strsplit(.,":")                                     %>% 
    lapply(.,function(x) x[2])                          %>% 
    unlist         %>%
    as.numeric

Nchars <- grep(pattern = "Count of N characters exceeds limit",t1,value = T)  %>% 
    strsplit(.,":")                                     %>% 
    lapply(.,function(x) x[2])                          %>% 
    unlist         %>%
    as.numeric

illumina_qual <- grep(pattern = "Illumina quality digit = 0",t1,value = T)  %>% 
    strsplit(.,":")                                     %>% 
    lapply(.,function(x) x[2])                          %>% 
    unlist         %>%
    as.numeric

barcode_errors <- grep(pattern = "Barcode errors exceed max",t1,value = T)  %>% 
    strsplit(.,":")                                     %>% 
    lapply(.,function(x) x[2])                          %>% 
    unlist         %>%
    as.numeric

Median_length <- grep(pattern = "Median sequence length",t1,value = T)  %>% 
    strsplit(.,":")                                     %>% 
    lapply(.,function(x) x[2])                          %>% 
    unlist         %>%
    as.numeric


write.table(x = 
                data.frame(sample=files, 
                           total_input = total_input ,
                           barcode = barcode ,
                           quality = quality ,
                           Nchars = Nchars ,
                           illumina_qual = illumina_qual ,
                           barcode_errors = barcode_errors ,
                           Median_length = Median_length,
                           total_seqs=total_seqs),
            file = opt$output,
            append = F,
            quote = F,
            sep = "\t",
            row.names = F,
            col.names = T)