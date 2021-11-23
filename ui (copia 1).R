fluidPage(

  sliderInput(inputId = "t_point",
      label = "Tamaño de muestra",
      min = 1,
      max = 200,
      value = 5),
      
  plotOutput(outputId = "main_plot", height = "300px")
  
)
