# Converter xlsx para csv e formatar campos para compilar texto

# Bibliotecas
library(openxlsx)
library(dplyr)

# Lendo os dados
## planilha original aqui: https://docs.google.com/spreadsheets/d/1xiJLw7yNojqxMAtKIie7MqhOaWVAt0RJZ0QW4OnhoCo/edit#gid=1047674169
metadados <- read.xlsx("dados/proposta_template_receitas.xlsx", sheet = 1)
receitas_id <- read.xlsx("dados/proposta_template_receitas.xlsx", sheet = 2) %>%
  filter(!is.na(ID))
ingredientes <- read.xlsx("dados/proposta_template_receitas.xlsx", sheet = 3)%>%
  filter(!is.na(ID))

# escrevendo os dados crus
write.csv(metadados, "dados/metadados.csv", row.names = FALSE)
write.csv(receitas_id, "dados/tabela_01_raw.csv", row.names = FALSE)
write.csv(ingredientes, "dados/tabela_02_raw.csv", row.names = FALSE)

# formatando receitas para entrada no texto ------------------------------------

## tempo de preparo
receitas_id$Tempo_preparo_unidade <- ifelse(receitas_id$Tempo_preparo > 1,
                                            "horas", "hora")
receitas_id$Tempo_preparo_string <- ifelse(is.na(receitas_id$Tempo_preparo),
                                           "",
                                           paste0("Tempo de preparo de ", receitas_id$Tempo_preparo, " ", receitas_id$Tempo_preparo_unidade, "."))

## memória
receitas_id$memoria_string <- ifelse(is.na(receitas_id$Memórias),
                                     "",
                                     gsub(">", "\n\n >", receitas_id$Memórias))

## dicas
receitas_id$dicas_string <- ifelse(is.na(receitas_id$`Dicas_&_Variações`),
                                   "",
                                   paste("**Dica**:", receitas_id$`Dicas_&_Variações`))

## fonte
receitas_id$fonte_string <- ifelse(is.na(receitas_id$Fonte),
                                   "",
                                   paste("**Fonte**:", receitas_id$Fonte))

## rendimento
receitas_id$rendimento_string <- ifelse(is.na(receitas_id$Rendimento),
                                   "",
                                   paste("**Rendimento**:", receitas_id$Rendimento))


## preparo
# identificar subitem
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

receitas_id$preparo_string <- unlist(lapply(receitas_id$Preparo, subitem))

# formatando os ingredientes para entrada no texto -----------------------------
ingredientes[is.na(ingredientes)] <- ""

if (knitr:::is_latex_output()) {space_string <- "  "} else {space_string <- "\\s"}

ingredientes$string <- paste("-",
                             ifelse(ingredientes$Quantidade_original != "",
                                    gsub("\\.0", "", ingredientes$Quantidade_original),
                                    space_string),
                             ingredientes$Un_medida_original,
                             ingredientes$Ingrediente)
#"\n\n\n\n")

write.csv(receitas_id, "dados/tabela_01.csv", row.names = FALSE)
write.csv(ingredientes, "dados/tabela_02.csv", row.names = FALSE)
