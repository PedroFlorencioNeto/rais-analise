library(tidyverse)
library(basedosdados)

set_billing_id("")

# consulta que gera a quantidade vinculos totais e de clt por municipio e ano
query_estabelecimentos <- "
  SELECT
      id_municipio,
      sigla_uf,
      ano,
      SUM(quantidade_vinculos_ativos) AS emprego_total,
      SUM(quantidade_vinculos_clt) AS emprego_vinculo_clt

  FROM `basedosdados.br_me_rais.microdados_estabelecimentos`
  WHERE ano IN (2012, 2014, 2016)
  GROUP BY id_municipio,sigla_uf,ano
  ORDER BY sigla_uf,id_municipio,ano ASC
"

# consulta que gera o salario medio por raca-cor, municipio e ano
query_vinculos <- "
  SELECT id_municipio,
         sigla_uf,
         ano,
         CASE 
            WHEN raca_cor IN ('4', '8') THEN 'Negra'
            WHEN raca_cor = '1' THEN 'Indígena'
            WHEN raca_cor = '2' THEN 'Branca'
            WHEN raca_cor = '6' THEN 'Amarela'
            WHEN raca_cor = '9' THEN 'Não identificado'
            WHEN raca_cor = '-1' THEN 'Ignorado'
            ELSE 'Código não encontrado nos dicionários oficiais.'
          END AS raca_cor_nome,
        AVG(valor_remuneracao_media) AS salario_medio

  FROM `basedosdados.br_me_rais.microdados_vinculos`
  WHERE ano in (2012,2014,2016)
  GROUP BY id_municipio, sigla_uf,ano,raca_cor_nome
  ORDER BY sigla_uf,id_municipio,ano,raca_cor_nome ASC
"

query_salario_medio <-
  "SELECT id_municipio,
        sigla_uf,
        ano,
        AVG(valor_remuneracao_media) AS salario_medio
  
  FROM `basedosdados.br_me_rais.microdados_vinculos`
  WHERE ano in (2012,2014,2016)
  GROUP BY id_municipio, sigla_uf,ano
  ORDER BY sigla_uf,id_municipio,ano ASC"

# lendo a tabela de estabelecimentos do site Base de Dados
df_estabelecimentos <- read_sql(query_estabelecimentos, billing_project_id = get_billing_id())

# salvando df_estabelecimentos em formato csv
write.csv(df_estabelecimentos,"2012_2016_VinculosPorMunicipio.csv", row.names = FALSE)

# lendo a tabela de vinculos do site Base de Dados
df_vinculos <- read_sql(query_vinculos, billing_project_id = get_billing_id())

# salvando df_vinculos em formato csv
write.csv(df_vinculos,"2012_2016_SalarioMedioPorMunicipio.csv", row.names = FALSE)

salario_medio_total <- read_sql(query_salario_medio, 
                                billing_project_id = get_billing_id())

write.csv(salario_medio_total,"2012_2016_SalarioMedioTotal.csv", row.names = FALSE)
