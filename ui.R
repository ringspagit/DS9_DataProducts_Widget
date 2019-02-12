# US National Parks - Visitation Data Widget
# DS Module 9 / Developing Data Products - Project Wk4
# Paul Ringsted 11th February 2019
# ui.R - UI part

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

        # Application title
        titlePanel("US National Park Visitor Statistics 2008-2017"),

        sidebarLayout(
                
                # Sidebar with a inputs for park and spline fit
                sidebarPanel(
                        selectInput("ParkName","Park:",parklist),
                        checkboxInput("Use_sp", "Use Spline", value = TRUE),
                        sliderInput("Year_sp","Break Spline at Year:",
                                min_year+1,max_year-1,value=2013,
                                round=T,step=1,ticks=F,sep=""),
                        h5("Info:"),
                        h5("Select the park of interest from the drop-down, or use 'All NP' for all available parks"),
                        h5("Adjust regression fit to remove or shift the spline as needed"),
                        h5(paste0("Data: Recreational visits from the NPS Integrated Resource Management Applications (IRMA) ",
                                "website, filtered on park names ending 'NP'"))
                ),
        
                # Show a plot of the generated distribution
                mainPanel(
                        plotOutput("parkPlot")
                )
        )
))
