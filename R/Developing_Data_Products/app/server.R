library(shiny)


randnum=sample(0:9, 4, replace=F)
output_value<<-rep('X',4)
x<<-c('Start:')
shinyServer(
  function(input, output) {
    output$inputValue <- renderPrint({x<<-append(x,input$inputValues);x})
    output$prediction <- renderPrint({
      input_value=as.numeric(input$inputValues);
      if (input_value %in% randnum)
      {
        output_value[randnum==input_value]<<-input_value;
      };
      if (! sum(output_value=='X') ) {output_value<<-paste('Bingo!!! The value is: ',paste(randnum,collapse=""),sep='')};
      output_value})
  }
  
)