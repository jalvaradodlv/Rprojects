library(readr)

function(input, output) {

  datos <- read_csv('Advertising.csv')
  modelo <- lm(Sales ~ TV, data = datos)
  

  output$main_plot <- renderPlot({
		
    plot(datos$TV, datos$Sales, pch = as.numeric(input$t_point))
	
	if (input$model_check){
		abline(coef(modelo), col='red')
	}
	
  })
}
