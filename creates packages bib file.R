# get packages loaded in all Rmd files of a folder
libs = lapply(list.files(pattern = "\\.Rmd$"),
              function(x){
                d = readLines(x)
                d = d[grepl("library\\(.*\\)", d)]
                gsub("library\\((.*)\\)", "\\1", d)
              })
pckgs <- str_squish(unique(unlist(libs)))
pckgs


# generates the .bib file
knitr::write_bib(pckgs, "packages.bib")
