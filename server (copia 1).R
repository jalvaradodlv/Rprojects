library(readr)

function(input, output) {
  
  output$main_plot <- renderPlot({	
	  x <- rexp(as.numeric(input$t_point)*100)
	  x <- matrix(x, ncol = 100, nrow = as.numeric(input$t_point), byrow=F)
	  
	  x <- colMeans(x)
	  
	  hist(x)
  })
}
