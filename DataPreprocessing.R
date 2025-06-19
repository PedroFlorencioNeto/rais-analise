library(dplyr)
library(tidyverse)

# aquisicao dos dados de vinculos, salario medio total e por raca/cor 
df_quantidade_vinculos <- read.csv('2012_2016_VinculosPorMunicipio.csv')
df_salario_medio <- read.csv('2012_2016_SalarioMedioPorMunicipio.csv')
df_salario_medio_total <- read.csv("2012_2016_SalarioMedioTotal.csv")

# pivotando a coluna categorica de raca_cor
df_salario_medio <- df_salario_medio %>% 
  pivot_wider(names_from = raca_cor_nome, values_from = salario_medio)

# juntando os dataframes
df_join <- left_join(df_quantidade_vinculos, 
                     df_salario_medio, 
                     by = c("id_municipio", "ano","sigla_uf"))
df_join <- df_join %>% mutate(id_municipio = as.character(id_municipio))

# adicionando coluna de salario medio sem agregacao por raca/cor
df_salario_medio_total <- df_salario_medio_total %>% 
                            mutate(id_municipio = as.character(id_municipio))

df_completo <- left_join(df_join, 
                         df_salario_medio_total, 
                         by = c("id_municipio", "ano","sigla_uf"))

# adicionando razao entre salario medio de pessoas brancas e negras
df_completo <- df_completo %>% mutate(razao_salario_medio = Branca / Negra)

# selecao das variaveis necessarias
df <- df_completo %>% select('id_municipio',
                             'sigla_uf',
                             'ano',
                             'emprego_total',
                             'emprego_vinculo_clt',
                             'salario_medio',
                             'salario_medio_brancos'='Branca',
                             'salario_medio_negros'='Negra',
                             'razao_salario_medio')

# arredondando os valores numericos
df <- df %>%
  mutate(salario_medio = round(salario_medio, 2),
         salario_medio_brancos = round(salario_medio_brancos, 2),
         salario_medio_negros = round(salario_medio_negros, 2),
         razao_salario_medio = round(razao_salario_medio, 2))

# salvando a tabela em formato CSV 
write.csv(df,"2012_2016_DisparidadeSalarial.csv", row.names = FALSE)