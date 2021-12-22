### GROUP PROJECT ----

ui <- tagList(
  
  useShinyjs(),
  
  setBackgroundImage(src = 'avocado.jpeg'),
  
  navbarPage(
    
    id = 'navBar',
    title = 'Team 24: Avocado Prediction System',
    windowTitle = '',
    position = 'fixed-top',
    collapsible = TRUE,
    inverse = TRUE,
    theme = shinytheme('flatly'),
    
    # Home ----
    
    # tabPanel(
    #   title = div(
    #     img(src = 'home.png', height = 35)
    #   ),
    #   tags$head(
    #     tags$style(
    #       type = 'text/css', 
    #       'body {padding-top: 70px;}' 
    #     )
    #   )
    # ),
    # GRAGH 3: Consumption trend by state and type: Albany & conventional----
    tabPanel(
      
      title = 'Consumption',
      div(
        class = 'outer',
        tags$head(includeCSS('styles.CSS'), tags$style(
                type = 'text/css',
                'body {padding-top: 70px;}'
              ))
      ),
      fluidPage(
        headerPanel(h3("Select Month, State, and Type of Avocado", align = "left")),
        
        # Generate a row with a sidebar
        sidebarLayout(
          
          # Define the sidebar with one input
          sidebarPanel(
            radioButtons("type_pred3", "Type of Avocado",
                         choices = c("conventional", "organic")
            ),
            selectInput("region_pred3", "Regions:",
                        choices = regions_global
            ),
            selectInput("month_pred3", "Months:",
                        choices = month_global
            ),
            actionButton("search3", "Search")
            
          ), #end user selection
          #hr(),
          
          # Create a spot for the barplot
          mainPanel(
            splitLayout(
              plotOutput("Consumption_pred3")
            )
          )
          
        ) #end side bar layout
        
      ) #end fluid page
    ), #end tab panel
    
    # GRAGH 1: Price trend by state and type: Albany & conventional----
    tabPanel(
       
       title = 'Price',
      div(
        class = 'outer',
        tags$head(includeCSS('styles.CSS'))
      ),
      fluidPage(
        headerPanel(h3("Select Month, State, and Type of Avocado", align = "left")),

        # Generate a row with a sidebar
        sidebarLayout(

          # Define the sidebar with one input
          sidebarPanel(
            radioButtons("type_pred1", "Type of Avocado",
                         choices = c("conventional", "organic")
                         ),
            selectInput("region_pred1", "Regions:",
                        choices = regions_global
                        ),
            selectInput("month_pred1", "Months:",
                        choices = month_global
                        ),
            actionButton("search1", "Search")
            
          ), #end user selection
          #hr(),
          
          # Create a spot for the barplot
          mainPanel(
            splitLayout(
              plotOutput("Price_pred1")
            )
          )
          
        ) #end side bar layout

      ) #end fluid page
    ), #end tab panel
    
    # GRAGH 3: Revenue(Price x consumption) trend by state and type: Albany & conventional----
    tabPanel(
      
      title = 'Revenue',
      div(
        class = 'outer',
        tags$head(includeCSS('styles.CSS'))
      ),
      fluidPage(
        headerPanel(h3("Select Month, State, and Type of Avocado", align = "left")),
        
        # Generate a row with a sidebar
        sidebarLayout(
          # Define the sidebar with one input
          sidebarPanel(
            radioButtons("type_pred2", "Type of Avocado",
                         choices = c("conventional", "organic")
                         ),
            selectInput("region_pred2", "Regions:",
                        choices = regions_global
                        ),
            selectInput("month_pred2", "Months:",
                        choices = month_global
                        ),
            actionButton("search2", "Search")
          ), #end user selection
          #hr(),
          # Create a spot for the barplot
          mainPanel(
            splitLayout(
              plotOutput("Revenue_pred2")
            )
          )
        ) #end side bar layout
        
      ) #end fluid page
    ) #end tab panel
    

  )
)