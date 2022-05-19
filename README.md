# Cyclistic-GoogleCapstoneProject

**Introduction:**
Cyclistic is fictional bike share company that features 5800 cycles and 600 docking stations. Cyclistic sets itself apart by offering reclining bikes, hand tricycles and cargo bikes, making bike share more inclusive to people with disabilities and riders who can’t use a standard two-wheeled bike. Majority of the riders opt for traditional bike; about 8% of the riders use assistive option. Cyclistic users are more likely to ride for leisure, but about 30% use them to commute to work each day.

**Business Task:**
Converting casual riders to annual members. To achieve this, three questions will guide us:
1. How do annual members and casual riders use Cyclistic bikes differently?
2. Why would casual riders buy Cyclistic annual membership?
3. How can Cyclistic use digital media to influence casual riders to become members?

**Data Sources:**
User data from the past 12 months, November 2020 - April 2022 has been made available. Each data set is in csv format and details every ride logged by Cyclistic customers. This data has been made publicly available via license by Motivate International Inc. and the city of Chicago. All user’s personal data has been scrubbed for privacy.

**Data Cleanining and Manipulation:**
cyclistic_df_use$weekday <- weekdays(date(cyclistic_df_use$started_at)) #extracted name of the weekday
cyclistic_df_use$month_name <- months(date(cyclistic_df_use$started_at)) # extracted month name
cyclistic_df_use$start_time_hour <- hour(cyclistic_df_use$started_at) # extracted start time hour
cyclistic_df_use$total_ride_time <- difftime(cyclistic_df_use$ended_at, cyclistic_df_use$started_at) / 60 #computed total ride time
cyclistic_df_use$total_ride_time <- as.integer(cyclistic_df_use$total_ride_time)
cyclistic_df_use$weekday <- ordered(cyclistic_df_use$weekday, levels = c("Monday", "Tuesday", "Wednesday", "Thursday", 
                                                                          "Friday", "Saturday", "Sunday"))
cyclistic_df_use$month_name <- ordered(cyclistic_df_use$month_name, levels = c("January", "February", "March",
                                                                     "April", "May", "June",
                                                                     "July", "August", "September",
                                                                     "October", "November", "December"))
#Ordered weekday and month_name coloumn for easy data segregation
cyclistic_df_use <- distinct(cyclistic_df_use)
cyclistic_df_use <- drop_na(cyclistic_df_use) 
cyclistic_df_use <- remove_missing(cyclistic_df_use) 
cyclistic_df_use <- filter(cyclistic_df_use, total_ride_time < 1440) #did not consider rides exceding 24 hour i.e 1440 minutes
cyclistic_df_use <- filter(cyclistic_df_use, total_ride_time > 1) #did not consider rides less than 1 minute
cyclistic_df_use <- cyclistic_df_use %>% select(start_station_name, start_time_hour, end_station_name,
                                                total_ride_time, weekday, month_name, rideable_type, member_casual)
                                                                                               
**Data  Analysis and Viz:**
Please find attached R file and data visualisations.

![startTimeVStotalTime_memberCasual](https://user-images.githubusercontent.com/52069058/169350029-62497600-9c49-44f5-b9ea-c3be21c9a041.png)
![startTimeVStotalTime_rideableType](https://user-images.githubusercontent.com/52069058/169350069-15c11ef0-f632-4c4c-91c6-8a67bce657cc.png)
![weekDayVScount](https://user-images.githubusercontent.com/52069058/169350120-b3d23c31-9fa1-44dd-bcca-a5c78f9394bc.png)
![weekDayVScount_memberCasual](https://user-images.githubusercontent.com/52069058/169350158-23627d7f-fc8b-45ab-9e80-67ce255d7323.png)
![hourVScount_memberCasual](https://user-images.githubusercontent.com/52069058/169350288-73b3d8ef-cf2c-4900-aea6-2e18234c31bf.png)
![monthVScount_memberCasual](https://user-images.githubusercontent.com/52069058/169350310-078cc9d2-dbb2-4d90-9dff-78b5f5f5887c.png)

**Analysis:**
1. Docked Bike is the most rented bike of 3.
2. Casual member drive longer than annual member. Approximately twice.
3. Surge in number of rented bikes on saturday.
4. Annual member dominates on weekdays but casual member leaves annual member behind on weekends.
5. After 4:00pm in the evening, exponential increase is observed in riders percentage.
6. Exponential rise in riders percentage after month of June. 


**Recommendations:**
1. Riders likes biking in summers. Special summer discount or exclusive summer membership will help convert casual member to annual.
2. Only Weekends plans for customers who want to drive only on holidays. This will attract casual riders.
3. Charge more if rider exceeds 30 minutes limit OR buy membership plan which gives better benefits. This will convert casual riders driving more than 30 minutes.

**Additial Data Suggestions:**
1. Age and Gender will help to identify how audience behaves.
2. Pricing Plans.
