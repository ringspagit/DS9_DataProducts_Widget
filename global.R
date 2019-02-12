# US National Parks - Visitation Data Widget
# DS Module 9 / Developing Data Products - Project Wk4
# Paul Ringsted 11th February 2019
# Global.R - data load part

# Load data fileand select subset of columns
parks<-read.csv('parks.csv',stringsAsFactors = FALSE,skip=3)
df <- parks[which(grepl("NP$",parks[,1]) & !is.na(parks[,2])),1:3]
colnames(df)<-c("ParkName","Year","Visits")
df$Visits<-as.numeric(gsub(",", "", df$Visits))         # Remove thousands separator

# Build aggregate totals and glue it to the dataframe
tots<-aggregate(df$Visits,by=list(df$Year),FUN=sum)
tots_name<-rep("All NP",nrow(tots))
tots_df<-cbind(tots_name,tots)
colnames(tots_df)<-colnames(df)
tots_df$ParkName<-as.character(tots_df$ParkName)
df_parks<-rbind(tots_df,df)

# Convert to millions for nicer graph
df_parks$Visits <- df_parks$Visits/1000000

# Build unique list of parks to drive the UI dropdown
parklist<-unique(df_parks$ParkName)
min_year<-min(df_parks$Year)
max_year<-max(df_parks$Year)