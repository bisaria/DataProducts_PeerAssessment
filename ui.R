library(shiny)

shinyUI(fluidPage(
  titlePanel("10-Year Heart Attack Risk Assessment"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Personal Info"),
      
      sliderInput("age", 
                  label = "Age:",
                  min = 20, max = 100, value = 30),
      
      selectInput("gender", 
                  label = "Gender",
                  choices = list("Male", "Female"),
                  selected = "Male"),
      
      numericInput("tchl", 
                   label = "Total Cholestrol, mg/dL", 
                   value = 200),     
      
      numericInput("sysbp", 
                   label = "Systolic Blood Pressure", 
                   value = 120),
      
      radioButtons("smoker", label = "Smoker",
                   choices = list("Yes" = 1, "No" = 2),selected = 2),
      
      radioButtons("bpmed", label = "BP medication",
                   choices = list("Yes" = 1, "No" = 2),selected = 2)
      
    ),
    
    mainPanel(
      helpText("Predicting 10-year risk of heark attack using the data from Framingham Heart Study: "),
      helpText("Age"),
      textOutput("text1"),
      helpText("Gender"),
      textOutput("text2"),
      helpText("Total Cholestrol"),
      textOutput("text3"),
      helpText("Systolic Blood Pressure"),
      textOutput("text4"),      
      helpText("Smoker"),
      textOutput("text5"),
      helpText("BP Medication"),
      textOutput("text6"),
      helpText(h3("Your Prediction:")),
      textOutput("text7"),
      textOutput("text8"),
      tags$head(tags$style(
                           "#text7{color: red;
                                 font-size: 20px;
                                 font-style: italic;
                                 }",
                           "#text8{color: blue;}"
                          )
                )
      )
  )
  
))
