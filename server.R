# US National Parks - Visitation Data Widget
# DS Module 9 / Developing Data Products - Project Wk4
# Paul Ringsted 11th February 2019
# server.R - server part

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
        
        output$parkPlot <- renderPlot({
    
                # Subset based on input
                dfsub<-df_parks[which(df_parks$ParkName == input$ParkName),]

                # Plot the subset
                plot(dfsub$Year,dfsub$Visits,
                     xlab="Year",ylab="Visits (Millions)",
                     main=paste0("Annual Visits to ",input$ParkName))
                lines(dfsub$Year,dfsub$Visits)

                # Add a regression line
                
                if (input$Use_sp) {
                        
                        # Fit a spline model based on input value to break at                
                        dfsub$Year_sp <- ifelse(dfsub$Year - input$Year_sp > 0, dfsub$Year - input$Year_sp, 0)
                        fit <- lm(Visits ~ Year_sp + Year,dfsub)
                        
                        # Generate Y values to draw the spline fit
                        year_range <- min_year:max_year        
                        model_lines <- predict(fit, newdata = data.frame(
                                Year = year_range, 
                                Year_sp = ifelse(year_range - input$Year_sp > 0, year_range - input$Year_sp, 0)
                        ))
                        
                        lines(year_range, model_lines, col = "blue", lwd = 3)
                } else {
                        # Regular linear regression
                        fit <- lm(Visits ~ Year,dfsub)
                        abline(fit,col = "red", lwd = 3)
                }
        })
})