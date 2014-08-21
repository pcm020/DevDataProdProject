library(shiny)
shinyUI(pageWithSidebar(
    headerPanel("NUMBER OF TOURIST BUSINESS IN CASTILLA LEON"),
    
    sidebarPanel(
        #checkboxGroupInput("category","Category",unique(datMelt$CATEGORY)),
        checkboxGroupInput("provinces","Provinces",c("AVILA", "BURGOS", "LEON",         
              "PALENCIA", "SALAMANCA", "SEGOVIA", "SORIA", "VALLADOLID", "ZAMORA")),
        selectInput("category","Category",c("TRAVEL AGENCIES", "RURAL TOURISM",
             "HOTELS", "TOURIST APARTMENTS", "CAFE", "TOURIST CAMPS", "OTHERS",
             "RESTAURANT", "ACTIVE TOURISM")),
        selectInput("month", "Month", unique(datMelt$MONTH), multiple = TRUE),
        submitButton(text="Ready")),
    
    mainPanel(
        tabsetPanel(
            tabPanel("Info",h3("Info"),
                     p("This shiny App is for 'Coursera Developing Data Products' course."),
                     hr(),
                     p(HTML("The data has been download from <a href=\"http://www.datosabiertos.jcyl.es/\">Opendata Castilla y Leon Goverment</a>.")),
                     p(HTML("Download and info in <a href=\"http://www.datosabiertos.jcyl.es/web/jcyl/set/es/estadisticas/establecim_turisticos/1284176015799\">link</a>")),
                     p("The app try to show the number of tourist business since 2001, how growing and reduce with the crisis"),
                     p("- Select a type of business in Category and Month."),
                     p("- Select a Map tab.")),
            tabPanel("Map",h4("Tourist numbers"),htmlOutput("map"))
        )
    )
))
