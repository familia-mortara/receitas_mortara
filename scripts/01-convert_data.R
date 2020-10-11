# Converter xlsx para csv

# Bibliotecas
library(openxlsx)

# Lendo os dados
## planilha original aqui: https://docs.google.com/spreadsheets/d/1xiJLw7yNojqxMAtKIie7MqhOaWVAt0RJZ0QW4OnhoCo/edit#gid=1047674169
metadados <- read.xlsx("dados/proposta_template_receitas.xlsx", sheet = 1)
tabela_01 <- read.xlsx("dados/proposta_template_receitas.xlsx", sheet = 2)
tabela_02 <- read.xlsx("dados/proposta_template_receitas.xlsx", sheet = 3)

write.csv(metadados, "dados/metadados.csv", row.names = FALSE)
write.csv(tabela_01, "dados/tabela_01.csv", row.names = FALSE)
write.csv(tabela_02, "dados/tabela_02.csv", row.names = FALSE)
