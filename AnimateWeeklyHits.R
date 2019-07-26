library(readtext)
library(tidyverse)
library(gganimate)
library(data.table)
#use geom_tile for animated bars, since it allows you to slide positions.

#Read from file
ahits.dt <- readtext(file_name, encoding = "utf-8") 

#select required columns
ahits.dt <- ahits.dt[,.SD,.SDcols = c(3,5,6,8)]
ahits.dt <- filter(ahits.dt, hit_week>as.POSIXct("1965-08-01"))
ahits.dt <- filter(ahits.dt, hit_week<as.POSIXct("1975-08-01"))
#ahits.dt <- filter(ahits.dt, Pos <=10)

# Animation
anim <- ggplot(ahits.dt, aes(Pos, group = Song, 
                                  fill = as.factor(Song), color = as.factor(Song))) +
   geom_tile(aes(y = Weeks/2,
                 height = Weeks,
                 width = 0.9), alpha = 0.8, color = NA) +
   geom_text(aes(y = 0, label = paste(Song, " ")), vjust = 1, hjust = 1) +
   geom_text(aes(y = Weeks,label = Weeks, hjust=0)) +
   coord_flip(clip = "off", expand = FALSE) +
   scale_y_continuous(labels = scales::comma) +
   scale_x_reverse() +
   guides(color = FALSE, fill = FALSE) +
   theme(axis.line=element_blank(),
         axis.text.x=element_blank(),
         axis.text.y=element_blank(),
         axis.ticks=element_blank(),
         axis.title.x=element_blank(),
         axis.title.y=element_blank(),
         legend.position="none",
         panel.background=element_blank(),
         panel.border=element_blank(),
         panel.grid.major=element_blank(),
         panel.grid.minor=element_blank(),
         panel.grid.major.x = element_line( size=.1, color="grey" ),
         panel.grid.minor.x = element_line( size=.1, color="grey" ),
         plot.title=element_text(size=20, hjust=0.5, face="bold", colour="grey", vjust=-1),
         plot.subtitle=element_text(size=14, hjust=0.5, face="italic", color="grey"),
         plot.caption =element_text(size=8, hjust=0.5, face="italic", color="grey"),
         plot.background=element_blank(),
         plot.margin = margin(2,2, 2, 6, "cm")) +
  transition_states(hit_week, transition_length = 4, state_length = 1) +
  view_follow(fixed_x = TRUE)  +
  labs(title = 'SA top 20 charts per week : {closest_state}',  
       subtitle  =  "The weekly South African Singles chart history",
       caption  = "Data Source: https://sacharts.wordpress.com/") 

# For GIF
#animate(anim, 200, fps = 20, width = 1200, height = 1000, 
#        renderer = gifski_renderer("gganimhits.gif")) 

# To get animation effect calculate frames:  
# (number of data snapshots -1) multiply with 20 
# Top 20 - so just take observasions minus 20
animate(anim, nframes = 10380, fps = 10, width = 1200, height = 1000, 
        renderer = gifski_renderer("gganimhits.gif"))  