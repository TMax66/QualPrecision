
shinyUI(fluidPage(

    titlePanel("Metodi qualitativi: Ripetibilità e Riproducibilità"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("mp", "Metodo di Prova", 
                        c( unique(as.character(dati$mp))))
            ),

        mainPanel(
            tableOutput("t"),
            br(),hr(),
            
           tableOutput("tt")
        )
    )
))
