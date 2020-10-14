# Function to return string of image of a particular diet
diet <- function(tipo) {
  tipos <- receitas_id %>% select(starts_with("Dieta")) %>% names()
  figs <- c("figs/vegetarian.png",
            "figs/vegan.png",
            "figs/gluten-free.png",
            "figs/lactose-free.png")
  names(figs) <- tipos
  path_to_image <- figs[names(figs) == tipo]
  #img <- gsub("path_to_image", path_to_image,
  #            '<img src="path_to_image" height="0.10" width="0.10" />')
  img <- paste0('![image alt >](', path_to_image,  '){width=3%}')
  return(img)
}
