setwd("C:/CientistadeDados/BigDataRAzure/MiniProjeto05 - Analise Exploratoria")
getwd()

## CARREGANDO OS DADOS


#install.packages("plotly")
#install.packages("shinydashboard")
#install.packages("shiny")
require("dplyr")
require(ggplot2)
require(plotly)

temp_files <- list.files(pattern = ".csv")
temp_files
arq1 <- lapply(temp_files, read.csv, stringsAsFactors = FALSE) 

df <- data.frame(arq1)

names(df)

df["time_period"] <- NULL
df["time_period_type"] <- NULL
df["unit"] <- NULL
df["data_field_code"] <- NULL
df["data_field"] <- NULL

agrupado_regiao <- df %>%
                   group_by(location) %>%
                   filter(location_type == "region") %>%
                   summarise(total = sum(value))

agrupado_estado <- df %>%
                   group_by(location) %>%
                   filter(location_type == "state") %>%
                   summarise(total = sum(value))

agrupado_data_estado <- df %>%
                   group_by(report_date, location) %>%
                   filter(location_type == "state") %>%
                   summarise(total = sum(value))

agrupado_data_regiao <- df %>%
                   group_by(report_date, location) %>%
                   filter(location_type == "region") %>%
                   summarise(total = sum(value))

barplot((agrupado_regiao$total / 10), 
        names.arg = agrupado_regiao$location,
        main = list("Contaminados por Região", font = 4),
        ylab = "Quatidades",
        xlab = "Estados",
        border = TRUE,
        col = rainbow(20),
        space = 0.1
        )

ggplot(data=df, aes(x=df$location, y=df$value)) +
        geom_bar(stat="identity")

