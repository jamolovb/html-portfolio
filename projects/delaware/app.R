library(shiny)
districts <- read.csv("districts.csv")
ui <- fluidPage(
  titlePanel("Delaware school water sampling"),
  p("Explore recorded sample counts and maximum lead results in the 2023 school sampling data."),
  selectInput("district", "District or reporting group", districts$district, selected = "Colonial"),
  textOutput("summary"),
  h3("Maximum recorded result by district"),
  plotOutput("comparison", height = "560px")
)
server <- function(input, output, session) {
  output$summary <- renderText({
    row <- districts[districts$district == req(input$district), ]
    sprintf("%s: %s samples. Maximum measured result: %s ppb.", row$district,
      format(row$samples, big.mark = ","), format(row$max_ppb, big.mark = ","))
  })
  output$comparison <- renderPlot({
    rows <- districts[order(districts$max_ppb), ]
    par(mar = c(4, 10, 1, 1))
    barplot(rows$max_ppb, names.arg = rows$district, horiz = TRUE, las = 1,
      cex.names = .8, col = ifelse(rows$district == req(input$district), "#b66816", "#276468"),
      border = NA, xlab = "Maximum measured lead (ppb)")
  })
}
shinyApp(ui, server)
