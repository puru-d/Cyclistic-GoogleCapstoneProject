library(tidyverse)
library(lubridate)
apr_2020 <- read_csv("/Users/purudewan/Cyclistic_R/data/202004-divvy-tripdata.csv")
may_2020 <- read_csv("/Users/purudewan/Cyclistic_R/data/202005-divvy-tripdata.csv")
jun_2020 <- read_csv("/Users/purudewan/Cyclistic_R/data/202006-divvy-tripdata.csv")
jul_2020 <- read_csv("/Users/purudewan/Cyclistic_R/data/202007-divvy-tripdata.csv")
aug_2020 <- read_csv("/Users/purudewan/Cyclistic_R/data/202008-divvy-tripdata.csv")
sep_2020 <- read_csv("/Users/purudewan/Cyclistic_R/data/202009-divvy-tripdata.csv")
oct_2020 <- read_csv("/Users/purudewan/Cyclistic_R/data/202010-divvy-tripdata.csv")
nov_2020 <- read_csv("/Users/purudewan/Cyclistic_R/data/202011-divvy-tripdata.csv")
dec_2020 <- read_csv("/Users/purudewan/Cyclistic_R/data/202012-divvy-tripdata.csv")
jan_2021 <- read_csv("/Users/purudewan/Cyclistic_R/data/202101-divvy-tripdata.csv")
feb_2021 <- read_csv("/Users/purudewan/Cyclistic_R/data/202102-divvy-tripdata.csv")
mar_2021 <- read_csv("/Users/purudewan/Cyclistic_R/data/202103-divvy-tripdata.csv")
apr_2021 <- read_csv("/Users/purudewan/Cyclistic_R/data/202104-divvy-tripdata.csv")
may_2021 <- read_csv("/Users/purudewan/Cyclistic_R/data/202105-divvy-tripdata.csv")
jun_2021 <- read_csv("/Users/purudewan/Cyclistic_R/data/202106-divvy-tripdata.csv")
jul_2021 <- read_csv("/Users/purudewan/Cyclistic_R/data/202107-divvy-tripdata.csv")
aug_2021 <- read_csv("/Users/purudewan/Cyclistic_R/data/202108-divvy-tripdata.csv")
sep_2021 <- read_csv("/Users/purudewan/Cyclistic_R/data/202109-divvy-tripdata.csv")
oct_2021 <- read_csv("/Users/purudewan/Cyclistic_R/data/202110-divvy-tripdata.csv")
nov_2021 <- read_csv("/Users/purudewan/Cyclistic_R/data/202111-divvy-tripdata.csv")
dec_2021 <- read_csv("/Users/purudewan/Cyclistic_R/data/202112-divvy-tripdata.csv")
jan_2022 <- read_csv("/Users/purudewan/Cyclistic_R/data/202201-divvy-tripdata.csv")
feb_2022 <- read_csv("/Users/purudewan/Cyclistic_R/data/202202-divvy-tripdata.csv")
mar_2022 <- read_csv("/Users/purudewan/Cyclistic_R/data/202203-divvy-tripdata.csv")
apr_2022 <- read_csv("/Users/purudewan/Cyclistic_R/data/202204-divvy-tripdata.csv")
cyclistic_df <- rbind(apr_2020,may_2020,jun_2020,jul_2020,aug_2020,
                      sep_2020,oct_2020,nov_2020,dec_2020,jan_2021,
                      feb_2021,mar_2021,apr_2021,may_2021,jun_2021,
                      jul_2021,aug_2021,sep_2021,oct_2021,nov_2021,
                      dec_2021,jan_2022,feb_2022,mar_2022,apr_2022)
head(cyclistic_df)
nrow(cyclistic_df)
ncol(cyclistic_df)
colnames(cyclistic_df)

cyclistic_df_use <- cyclistic_df
cyclistic_df_use$weekday <- weekdays(date(cyclistic_df_use$started_at))
cyclistic_df_use$month_name <- months(date(cyclistic_df_use$started_at))
cyclistic_df_use$start_time_hour <- hour(cyclistic_df_use$started_at)
cyclistic_df_use$total_ride_time <- difftime(cyclistic_df_use$ended_at, cyclistic_df_use$started_at) / 60
cyclistic_df_use$total_ride_time <- as.integer(cyclistic_df_use$total_ride_time)
cyclistic_df_use$weekday <- ordered(cyclistic_df_use$weekday, levels = c("Monday", "Tuesday", "Wednesday", "Thursday", 
                                                                          "Friday", "Saturday", "Sunday"))
cyclistic_df_use$month_name <- ordered(cyclistic_df_use$month_name, levels = c("January", "February", "March",
                                                                     "April", "May", "June",
                                                                     "July", "August", "September",
                                                                     "October", "November", "December"))

cyclistic_df_use <- distinct(cyclistic_df_use)
cyclistic_df_use <- drop_na(cyclistic_df_use)
cyclistic_df_use <- remove_missing(cyclistic_df_use)
cyclistic_df_use <- filter(cyclistic_df_use, total_ride_time < 1440)
cyclistic_df_use <- filter(cyclistic_df_use, total_ride_time > 1)
cyclistic_df_use <- cyclistic_df_use %>% select(start_station_name, start_time_hour, end_station_name,
                                                total_ride_time, weekday, month_name, rideable_type, member_casual)

head(cyclistic_df_use)
nrow(cyclistic_df_use)
ncol(cyclistic_df_use)
colnames(cyclistic_df_use)

cyclistic_df_use %>%
  ggplot() +
  geom_smooth(mapping = aes(x = start_time_hour, y = total_ride_time, color = rideable_type))
ggsave("~/Cyclistic_R/startTimeVStotalTime_rideableType.png")

cyclistic_df_use %>%
  ggplot() +
  geom_smooth(mapping = aes(x = start_time_hour, y = total_ride_time, color = member_casual))
ggsave("~/Cyclistic_R/startTimeVStotalTime_memberCasual.png")

cyclistic_df_use %>%
  ggplot() +
  geom_bar(mapping = aes(x = weekday))
ggsave("~/Cyclistic_R/weekDayVScount.png")

cyclistic_df_use %>%
  ggplot() +
  geom_bar(mapping = aes(x = weekday, y = ((..count..)/sum(..count..))*100, fill = member_casual), position = "dodge") +
  labs(y = "riders_percentage")
ggsave("~/Cyclistic_R/weekDayVScount_memberCasual.png")

cyclistic_df_use %>%
  ggplot() +
  geom_bar(mapping = aes(x = month_name, y = ((..count..)/sum(..count..))*100, fill = member_casual), position = "dodge") +
  theme(axis.text.x = element_text(angle = 45)) +
  labs(x = "month", y = "riders_percentage")
ggsave("~/Cyclistic_R/monthVScount_memberCasual.png")

cyclistic_df_use %>%
  ggplot() +
  geom_bar(mapping = aes(x = factor(start_time_hour), y = ((..count..)/sum(..count..))*100, fill = member_casual), position = "dodge") +
  theme(axis.text.x = element_text(angle = 45)) +
  labs(x = "hour", y = "riders_percentage")
ggsave("~/Cyclistic_R/hourVScount_memberCasual.png")
