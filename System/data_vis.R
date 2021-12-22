library(ggplot2)
library(shiny)
library(shinycssloaders)
library(shinythemes)
library(dplyr)
library(lubridate)
# css <- HTML(" body {
#     background-color: #e7f5e4;
#     
# }")
#tags$head(tags$style(css))
avo = read.csv("avocado.csv")
avo = data.frame(avo)
ui <- fluidPage(
  navbarPage("Avocado Predict",theme = shinytheme("paper"),
             tabPanel("Historical Price/Consumption Chart", fluid=TRUE,
                      titlePanel("Historical Price/Consumption Chart"),
                      sidebarLayout(
                        sidebarPanel(
                          checkboxGroupInput(inputId = "avoTypeII",
                                             label = "Select Avocado Type:",
                                             choices = c("conventional", "organic"),
                                             selected = "conventional"),
                          radioButtons(inputId = "yearII",
                                       label = "Select Year:",
                                       choices = c("2015", "2016","2017","2018"),
                                       selected = "2015"),
                          radioButtons(inputId = "priceVolumnII",
                                       label = "Select Price Or Consumption",
                                       choices = c("Price","Consumption"),
                                       selected = "Price"),
                          selectInput(inputId = "regionII",
                                      label = "Select Region:",
                                      choices = c("Albany","Atlanta","BaltimoreWashington","Boise","Boston","BuffaloRochester","California","Charlotte","Chicago","CincinnatiDayton",
                                                  "Columbus","DallasFtWorth","Denver","Detroit","GrandRapids","GreatLakes","HarrisburgScranton",
                                                  "HartfordSpringfield","Houston","Indianapolis","Jacksonville",
                                                  "LasVegas","LosAngeles","Louisville","MiamiFtLauderdale","Midsouth",
                                                  "Nashville","NewOrleans","NewYork","Northeast","NorthernNewEngland",
                                                  "Orlando","Philadelphia","PhoenixTucson","Pittsburgh","Plains","Portland","RaleighGreensboro",
                                                  "RichmondNorfolk","Roanoke","Sacramento","SanDiego","SanFrancisco","Seattle",
                                                  "SouthCarolina","SouthCentral","Southeast","Spokane","StLouis",
                                                  "Syracuse","Tampa","TotalUS"),
                                      selected = "Albany"),
                        ),
                        mainPanel(
                          withSpinner(plotOutput(outputId = "linechart")),
                          textOutput(outputId = "linechart_text")
                          
                        )
                      )
                      
             ),
             tabPanel("Regional Price/Consumption Stats", fluid=TRUE,
                      titlePanel("Regional Price/Consumption Stats"),
                      sidebarLayout(
                        sidebarPanel(
                          checkboxGroupInput(inputId = "avoTypeIII",
                                             label = "Select Avocado Type:",
                                             choices = c("conventional", "organic"),
                                             selected = "conventional"),
                          radioButtons(inputId = "yearIII",
                                       label = "Select Year:",
                                       choices = c("2015", "2016","2017","2018"),
                                       selected = "2015"),
                          radioButtons(inputId = "priceVolumnIII",
                                       label = "Select Price Or Consumption",
                                       choices = c("Price","Consumption"),
                                       selected = "Price"),
                        ),
                        mainPanel(
                          withSpinner(plotOutput(outputId = "barchart")),
                          textOutput(outputId = "barchart_text")
                          
                        )
                      )
                      
             ),
             #type bar chart
             tabPanel("Type VS Price (Annually)", fluid=TRUE,
                      titlePanel("Type VS Price"),
                      sidebarLayout(
                        sidebarPanel(
                          selectInput(inputId = "regionIV",
                                      label = "Select Region:",
                                      choices = c("Albany","Atlanta","BaltimoreWashington","Boise","Boston","BuffaloRochester","California","Charlotte","Chicago","CincinnatiDayton",
                                                  "Columbus","DallasFtWorth","Denver","Detroit","GrandRapids","GreatLakes","HarrisburgScranton",
                                                  "HartfordSpringfield","Houston","Indianapolis","Jacksonville",
                                                  "LasVegas","LosAngeles","Louisville","MiamiFtLauderdale","Midsouth",
                                                  "Nashville","NewOrleans","NewYork","Northeast","NorthernNewEngland",
                                                  "Orlando","Philadelphia","PhoenixTucson","Pittsburgh","Plains","Portland","RaleighGreensboro",
                                                  "RichmondNorfolk","Roanoke","Sacramento","SanDiego","SanFrancisco","Seattle",
                                                  "SouthCarolina","SouthCentral","Southeast","Spokane","StLouis",
                                                  "Syracuse","Tampa","TotalUS"),
                                      selected = "Albany"),
                          radioButtons(inputId = "yearIV",
                                       label = "Select Year:",
                                       choices = c("2015", "2016","2017","2018"),
                                       selected = "2015"),
                        ),
                        mainPanel(
                          # withSpinner(plotOutput(outputId = "barchart_type_con")),
                          withSpinner(plotOutput(outputId = "barchart_type_organ"))
                        )
                      )
                      
             ),
             #pie chart
             tabPanel("Size of Avocado VS Total Sales", fluid=TRUE,
                      titlePanel("Size of Avocado VS Total Sales"),
                      sidebarLayout(
                        sidebarPanel(
                          selectInput(inputId = "regionV",
                                      label = "Select Region:",
                                      choices = c("Albany","Atlanta","BaltimoreWashington","Boise","Boston","BuffaloRochester","California","Charlotte","Chicago","CincinnatiDayton",
                                                  "Columbus","DallasFtWorth","Denver","Detroit","GrandRapids","GreatLakes","HarrisburgScranton",
                                                  "HartfordSpringfield","Houston","Indianapolis","Jacksonville",
                                                  "LasVegas","LosAngeles","Louisville","MiamiFtLauderdale","Midsouth",
                                                  "Nashville","NewOrleans","NewYork","Northeast","NorthernNewEngland",
                                                  "Orlando","Philadelphia","PhoenixTucson","Pittsburgh","Plains","Portland","RaleighGreensboro",
                                                  "RichmondNorfolk","Roanoke","Sacramento","SanDiego","SanFrancisco","Seattle",
                                                  "SouthCarolina","SouthCentral","Southeast","Spokane","StLouis",
                                                  "Syracuse","Tampa","TotalUS"),
                                      selected = "Albany"),
                          checkboxGroupInput(inputId = "yearV",
                                             label = "Select Year:",
                                             choices = c("2015", "2016","2017","2018"),
                                             selected = "2015"),
                          checkboxGroupInput(inputId = "avoTypeV",
                                             label = "Select Avocado Type:",
                                             choices = c("conventional", "organic"),
                                             selected = "conventional"),
                        ),
                        mainPanel(
                          withSpinner(plotOutput(outputId = "piechart"))
                        )
                      )
                      
             ),
             #third page
             # tabPanel("About",fluid = TRUE,icon=icon("info-circle"),
             #   fluidRow(
             #     column(4,
             #            h4("Data Features"),
             #            h6("Date: The date of the observation"),
             #            h6("AveragePrice: The average price of a single avocado"),
             #            h6("Type: Conventional or organic"),
             #            h6("Year: The year (2015 to 2018)"),
             #            h6("Region: The city or region of the observation"),
             #            h6("Total Volume: Total number of avocados sold"),
             #            h6("4046: Total number of avocados with PLU 4046 sold"),
             #            h6("4225: Total number of avocados with PLU 4225 sold"),
             #            h6("4770: Total number of avocados with PLU 4770 sold")
             #     ),
             #     column(4,
             #            h4("Business Values"),
             #            h6("Bridge the gap among previous works, where we can build a system that allows users:"),
             #            h6("1) Estimate the price and consumption level of avocado"),
             #            h6("- help sellers in the process of demand planning"),
             #            h6("- estimate the sales revenue"),
             #            h6("2) A visual data report analyzing the consumer purchasing behavior in the U.S."),
             #            h6("- present marketing insights of consumer buying behavior, ex: the most sought-after type of avocado and how preferences vary by region across the U.S.")
             #    ),
             #     column(4,
             #            h4("Group Members"),
             #            h6("Yiran Lin (yl4628)"),
             #            h6("Yunze Qiu (yq2310)"),
             #            h6("Stacy Lai (sl4450)")
             #     ),
             #    # br(),
             #    # h5("Data Source:"),
             #    # h6(
             #    #   p("Avocado data from Kaggle https://www.kaggle.com/neuromusic/avocado-prices")
             #    # ),
             #    #      
             #   )
             # )
             )
)

server <- function(input,output){
  #historical chart
  hist_chart <- reactive({
   req(input$avoTypeII)
   req(input$yearII)
   req(input$priceVolumnII)
   req(input$regionII)
   #res<- avo %>% arrange(-row_number())
   res <- filter(avo,avo$year==input$yearII)
   res <- filter(res,res$type == input$avoTypeII)
   if(input$priceVolumnII == "Price"){
     res <- rename(res,target=AveragePrice)
   }else{
     res <- rename(res,target=Total.Volume)
   }
   res <- filter(res,res$region == input$regionII)
   new_temp<- res %>% arrange(-row_number())
   new_temp$Date<-factor(new_temp$Date,levels = new_temp$Date)
   return(new_temp)
  })
  
  output$linechart <- renderPlot({
    ggplot(hist_chart(),aes(x=Date,y=target))+ geom_line(group=1) + geom_point()+xlab(paste("Date in year",as.character(input$yearII)))+ylab(as.character(input$priceVolumnII))+theme(axis.text.x = element_text(angle = 45, hjust = 1))
      
  })
  
  #bar chart
  bar_chart <- reactive({
     req(input$avoTypeIII)
     req(input$yearIII)
     req(input$priceVolumnIII)
     resIII <- filter(avo,avo$year==input$yearIII)
     resIII <- filter(resIII,resIII$type == input$avoTypeIII)
     if(input$priceVolumnIII == "Price"){
        resIII <- rename(resIII,targetIII=AveragePrice)
        tempIII<-resIII %>% group_by(region) %>% summarise(summaryIII = mean(targetIII))
     }else{
        resIII <- filter(resIII,resIII$region != "TotalUS")
        resIII <- rename(resIII,targetIII=Total.Volume)
        tempIII<-resIII %>% group_by(region) %>% summarise(summaryIII = mean(targetIII))
     }
     return(tempIII)
  })
  output$barchart <- renderPlot({
     ggplot(bar_chart(),aes(x=region,y=summaryIII))+geom_bar(position = 'dodge',stat="identity")+xlab("Region")+ylab(as.character(input$priceVolumnIII))+theme(axis.text.x = element_text(angle = 45, hjust = 1))+
      geom_text(aes(label=sprintf("%0.2f", round(summaryIII, digits = 2))), position=position_dodge(width=0.9), vjust=-0.25,size=2)
  })
  
  #bar chart type con
  bar_chart_type_con <- reactive({
    req(input$regionIV)
    req(input$yearIV)
    resIV <- filter(avo,avo$region==input$regionIV)
    resIV <- filter(resIV,year == input$yearIV)
    #conventional
    res_con <-filter(resIV, type=="conventional")
    new_temp_IV_con<- res_con %>% arrange(-row_number())
    new_temp_IV_con$Date<-factor(new_temp_IV_con$Date,levels = new_temp_IV_con$Date)
    #organic
    # res_organ <-filter(resIV, type=="organic")
    # new_temp_IV_organ<- res_organ %>% arrange(-row_number())
    # new_temp_IV_organ$Date<-factor(new_temp_IV_organ$Date,levels = new_temp_IV_organ$Date)
    # return(c(new_temp_IV_con,new_temp_IV_organ))
    return(new_temp_IV_con)
  })
  # output$barchart_type_con <-renderPlot({
  #   ggplot(bar_chart_type_con(),aes(x=Date,y=AveragePrice))+ geom_line(group=1) + geom_point()+xlab("Date")+ylab(paste("Price in",as.character(input$regionIV),"in year of",as.character(input$yearIV)))+theme(axis.text.x = element_text(angle = 45, hjust = 1))+ggtitle("Conventional Avacado Price Trend")
  # })
  
  #bar chart type organ
  bar_chart_type_organ <- reactive({
    req(input$regionIV)
    req(input$yearIV)
    resIV <- filter(avo,avo$region==input$regionIV)
    resIV <- filter(resIV,year == input$yearIV)
    #organic
    res_organ <-filter(resIV, type=="organic")
    new_temp_IV_organ<- res_organ %>% arrange(-row_number())
    new_temp_IV_organ$Date<-factor(new_temp_IV_organ$Date,levels = new_temp_IV_organ$Date)
    return(new_temp_IV_organ)
  })
  # output$barchart_type_organ <-renderPlot({
  #   ggplot(bar_chart_type_organ(),aes(x=Date,y=AveragePrice))+ geom_line(group=1) + geom_point()+xlab("Date")+ylab(paste("Price in",as.character(input$regionIV),"in year of",as.character(input$yearIV)))+theme(axis.text.x = element_text(angle = 45, hjust = 1))+ggtitle("Organic Avacado Price Trend")
  # })
  output$barchart_type_organ <-renderPlot({
    ggplot()+
      geom_line(bar_chart_type_con(),mapping=aes(x=Date,y=AveragePrice,color="Conventional"),group=1)+geom_point(data=bar_chart_type_con(),aes(x=Date,y=AveragePrice))+
      geom_line(bar_chart_type_organ(),mapping=aes(x=Date,y=AveragePrice,color="Organic"),group=1)+geom_point(data=bar_chart_type_organ(),aes(x=Date,y=AveragePrice))+xlab("Date")+ylab(paste("Price in",as.character(input$regionIV),"in year of",as.character(input$yearIV)))+theme(axis.text.x = element_text(angle = 45, hjust = 1))+ggtitle("Conventional VS Organic")+
      scale_color_manual(name = "Legend", values = c("Conventional" = "#9bd497", "Organic" = "#97CAEF"))
  })
  # output$barchart_type_con <-renderPlot({
  #   ggplot()+
  #     geom_line(bar_chart_type_con(),mapping=aes(x=Date,y=Total.Volume,color="Conventional"),group=1)+geom_point(data=bar_chart_type_con(),aes(x=Date,y=Total.Volume))+
  #     geom_line(bar_chart_type_organ(),mapping=aes(x=Date,y=Total.Volume,color="Organic"),group=1)+geom_point(data=bar_chart_type_organ(),aes(x=Date,y=Total.Volume))+xlab("Date")+ylab(paste("Price in",as.character(input$regionIV),"in year of",as.character(input$yearIV)))+theme(axis.text.x = element_text(angle = 45, hjust = 1))+ggtitle("Conventional VS Organic")+
  #     scale_color_manual(name = "Legend", values = c("Conventional" = "#9bd497", "Organic" = "#97CAEF"))
  # })
  
  
  #pie chart
  pie_chart <- reactive({
    req(input$regionV)
    req(input$yearV)
    req(input$avoTypeV)
    resV <- filter(avo,avo$region==input$regionV)
    resV <- filter(resV,year == input$yearV)
    resV <- filter(resV,type == input$avoTypeV)
    temp <- data.frame(value=c(sum(resV$X4046),sum(resV$X4225),sum(resV$X4770)),group=c("4046","4225","4770"))
    # resV$summaryV_I = sum(resV$X4046)
    # resV$summaryV_II = sum(resV$X4225)
    # resV$summaryV_III = sum(resV$X4770)
    return(temp)
  })
  output$piechart <-renderPlot({
    ggplot(pie_chart(), aes(x="", y=value, fill=group)) +
      geom_bar(stat="identity", width=1) +
      coord_polar("y", start=0)+
      scale_fill_manual(values = c("4046" = "#FBEEC1", "4225" = "#9bd497", "4770" = "#97CAEF", "Regional University" = "#20FF1E"), aesthetics = "fill")+
      theme_void()
  })
}

shinyApp(ui,server)

