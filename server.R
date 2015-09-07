library(shiny)

# Read in the dataset
framingham = read.csv("data/framingham.csv")

# Pre-process the dataset for logical regression
var = c("male","age","currentSmoker","BPMeds","totChol","sysBP", "TenYearCHD")
framingham = framingham[, names(framingham)%in%var]
framingham$male = as.factor(framingham$male)
levels(framingham$male) = c("Female","Male")
framingham$currentSmoker = as.factor(framingham$currentSmoker)
levels(framingham$currentSmoker) = c(2,1)
framingham$BPMeds = as.factor(framingham$BPMeds)
levels(framingham$BPMeds) = c(2,1)

# Perform logical regression on the pre-processed dataset
framinghamLog = glm(TenYearCHD ~ ., data = framingham, family=binomial)

shinyServer(function(input, output) {
  
  output$text1 <- renderText({ 
    paste("You have selected", input$age[1])    
  })
  
  output$text2 <- renderText({ 
    paste("You have selected", input$gender)
  })
  
  output$text3 <- renderText({ 
    paste("You have entered", input$tchl,". Less than 200 mg/dL is considered 'Desirable' level.  Higher the total cholestrol level higher is the risk of heart attack.")
  })
  
  output$text4 <- renderText({ 
    paste("You have entered", input$sysbp,". Systolic BP is the first number of a BP reading. For eaxmple, if reading is 120/80, systolic BP is 120.")
  })
  
  output$text5 <- renderText({ 
    
    if(input$smoker == 2)
      "You have selected No."
    else
      "You have selected Yes."
  
  })
  
  output$text6 <- renderText({ 
    if(input$bpmed == 2)
      "You have selected No."
    else
      "You have selected Yes."
    
  })
  
  test <- reactive({          
    round(predict(framinghamLog, type="response", 
                          newdata=data.frame("male" = input$gender,"age" = input$age[1], 
                                                  "currentSmoker" = input$smoker, 
                                                   "BPMeds" = input$bpmed,"totChol" = input$tchl, 
                                                  "sysBP" = input$sysbp))*100)
  }) 
  
  
  output$text7 <- renderText({   
    if( test() > 50)
      paste("You better be careful, buddy!")
    else
      NULL
    
  }) 
  output$text8 <- renderText({   
    if( test() > 50)
      NULL
    else
      paste("You have nothing to worry for now!")
    
  }) 
})
