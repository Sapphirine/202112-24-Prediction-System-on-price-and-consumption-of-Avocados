server <- function(input, output, session) {
############################### Q1 Chart ----
  ##########_render graph for PRICE
  data1 <- eventReactive(input$search1,{
    if(is.null(input$month_pred1)){
      return()
    }
    #initiate
    p1 <-filter(pred, region == input$region_pred1, type == input$type_pred1, 
                month == as.numeric(input$month_pred1) - as.numeric(1) | 
                  month == as.numeric(input$month_pred1) | 
                  month == as.numeric(input$month_pred1) + as.numeric(1)
    )    
    x = as.character(input$month_pred1)
    #Price trend by state and type: Albany & conventional
    ggplot(p1, aes(x=month, y=AveragePrice, fill = ifelse(month == x, "Highlighted", "Normal"))) +
      geom_bar(stat="identity") +
      labs(y= "Average Price", x = "Month") +
      theme(legend.position = "none") +
      geom_text(aes(label = round(AveragePrice, digits=2)), size = 5, position = position_stack(vjust = 1.05))+
      ggtitle(paste0("Average Price trend of ", input$type_pred1, " type of avocado", " in ", input$region_pred1))
    
  }) #end of data1  
  
  output$Price_pred1 <- renderPlot({
    data1()
  })
  ############################### Q3 Chart ----  
  ##########_render graph for consumption
    data3 <- eventReactive(input$search3,{
      if(is.null(input$month_pred3)){
        return()
      }
      #initiate
      p3 <-filter(pred, region == input$region_pred3, type == input$type_pred3, 
                  month == as.numeric(input$month_pred3) - as.numeric(1) | 
                    month == as.numeric(input$month_pred3) | 
                    month == as.numeric(input$month_pred3) + as.numeric(1)
                  )
      z = as.character(input$month_pred3)
      #graph
      ggplot(p3, aes(x=month, y=Total.Volume, fill = ifelse(month == z, "Highlighted", "Normal"))) +
        geom_bar(stat="identity") +
        labs(y= "Consumption", x = "Month") +
        theme(legend.position = "none") +
        geom_text(aes(label = round(Total.Volume)), size = 5, position = position_stack(vjust = 1.05))+
        ggtitle(paste0("Consumption trend of ", input$type_pred3, " type of avocado", " in ", input$region_pred3))
      
    }) #end of data3  
    
    output$Consumption_pred3 <- renderPlot({
      data3()
    })

     
############################### Q2 Chart ----
      ##########_render graph for revenue
      data2 <- eventReactive(input$search2,{
        if(is.null(input$month_pred2)){
          return()
          }
        #initiate
        p2 <-filter(pred, region == input$region_pred2, type == input$type_pred2, 
                    month == as.numeric(input$month_pred2) - as.numeric(1) | 
                      month == as.numeric(input$month_pred2) | 
                      month == as.numeric(input$month_pred2) + as.numeric(1)
                    )
        my=as.character(input$month_pred2)
        #Price trend by state and type: Albany & conventional
        ggplot(p2, aes(x=month, y=AveragePrice*Total.Volume, , fill = ifelse(month == my, "Highlighted", "Normal"))) +
          geom_bar(stat="identity") +
          labs(y= "Revenue", x = "Month") +
          theme(legend.position = "none") +
          geom_text(aes(label = round(AveragePrice*Total.Volume)), size = 5, position = position_stack(vjust = 1.05))+
          ggtitle(paste0("Revenue trend of ", input$type_pred2, " type of avocado", " in ", input$region_pred2))
        
      }) #end of data2  
      
      output$Revenue_pred2 <- renderPlot({
        data2()
      }) 


}
