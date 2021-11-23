fluidPage(

  sliderInput(inputId = "t_point",
      label = "Tipo de punto",
      min = 1,
      max = 20,
      value = 5),

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
