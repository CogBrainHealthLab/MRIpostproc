############################################################################################################################
############################################################################################################################
#' @title modifyJSON
#'
#' @description A tool to edit .JSON files
#'
#' @details This function searches for .JSON files and adds or modify the one or multiple specified items
#'
#' @param json_files filename suffix for one (e.g., `"_asl.json"`)
#' @param new_items one or multiple new items specified as a list object (e.g, `list(a=1, b=2)`)
#'
#' @examples
#' \dontrun{
#' modifyJSON(json_files, new_items)
#' }
#' @importFrom rjson fromJSON toJSON
#' @export
########################################################################################################
########################################################################################################

modifyJSON <- function(json_file, new_items) 
{
# new_items must be a named list
  if (is.null(names(new_items)) || any(names(new_items) == "")) {
    stop("All new items must be named.")
  }
  filelist=list.files(pattern=json_file,recursive=T)
    for (file in filelist)
    {
    dat=rjson::fromJSON(file = file)
   
    for (name in names(new_items)) {dat[[name]] <- new_items[[name]]}

    write(rjson::toJSON(dat,2),file=file)
    remove(dat)
    }
}
