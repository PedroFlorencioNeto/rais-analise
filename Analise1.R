library(dplyr)
library(tidyr)
library(echarts4r)

df <- read.csv("2012_2016_DisparidadeSalarial.csv")

# remocao dos outliers para melhor visualização do histograma
Q1 <- quantile(df$razao_salario_medio, 0.25, na.rm = TRUE)
Q3 <- quantile(df$razao_salario_medio, 0.75, na.rm = TRUE)
IQR <- Q3 - Q1
# limiares
limite_inferior <- Q1 - 1.5 * IQR
limite_superior <- Q3 + 1.5 * IQR
# identificacao de outliers
outliers <- df %>%
  filter(razao_salario_medio < limite_inferior | razao_salario_medio > limite_superior)
# remocao dos outliers
dados_filtrados <- df %>%
  filter(razao_salario_medio >= limite_inferior & razao_salario_medio <= limite_superior)

# producao do histograma da razao salarial
dados_filtrados %>%
  filter(is.finite(razao_salario_medio) & !is.na(razao_salario_medio) & razao_salario_medio >= 0) %>%
  e_charts() %>%
  e_histogram(razao_salario_medio, name = "Quantidade", breaks = 30) %>%
  e_title("Distribuição da Razão Salarial entre Pessoas Brancas e Negras",
          textStyle = list(fontSize = 12)) %>%
  e_x_axis(name = "Razão", 
           min=0.5,
           max=1.590,
           interval=.05, 
           axisLabel = list(rotate = 45)) %>%
  e_y_axis(name = "Frequência") %>%
  e_theme("walden") %>%
  e_legend(show = FALSE) %>%
  e_tooltip(trigger = "axis")
