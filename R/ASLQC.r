#' @title aslprep.QC
#'
#' @description collating all aslprep QC data into a single .csv file
#'
#' @details This function collates all aslprep QC data into a single .csv file
#'
#' @param filename Filename of the .csv file. Set to `ASLPREP_QC.csv` by default
#' @returns outputs a .csv file containing the aslprep QC data and the bash script `del.sh` if there are scans that fail the QC
#'
#' @examples
#' \dontrun{
#' aslprep.QC()
#' }
#' @export

########################################################################################################
########################################################################################################

asl.QC=function(filename="ASLPREP_QC.csv")
{
  #compile QC data from all subjects and sessions
  filelist=list.files(path = Sys.glob("sub-*"),pattern = "_desc-qualitycontrol_cbf.tsv", recursive = T,full.names = T)
  subses=basename(gsub(pattern = "_desc-qualitycontrol_cbf.tsv","",filelist))  
  for(sub in 1:length(filelist))
  {
    if(sub==1)
    {
      dat=read.table(filelist[sub],header = T) 
      if("acq" %in% colnames(dat))
      {
        dat$acq=NULL
      }
    } else
    {
      dat.temp=read.table(filelist[sub],header = T)
      if("acq" %in% colnames(dat.temp))
      {
        dat.temp$acq=NULL
      }  
      dat=rbind(dat,dat.temp)
      remove(dat.temp)
    }
  }
  
  #identify scans that fail QC
  idx=which(dat$ratio_gm_wm_cbf<1 | dat$mean_fd>1)
  if(length(idx)>0)
  {
    ##if runs are detected
    if("run" %in% colnames(dat))
    {
      if(length(unique(dat$run))==1)
      {
        del.sh=paste0("rm -rf sub-",dat$sub[idx],"/ses-",dat$ses[idx])    
      } else
      {
        del.sh=paste0("rm -rf sub-",dat$sub[idx],"/ses-",dat$ses[idx],"/sub-",dat$sub[idx],"_ses-",dat$ses[idx],"_run-",dat$run[idx],"*")    
      }
    } else
    {
      del.sh=paste0("rm -rf sub-",dat$sub[idx],"/ses-",dat$ses[idx])    
    }
  }
  if(length(del.sh)>0)
  {
    cat(paste0(length(del.sh), " ASL scans failed QC"))
    write.table(del.sh,row.names=F, col.names=F,quote=F, file="del.sh")
  } else
  { cat("all ASL scans passed QC")}
  write.table(dat, file=filename, row.names = F, sep=",")
}

