#R
.annotateProteinIDGrep <- function(x , fasta, digestPattern ){
  sequence = x$peptideSequence
  idx <- grep (sequence,  fasta, fixed = TRUE)
  
  pattern = paste(digestPattern, sequence, sep='')
  selected <- fasta[idx]
  idx2 <- grep(pattern, selected, fixed=FALSE)
  idx<-idx[idx2]
  x$proteinInformation = names(fasta)[idx]
  return(x)
}

annotate.protein_id <- function(data,  
                                file = NULL,
                                fasta = read.fasta(file = file, as.string = TRUE, seqtype="AA"),
                                digestPattern = "(([RK])|(^)|(^M))"
                                ){
  message("start protein annotation ..." )
  time.start <- Sys.time();
  
    if(require(BiocParallel) & length(data) > 200){
      #data <- BiocParallel::bplapply(data, .annotateProteinIDGrep, fasta, digestPattern) 
      data <- parallel::mclapply(data, .annotateProteinIDGrep, fasta, digestPattern, mc.cores = min(4,detectCores() )) 
      
    }else{
      data <- lapply(data, .annotateProteinIDGrep, fasta, digestPattern)
    }
  class(data) <- "psmSet"
  time.end <- Sys.time();
  message(paste("time taken: ", difftime(time.end, time.start, units='mins'),  "minutes"))
  return(data)
}

