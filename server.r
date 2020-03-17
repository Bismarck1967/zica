# server.R

library(shiny)
library(ggplot2)

source("dados.r") 

plot.histogram <- function(df, X, Y, titulo, titX, titY)
{
    out <- ggplot(df, aes_string(x = X, y = Y, fill = Y)) +
     geom_bar(colour="black", stat="identity")        +
     guides(fill=FALSE)                               +
     ggtitle(titulo)                                  +
     xlab(titX)                                       + 
     ylab(titY) +
     geom_text(aes(label=df[[Y]]), size = 6, vjust = -0.2, nudge_y = 0.5, colour = "black", fontface = "bold" ) 
     
  return(out)  
  
}
plot.histogram_h <- function(df, X, Y, titulo, titX, titY) 
{
    out <- ggplot(df, aes_string(x = X, y = Y, fill = Y)) +
     geom_bar(colour="black", stat="identity")        +
     guides(fill=FALSE)                               +
     ggtitle(titulo)                                  +
     xlab(titX)                                       + 
     ylab(titY) +
      coord_flip() +
     geom_text(aes(label=df[[Y]]), size = 4, vjust = 0.3, hjust = -0.1, nudge_y = 0.5, colour = "black", fontface = "bold" ) 
     
  return(out)  
  
}

server <- function(input, output)
{
  output$hist_regiao <- renderPlot(
  {
    item <- df[df$location_type == input$sel_regiao, ]
    item <- item %>% 
       group_by(location, location_type) %>%
       summarise(value = sum(value))
    
    plot <- plot.histogram(item, "location", "value", "Gráfico por Regiao", "Estado/Região", "Quantidade de Casos")
    plot
  })
 output$hist_periodo_data <- renderPlot(
  {
    item <- df[df$report_date == input$sel_periodo_data, ]
    item <- item %>% 
      filter(location_type != "PAIS" & location_type != "REGIOES"  ) 
   plot <- plot.histogram_h(item, "location", "value", "Gráfico por Período / Estado", "Estados", "Quantidade de Casos")
    plot
  })
  output$hist_periodo_estado <- renderPlot(
  {
    item <- df[df$location == input$sel_periodo_estado, ]
    plot <- plot.histogram(item, "report_date", "value", "Gráfico por Período / Estado", "Data de Coleta", "Quantidade de Casos")
    plot
  })
  
  output$value_observations <- renderValueBox(
  {
    valueBox(
      format(sum(df[df$location_type == input$sel_regiao, "value" ]), digits = 10, big.mark = "."), 
      "Infectados", 
      color = "blue"
    )
  })

  output$value_observations_est <- renderValueBox(
    {
      valueBox(
        format(sum(df[df$location == input$sel_periodo_estado, "value" ]), digits = 10, big.mark = "."), 
        "Infectados no Estado", 
        color = "blue"
      )
    })
  
    output$value_observations_data <- renderValueBox(
    {
      valueBox(
        format(sum(df[df$report_date == input$sel_periodo_data, "value" ]), digits = 10, big.mark = "."), 
        "Infectados na Data", 
        color = "blue"
      )
    })
}



  
