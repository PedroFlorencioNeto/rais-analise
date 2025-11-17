# Análise de Dados da RAIS (2012-2016)

Este repositório contém os scripts e o relatório de uma análise exploratória e estatística realizada sobre a base de dados da Relação Anual de Informações Sociais (RAIS).

A **RAIS** é uma fonte de dados essencial para o acompanhamento do mercado de trabalho formal no Brasil, sendo utilizada para gerar estatísticas e subsidiar políticas públicas.

## Objetivo do Projeto

O objetivo principal desta análise é:

1.  **Exploração Inicial:** Limpar, tratar e realizar uma análise exploratória dos dados da RAIS.
2.  **Segmentação:** Investigar o perfil dos vínculos empregatícios por diferentes dimensões.

## Fonte de Dados

* **Dados:** Relação Anual de Informações Sociais (RAIS)
* **Período:** 2012-2016
* **Disponibilidade:** Os dados brutos podem ser obtidos publicamente através do Ministério do Trabalho e Emprego (MTE).

## Como Visualizar o Relatório

O relatório final da análise (gerado a partir do `relatorio.Rmd`) pode ser visualizado diretamente no RPubs, no link original:

[**Análise de Dados da RAIS no RPubs**](https://rpubs.com/pedroflorencio/rais)

## Como Executar a Análise

Para reproduzir a análise localmente, siga os seguintes passos:

1.  **Clone o Repositório:**
    ```bash
    git clone [Link do Repositório, se houver]
    ```
2.  **Instale os Pacotes:** Abra o RStudio e instale os pacotes necessários:
    ```R
    install.packages(c("tidyverse", "readr", "ggplot2", "dplyr", "rmarkdown"))
    ```
3.  **Obtenha os Dados:** Baixe os microdados da RAIS para o diretório `data/`.
4.  **Execute o Script:** Execute os scripts em `scripts/` na ordem correta, ou compile o arquivo R Markdown:
    ```R
    rmarkdown::render("relatorio.Rmd")
    ```

## Autor

Este projeto foi desenvolvido por:

**[Pedro Florencio](https://rpubs.com/pedroflorencio)**
