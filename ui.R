fluidPage(

  sliderInput(inputId = "t_point",
      label = "Tipo de punto",
      min = 1,
      max = 20,
      value = 5),
  
  selectInput(inputId = "poly_degree",
  label = "Selecciona el grado del polinomio",
  choices = c(1,2,3,4),
  selected = 1),

  checkboxInput(inputId = "model_check",
      label = strong("Mostrar modelo"),
      value = FALSE),

  plotOutput(outputId = "main_plot", height = "300px"),

  # Display this only if the density is shown
  conditionalPanel(condition = "input.density == true",
    sliderInput(inputId = "bw_adjust",
        label = "Bandwidth adjustment:",
        min = 0.2, max = 2, value = 1, step = 0.2)
  )

)
