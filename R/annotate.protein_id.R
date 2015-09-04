.toProzorInput <- function(data){
  xx = lapply( data, function(x){ cbind("peptideSequence" = x$peptideSequence, "peptideModSequence" = x$peptideModSeq, "z" = x$charge, "m" = x$pepmass ) })
  bb = matrix(unlist(xx),ncol=length(xx[[1]]),byrow=T)
  colnames(bb) = c("peptideSequence", "peptideModSequence", "z", "m")
  return(bb)
}

annotate.protein_id <- function(data,
                                file = NULL,
                                fasta = read.fasta(file = file, as.string = TRUE, seqtype="AA"),
                                digestPattern = "(([RK])|(^)|(^M))"
                                ,mcCores = parallel::detectCores(logical=FALSE)
                                ){
  message("start protein annotation ..." )
  library(prozor)
  tmp = .toProzorInput(data)
  res = annotatePeptides(tmp, fasta, mcCores = mcCores)

  pepProtMapping<-list()
  for(i in 1:dim(res)[1]){
    pepSeq = res[i,"peptideSequence"]
    pepProtMapping[[pepSeq]] <- c(pepProtMapping[[pepSeq]], res[i,"proteinID"])
  }
  
  for(i in 1:length(data)){
    tmp = pepProtMapping[[ data[[i]]$peptideSequence ]]
    if(!is.null(tmp)){
      data[[i]]$proteinInformation <- tmp
    } else {
      data[[i]]$proteinInformation <- vector(length=0 , mode="character")
    }
  }
  
  class(data) <- "psmSet"
  return(data)
}

