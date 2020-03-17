# ui.R

library(shinydashboard)
library(ggplot2)

source("dados.r")

item <- df %>% 
        arrange(location)

ui <- dashboardPage(
  
  dashboardHeader(title = "Dashboard Zica Virus"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Regiões", tabName = "regioes", icon = icon("chart-bar")),
      menuItem("Datas de Coleta", tabName = "datas", icon = icon("chart-bar"))
      
    )
  ),
  
  dashboardBody(
      tabItems(
      tabItem(tabName = "regioes", 
              fluidRow(box(width = 4, background = "green",
                       selectInput(inputId = "sel_regiao", label = "Selecione Uma Região", 
                                   choices = unique(df$location_type), 
                                   selected = 1)
                            ),
                       valueBoxOutput(width = 3, outputId = "value_observations")
                       
                      ),
              fluidRow(box(width = 12, 
                           plotOutput(outputId = "hist_regiao")
                          )
                      )
              ),
      tabItem(tabName = "datas", 
              fluidRow(box(width = 2, background = "red",
                           selectInput(inputId = "sel_periodo_data", label = "Selecione Uma data", 
                                       choices = unique(df$report_date), 
                                       selected = 1)
              ),
                       box(width = 3, background = "light-blue",
                               selectInput(inputId = "sel_periodo_estado", label = "Selecione Um Estado", 
                                           choices = unique(item$location), 
                                           selected = 1)
                       ),
              valueBoxOutput(width = 3, outputId = "value_observations_est"),
              valueBoxOutput(width = 2, outputId = "value_observations_data")
              
              ),
              fluidRow(box(width = 12,
                           plotOutput(outputId = "hist_periodo_data")
              )
              ),
              fluidRow(box(width = 12,
                           plotOutput(outputId = "hist_periodo_estado")
                           )
                       )
              
              )
              )
              )
)


