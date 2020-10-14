# Function to print fraction in latex notation

fraction <- function(x){
  frac_string <- "[1-9]\\/[1-9]"
  if (str_detect(x, frac_string)) {
    frac_original <- str_extract_all(x, frac_string)[[1]]
    frac_new <- paste0("${\\\\frac{", gsub("/", "}{", frac_original), "}}$")
    names(frac_new) <- frac_original
    res <- str_replace_all(x, frac_new)
  } else {
    res <- x
  }
  return(res)
}
