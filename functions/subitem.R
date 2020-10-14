subitem <- function(x){
  if (str_detect(x, "<")) {
    item_name <- qdapRegex::ex_between(x, "<", ">")[[1]]
    item_original <- paste0("< ", item_name , " >")
    item_replace <- paste0("\n\n *", item_name , "* \n\n")
    names(item_replace) <- item_original
    string <- str_replace_all(x, item_replace)
  } else {
    string <- x
  }
  return(string)
}
