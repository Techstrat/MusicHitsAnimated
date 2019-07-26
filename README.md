# MusicHitsAnimated
 
This code reads the list of music hits stored in weeklyhits.csv and plot it on an animated graph.

The graphs is a horizontal bar graph, with the number 1 hit at the top.  The height of each bar represents the number of weeks the single has been on the top 20 hit parade.  The result is written to a gif named gganimhits

The code is written to only look at the last 5 months of 1965 but can be expanded to look at all the weeks in the csv file (mid 1965 to early 1982).

To see how the data was scaped off the web and written to the csv file, refer to the repository MusicWebScraping.

This solution was developed in r and uses the folowing libraries:
* readtext
* tidyverse
* gganimate
* ggplot
* data.table

The Medium blog entry [Create Trending Animated Bar Charts using R](https://towardsdatascience.com/create-animated-bar-charts-using-r-31d09e5841da) was an inspiration for this development.
