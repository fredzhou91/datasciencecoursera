library(shiny)
shinyUI(pageWithSidebar(
  headerPanel('Developing Data Products - Course Project'),
  sidebarPanel(
    h3('Instructions'),
    p('Guess the exact number for the 4-digit number'),
    h3('Please enter your guess.'),
    numericInput('inputValues', 'Guessed Number:', 6, min = 0, max = 9, step = 1),
    submitButton('Guess!!!')
    ),
  
  mainPanel(
    h6('Course Project by Fred Zhou'),
    h3('Predicted Number'),
    h4('You entered:'),
    verbatimTextOutput("inputValue"),
    h4('Which resulted in a prediction of:'),
    verbatimTextOutput("prediction"),

    h3('Intro'),
    p('Just a funny app for testing your luck')
    )
  ))