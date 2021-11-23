library(readr)

function(input, output) {

  datos <- read_csv('Advertising.csv')
  
  output$main_plot <- renderPlot({	
	modelo <- lm(Sales ~ poly(TV, degree = as.numeric(input$poly_degree), raw = T), data = datos)
	
    plot(datos$TV, datos$Sales, pch = as.numeric(input$t_point))
	
	if (input$model_check){
		aux <- sort(datos$TV, index.return = T)
		x <- aux$x
		pred <- predict(modelo)
		pred <- pred[aux$ix]
		
		points(x, pred, type='l', col='red')
	}
	
  })
}
