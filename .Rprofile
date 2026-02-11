
.update.me<-function() {
  paste0(running_key(paste0(paste(str_sub(First.Name,start=1L,end=1L)),paste(str_sub(First.Name,start=-1,end=-1)),paste(str_sub(Last.Name,start=1L,end=1L))),
                           c('QWERTYUIOPASDFGHJKLZXCVBNM'),decrypt=FALSE),str_length(paste0(First.Name,Last.Name)))
  
}
.update.marray<-function() {quiet(.update.me())}

setHook("rstudio.sessionInit", function(newSession) {
  if (newSession)
    file.edit('CMMB 461 Assignment 1 - R Code F24.R')
    setwd("/cloud/project/DataFiles")
}, action = "append")





