---
title: 'Weekly Exercises #6'
author: "Caedmon Kollmer-Dorsey"
output: 
  html_document:
    keep_md: TRUE
    toc: TRUE
    toc_float: TRUE
    df_print: paged
    code_download: true
---





```r
library(tidyverse)     # for data cleaning and plotting
library(googlesheets4) # for reading googlesheet data
library(lubridate)     # for date manipulation
library(openintro)     # for the abbr2state() function
library(palmerpenguins)# for Palmer penguin data
library(maps)          # for map data
library(ggmap)         # for mapping points on maps
library(gplots)        # for col2hex() function
library(RColorBrewer)  # for color palettes
library(sf)            # for working with spatial data
library(leaflet)       # for highly customizable mapping
library(ggthemes)      # for more themes (including theme_map())
library(plotly)        # for the ggplotly() - basic interactivity
library(gganimate)     # for adding animation layers to ggplots
library(gifski)        # for creating the gif (don't need to load this library every time,but need it installed)
library(transformr)    # for "tweening" (gganimate)
library(shiny)         # for creating interactive apps
library(patchwork)     # for nicely combining ggplot2 graphs  
library(gt)            # for creating nice tables
library(rvest)         # for scraping data
library(robotstxt)     # for checking if you can scrape data
gs4_deauth()           # To not have to authorize each time you knit.
theme_set(theme_minimal())
```


```r
# Lisa's garden data
garden_harvest <- read_sheet("https://docs.google.com/spreadsheets/d/1DekSazCzKqPS2jnGhKue7tLxRU3GVL1oxi-4bEM5IWw/edit?usp=sharing") %>% 
  mutate(date = ymd(date))

#COVID-19 data from the New York Times
covid19 <- read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv")
```

## Put your homework on GitHub!

Go [here](https://github.com/llendway/github_for_collaboration/blob/master/github_for_collaboration.md) or to previous homework to remind yourself how to get set up. 

Once your repository is created, you should always open your **project** rather than just opening an .Rmd file. You can do that by either clicking on the .Rproj file in your repository folder on your computer. Or, by going to the upper right hand corner in R Studio and clicking the arrow next to where it says Project: (None). You should see your project come up in that list if you've used it recently. You could also go to File --> Open Project and navigate to your .Rproj file. 

## Instructions

* Put your name at the top of the document. 

* **For ALL graphs, you should include appropriate labels.** 

* Feel free to change the default theme, which I currently have set to `theme_minimal()`. 

* Use good coding practice. Read the short sections on good code with [pipes](https://style.tidyverse.org/pipes.html) and [ggplot2](https://style.tidyverse.org/ggplot2.html). **This is part of your grade!**

* **NEW!!** With animated graphs, add `eval=FALSE` to the code chunk that creates the animation and saves it using `anim_save()`. Add another code chunk to reread the gif back into the file. See the [tutorial](https://animation-and-interactivity-in-r.netlify.app/) for help. 

* When you are finished with ALL the exercises, uncomment the options at the top so your document looks nicer. Don't do it before then, or else you might miss some important warnings and messages.

## Your first `shiny` app 

  1. This app will also use the COVID data. Make sure you load that data and all the libraries you need in the `app.R` file you create. Below, you will post a link to the app that you publish on shinyapps.io. You will create an app to compare states' cumulative number of COVID cases over time. The x-axis will be number of days since 20+ cases and the y-axis will be cumulative cases on the log scale (`scale_y_log10()`). We use number of days since 20+ cases on the x-axis so we can make better comparisons of the curve trajectories. You will have an input box where the user can choose which states to compare (`selectInput()`) and have a submit button to click once the user has chosen all states they're interested in comparing. The graph should display a different line for each state, with labels either on the graph or in a legend. Color can be used if needed. 
  
https://ckollmer01.shinyapps.io/weekly_exercises_6/  
  
## Warm-up exercises from tutorial

  2. Read in the fake garden harvest data. Find the data [here](https://github.com/llendway/scraping_etc/blob/main/2020_harvest.csv) and click on the `Raw` button to get a direct link to the data. 

```r
new_harvest_set <- read_csv("https://raw.githubusercontent.com/llendway/scraping_etc/main/2020_harvest.csv", 
    col_types = cols(weight = col_number()), 
    na = "null", skip = 2)
new_harvest_set %>%
  select(-X1)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["vegetable"],"name":[1],"type":["chr"],"align":["left"]},{"label":["variety"],"name":[2],"type":["chr"],"align":["left"]},{"label":["date"],"name":[3],"type":["chr"],"align":["left"]},{"label":["weight"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["units"],"name":[5],"type":["chr"],"align":["left"]}],"data":[{"1":"lettuce","2":"reseed","3":"6/6/20","4":"20","5":"grams"},{"1":"radish","2":"Garden Party Mix","3":"6/6/20","4":"36","5":"grams"},{"1":"lettuce","2":"reseed","3":"6/8/20","4":"15","5":"grams"},{"1":"lettuce","2":"reseed","3":"6/9/20","4":"10","5":"grams"},{"1":"radish","2":"Garden Party Mix","3":"6/11/20","4":"67","5":"grams"},{"1":"lettuce","2":"Farmer's Market Blend","3":"6/11/20","4":"12","5":"grams"},{"1":"spinach","2":"Catalina","3":"6/11/20","4":"9","5":"grams"},{"1":"beets","2":"leaves","3":"6/11/20","4":"8","5":"grams"},{"1":"radish","2":"Garden Party Mix","3":"6/13/20","4":"53","5":"grams"},{"1":"lettuce","2":"MISSING","3":"6/13/20","4":"19","5":"grams"},{"1":"spinach","2":"Catalina","3":"6/13/20","4":"14","5":"grams"},{"1":"kale","2":"Heirloom Lacinto","3":"6/13/20","4":"10","5":"grams"},{"1":"lettuce","2":"Farmer's Market Blend","3":"6/17/20","4":"NA","5":"grams"},{"1":"spinach","2":"Catalina","3":"6/17/20","4":"58","5":"grams"},{"1":"peas","2":"Magnolia Blossom","3":"6/17/20","4":"8","5":"grams"},{"1":"peas","2":"Super Sugar Snap","3":"6/17/20","4":"121","5":"grams"},{"1":"chives","2":"perrenial","3":"6/17/20","4":"8","5":"grams"},{"1":"strawberries","2":"perrenial","3":"6/18/20","4":"40","5":"grams"},{"1":"lettuce","2":"Farmer's Market Blend","3":"6/18/20","4":"47","5":"grams"},{"1":"spinach","2":"MISSING","3":"6/18/20","4":"59","5":"grams"},{"1":"beets","2":"leaves","3":"6/18/20","4":"25","5":"grams"},{"1":"spinach","2":"Catalina","3":"6/19/20","4":"58","5":"grams"},{"1":"lettuce","2":"Farmer's Market Blend","3":"6/19/20","4":"39","5":"grams"},{"1":"beets","2":"leaves","3":"6/19/20","4":"11","5":"grams"},{"1":"lettuce","2":"Farmer's Market Blend","3":"6/19/20","4":"NA","5":"grams"},{"1":"lettuce","2":"Farmer's Market Blend","3":"6/20/20","4":"22","5":"grams"},{"1":"spinach","2":"Catalina","3":"6/20/20","4":"25","5":"grams"},{"1":"lettuce","2":"Tatsoi","3":"6/20/20","4":"18","5":"grams"},{"1":"radish","2":"Garden Party Mix","3":"6/20/20","4":"16","5":"grams"},{"1":"peas","2":"Magnolia Blossom","3":"6/20/20","4":"71","5":"grams"},{"1":"peas","2":"Super Sugar Snap","3":"6/20/20","4":"148","5":"grams"},{"1":"asparagus","2":"asparagus","3":"6/20/20","4":"20","5":"grams"},{"1":"radish","2":"Garden Party Mix","3":"6/21/20","4":"37","5":"grams"},{"1":"Swiss chard","2":"Neon Glow","3":"6/21/20","4":"19","5":"grams"},{"1":"spinach","2":"Catalina","3":"6/21/20","4":"71","5":"grams"},{"1":"lettuce","2":"Farmer's Market Blend","3":"6/21/20","4":"95","5":"grams"},{"1":"spinach","2":"Catalina","3":"6/21/20","4":"51","5":"grams"},{"1":"Swiss chard","2":"Neon Glow","3":"6/21/20","4":"13","5":"grams"},{"1":"beets","2":"leaves","3":"6/21/20","4":"57","5":"grams"},{"1":"kale","2":"Heirloom Lacinto","3":"6/21/20","4":"60","5":"grams"},{"1":"spinach","2":"Catalina","3":"6/22/20","4":"37","5":"grams"},{"1":"lettuce","2":"Farmer's Market Blend","3":"6/22/20","4":"52","5":"grams"},{"1":"peas","2":"Super Sugar Snap","3":"6/22/20","4":"40","5":"grams"},{"1":"peas","2":"Magnolia Blossom","3":"6/22/20","4":"19","5":"grams"},{"1":"strawberries","2":"perrenial","3":"6/22/20","4":"19","5":"grams"},{"1":"lettuce","2":"Farmer's Market Blend","3":"6/22/20","4":"18","5":"grams"},{"1":"peas","2":"Magnolia Blossom","3":"6/23/20","4":"40","5":"grams"},{"1":"peas","2":"Super Sugar Snap","3":"6/23/20","4":"165","5":"grams"},{"1":"spinach","2":"Catalina","3":"6/23/20","4":"41","5":"grams"},{"1":"cilantro","2":"cilantro","3":"6/23/20","4":"2","5":"grams"},{"1":"basil","2":"Isle of Naxos","3":"6/23/20","4":"5","5":"grams"},{"1":"peas","2":"Super Sugar Snap","3":"6/24/20","4":"34","5":"grams"},{"1":"lettuce","2":"Farmer's Market Blend","3":"6/24/20","4":"122","5":"grams"},{"1":"spinach","2":"Catalina","3":"6/25/20","4":"22","5":"grams"},{"1":"lettuce","2":"Farmer's Market Blend","3":"6/25/20","4":"30","5":"grams"},{"1":"strawberries","2":"perrenial","3":"6/26/20","4":"17","5":"grams"},{"1":"peas","2":"Super Sugar Snap","3":"6/26/20","4":"425","5":"grams"},{"1":"lettuce","2":"Farmer's Market Blend","3":"6/27/20","4":"52","5":"grams"},{"1":"lettuce","2":"Tatsoi","3":"6/27/20","4":"89","5":"grams"},{"1":"spinach","2":"MISSING","3":"6/27/20","4":"60","5":"grams"},{"1":"peas","2":"Magnolia Blossom","3":"6/27/20","4":"333","5":"grams"},{"1":"peas","2":"Super Sugar Snap","3":"6/28/20","4":"793","5":"grams"},{"1":"spinach","2":"Catalina","3":"6/28/20","4":"99","5":"grams"},{"1":"lettuce","2":"Farmer's Market Blend","3":"6/28/20","4":"111","5":"grams"},{"1":"lettuce","2":"Farmer's Market Blend","3":"6/29/20","4":"58","5":"grams"},{"1":"lettuce","2":"mustard greens","3":"6/29/20","4":"23","5":"grams"},{"1":"peas","2":"Magnolia Blossom","3":"6/29/20","4":"625","5":"grams"},{"1":"peas","2":"Super Sugar Snap","3":"6/29/20","4":"561","5":"grams"},{"1":"raspberries","2":"perrenial","3":"6/29/20","4":"30","5":"grams"},{"1":"lettuce","2":"Farmer's Market Blend","3":"6/29/20","4":"82","5":"grams"},{"1":"Swiss chard","2":"Neon Glow","3":"6/30/20","4":"32","5":"grams"},{"1":"spinach","2":"Catalina","3":"6/30/20","4":"80","5":"grams"},{"1":"lettuce","2":"Farmer's Market Blend","3":"7/1/20","4":"60","5":"grams"},{"1":"lettuce","2":"Tatsoi","3":"7/2/20","4":"144","5":"grams"},{"1":"spinach","2":"Catalina","3":"7/2/20","4":"16","5":"grams"},{"1":"peas","2":"Magnolia Blossom","3":"7/2/20","4":"798","5":"grams"},{"1":"peas","2":"Super Sugar Snap","3":"7/2/20","4":"743","5":"grams"},{"1":"lettuce","2":"Farmer's Market Blend","3":"7/3/20","4":"217","5":"grams"},{"1":"lettuce","2":"Tatsoi","3":"7/3/20","4":"216","5":"grams"},{"1":"radish","2":"Garden Party Mix","3":"7/3/20","4":"88","5":"grams"},{"1":"basil","2":"Isle of Naxos","3":"7/3/20","4":"9","5":"grams"},{"1":"peas","2":"Super Sugar Snap","3":"7/4/20","4":"285","5":"grams"},{"1":"peas","2":"Magnolia Blossom","3":"7/4/20","4":"457","5":"grams"},{"1":"lettuce","2":"Farmer's Market Blend","3":"7/4/20","4":"147","5":"grams"},{"1":"basil","2":"Isle of Naxos","3":"7/6/20","4":"17","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"7/6/20","4":"175","5":"grams"},{"1":"beans","2":"Bush Bush Slender","3":"7/6/20","4":"NA","5":"grams"},{"1":"lettuce","2":"Tatsoi","3":"7/6/20","4":"NA","5":"grams"},{"1":"peas","2":"Magnolia Blossom","3":"7/6/20","4":"433","5":"grams"},{"1":"peas","2":"Super Sugar Snap","3":"7/6/20","4":"48","5":"grams"},{"1":"lettuce","2":"Farmer's Market Blend","3":"7/7/20","4":"67","5":"grams"},{"1":"beets","2":"Gourmet Golden","3":"7/7/20","4":"62","5":"grams"},{"1":"beets","2":"Sweet Merlin","3":"7/7/20","4":"10","5":"grams"},{"1":"radish","2":"Garden Party Mix","3":"7/7/20","4":"43","5":"grams"},{"1":"basil","2":"Isle of Naxos","3":"7/7/20","4":"11","5":"grams"},{"1":"lettuce","2":"Farmer's Market Blend","3":"7/7/20","4":"13","5":"grams"},{"1":"peas","2":"Super Sugar Snap","3":"7/8/20","4":"75","5":"grams"},{"1":"peas","2":"Magnolia Blossom","3":"7/8/20","4":"252","5":"grams"},{"1":"beans","2":"Bush Bush Slender","3":"7/8/20","4":"178","5":"grams"},{"1":"lettuce","2":"Farmer's Market Blend","3":"7/8/20","4":"39","5":"grams"},{"1":"cucumbers","2":"pickling","3":"7/8/20","4":"181","5":"grams"},{"1":"beets","2":"Gourmet Golden","3":"7/8/20","4":"83","5":"grams"},{"1":"Swiss chard","2":"Neon Glow","3":"7/8/20","4":"96","5":"grams"},{"1":"lettuce","2":"Tatsoi","3":"7/8/20","4":"75","5":"grams"},{"1":"lettuce","2":"Farmer's Market Blend","3":"7/9/20","4":"61","5":"grams"},{"1":"raspberries","2":"perrenial","3":"7/9/20","4":"131","5":"grams"},{"1":"beans","2":"Bush Bush Slender","3":"7/9/20","4":"140","5":"grams"},{"1":"beets","2":"Sweet Merlin","3":"7/9/20","4":"69","5":"grams"},{"1":"cucumbers","2":"pickling","3":"7/9/20","4":"78","5":"grams"},{"1":"raspberries","2":"perrenial","3":"7/10/20","4":"61","5":"grams"},{"1":"basil","2":"Isle of Naxos","3":"7/10/20","4":"150","5":"grams"},{"1":"raspberries","2":"perrenial","3":"7/11/20","4":"60","5":"grams"},{"1":"strawberries","2":"perrenial","3":"7/11/20","4":"77","5":"grams"},{"1":"spinach","2":"Catalina","3":"7/11/20","4":"19","5":"grams"},{"1":"lettuce","2":"Farmer's Market Blend","3":"7/11/20","4":"79","5":"grams"},{"1":"raspberries","2":"perrenial","3":"7/11/20","4":"105","5":"grams"},{"1":"beans","2":"Bush Bush Slender","3":"7/11/20","4":"701","5":"grams"},{"1":"tomatoes","2":"grape","3":"7/11/20","4":"24","5":"grams"},{"1":"cucumbers","2":"pickling","3":"7/12/20","4":"130","5":"grams"},{"1":"beets","2":"Sweet Merlin","3":"7/12/20","4":"89","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"7/12/20","4":"492","5":"grams"},{"1":"lettuce","2":"Farmer's Market Blend","3":"7/12/20","4":"83","5":"grams"},{"1":"cucumbers","2":"pickling","3":"7/13/20","4":"47","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"7/13/20","4":"145","5":"grams"},{"1":"radish","2":"Garden Party Mix","3":"7/13/20","4":"50","5":"grams"},{"1":"strawberries","2":"perrenial","3":"7/13/20","4":"85","5":"grams"},{"1":"lettuce","2":"Farmer's Market Blend","3":"7/13/20","4":"53","5":"grams"},{"1":"lettuce","2":"Tatsoi","3":"7/13/20","4":"137","5":"grams"},{"1":"peas","2":"Super Sugar Snap","3":"7/13/20","4":"40","5":"grams"},{"1":"beans","2":"Bush Bush Slender","3":"7/13/20","4":"443","5":"grams"},{"1":"kale","2":"Heirloom Lacinto","3":"7/14/20","4":"128","5":"grams"},{"1":"cucumbers","2":"pickling","3":"7/14/20","4":"152","5":"grams"},{"1":"peas","2":"Magnolia Blossom","3":"7/14/20","4":"207","5":"grams"},{"1":"peas","2":"Super Sugar Snap","3":"7/14/20","4":"526","5":"grams"},{"1":"raspberries","2":"perrenial","3":"7/14/20","4":"152","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"7/15/20","4":"393","5":"grams"},{"1":"beans","2":"Bush Bush Slender","3":"7/15/20","4":"743","5":"grams"},{"1":"cucumbers","2":"pickling","3":"7/15/20","4":"1057","5":"grams"},{"1":"spinach","2":"Catalina","3":"7/15/20","4":"39","5":"grams"},{"1":"Swiss chard","2":"Neon Glow","3":"7/16/20","4":"29","5":"grams"},{"1":"lettuce","2":"Farmer's Market Blend","3":"7/16/20","4":"61","5":"grams"},{"1":"onions","2":"Delicious Duo","3":"7/16/20","4":"50","5":"grams"},{"1":"strawberries","2":"perrenial","3":"7/17/20","4":"88","5":"grams"},{"1":"cilantro","2":"cilantro","3":"7/17/20","4":"33","5":"grams"},{"1":"basil","2":"Isle of Naxos","3":"7/17/20","4":"16","5":"grams"},{"1":"jalapeño","2":"giant","3":"7/17/20","4":"20","5":"grams"},{"1":"cucumbers","2":"pickling","3":"7/17/20","4":"347","5":"grams"},{"1":"raspberries","2":"perrenial","3":"7/18/20","4":"77","5":"grams"},{"1":"beets","2":"Sweet Merlin","3":"7/18/20","4":"172","5":"grams"},{"1":"kale","2":"Heirloom Lacinto","3":"7/18/20","4":"61","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"7/18/20","4":"81","5":"grams"},{"1":"cucumbers","2":"pickling","3":"7/18/20","4":"294","5":"grams"},{"1":"beans","2":"Bush Bush Slender","3":"7/18/20","4":"660","5":"grams"},{"1":"kale","2":"Heirloom Lacinto","3":"7/19/20","4":"113","5":"grams"},{"1":"cucumbers","2":"pickling","3":"7/19/20","4":"531","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"7/19/20","4":"344","5":"grams"},{"1":"strawberries","2":"perrenial","3":"7/19/20","4":"37","5":"grams"},{"1":"peas","2":"Magnolia Blossom","3":"7/19/20","4":"140","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"7/20/20","4":"134","5":"grams"},{"1":"cucumbers","2":"pickling","3":"7/20/20","4":"179","5":"grams"},{"1":"peas","2":"Super Sugar Snap","3":"7/20/20","4":"336","5":"grams"},{"1":"beets","2":"Gourmet Golden","3":"7/20/20","4":"107","5":"grams"},{"1":"kale","2":"Heirloom Lacinto","3":"7/20/20","4":"128","5":"grams"},{"1":"hot peppers","2":"thai","3":"7/20/20","4":"12","5":"grams"},{"1":"beans","2":"Bush Bush Slender","3":"7/20/20","4":"519","5":"grams"},{"1":"hot peppers","2":"variety","3":"7/20/20","4":"559","5":"grams"},{"1":"jalapeño","2":"giant","3":"7/20/20","4":"197","5":"grams"},{"1":"lettuce","2":"Tatsoi","3":"7/20/20","4":"123","5":"grams"},{"1":"Swiss chard","2":"Neon Glow","3":"7/20/20","4":"178","5":"grams"},{"1":"onions","2":"Long Keeping Rainbow","3":"7/20/20","4":"102","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"7/21/20","4":"110","5":"grams"},{"1":"tomatoes","2":"grape","3":"7/21/20","4":"86","5":"grams"},{"1":"tomatoes","2":"Big Beef","3":"7/21/20","4":"137","5":"grams"},{"1":"tomatoes","2":"Bonny Best","3":"7/21/20","4":"339","5":"grams"},{"1":"beans","2":"Bush Bush Slender","3":"7/21/20","4":"21","5":"grams"},{"1":"spinach","2":"Catalina","3":"7/21/20","4":"21","5":"grams"},{"1":"basil","2":"Isle of Naxos","3":"7/21/20","4":"7","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"7/22/20","4":"76","5":"grams"},{"1":"beans","2":"Bush Bush Slender","3":"7/22/20","4":"351","5":"grams"},{"1":"cucumbers","2":"pickling","3":"7/22/20","4":"655","5":"grams"},{"1":"lettuce","2":"Lettuce Mixture","3":"7/22/20","4":"23","5":"grams"},{"1":"beans","2":"Bush Bush Slender","3":"7/23/20","4":"129","5":"grams"},{"1":"carrots","2":"King Midas","3":"7/23/20","4":"56","5":"grams"},{"1":"Swiss chard","2":"Neon Glow","3":"7/23/20","4":"466","5":"grams"},{"1":"onions","2":"Long Keeping Rainbow","3":"7/23/20","4":"91","5":"grams"},{"1":"lettuce","2":"Lettuce Mixture","3":"7/23/20","4":"130","5":"grams"},{"1":"cucumbers","2":"pickling","3":"7/24/20","4":"525","5":"grams"},{"1":"tomatoes","2":"grape","3":"7/24/20","4":"31","5":"grams"},{"1":"tomatoes","2":"Bonny Best","3":"7/24/20","4":"140","5":"grams"},{"1":"tomatoes","2":"Cherokee Purple","3":"7/24/20","4":"247","5":"grams"},{"1":"tomatoes","2":"Better Boy","3":"7/24/20","4":"220","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"7/24/20","4":"1321","5":"grams"},{"1":"beans","2":"Bush Bush Slender","3":"7/24/20","4":"100","5":"grams"},{"1":"raspberries","2":"perrenial","3":"7/24/20","4":"32","5":"grams"},{"1":"strawberries","2":"perrenial","3":"7/24/20","4":"93","5":"grams"},{"1":"lettuce","2":"Lettuce Mixture","3":"7/24/20","4":"16","5":"grams"},{"1":"basil","2":"Isle of Naxos","3":"7/24/20","4":"3","5":"grams"},{"1":"peppers","2":"variety","3":"7/24/20","4":"68","5":"grams"},{"1":"carrots","2":"King Midas","3":"7/24/20","4":"178","5":"grams"},{"1":"carrots","2":"Dragon","3":"7/24/20","4":"80","5":"grams"},{"1":"tomatoes","2":"Amish Paste","3":"7/25/20","4":"463","5":"grams"},{"1":"tomatoes","2":"grape","3":"7/25/20","4":"106","5":"grams"},{"1":"kale","2":"Heirloom Lacinto","3":"7/25/20","4":"121","5":"grams"},{"1":"cucumbers","2":"pickling","3":"7/25/20","4":"901","5":"grams"},{"1":"lettuce","2":"Lettuce Mixture","3":"7/26/20","4":"81","5":"grams"},{"1":"tomatoes","2":"Bonny Best","3":"7/26/20","4":"148","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"7/27/20","4":"1542","5":"grams"},{"1":"beans","2":"Bush Bush Slender","3":"7/27/20","4":"728","5":"grams"},{"1":"cucumbers","2":"pickling","3":"7/27/20","4":"785","5":"grams"},{"1":"strawberries","2":"perrenial","3":"7/27/20","4":"113","5":"grams"},{"1":"raspberries","2":"perrenial","3":"7/27/20","4":"29","5":"grams"},{"1":"tomatoes","2":"Mortgage Lifter","3":"7/27/20","4":"801","5":"grams"},{"1":"lettuce","2":"Lettuce Mixture","3":"7/27/20","4":"99","5":"grams"},{"1":"beets","2":"Sweet Merlin","3":"7/27/20","4":"49","5":"grams"},{"1":"beets","2":"Gourmet Golden","3":"7/27/20","4":"149","5":"grams"},{"1":"radish","2":"Garden Party Mix","3":"7/27/20","4":"39","5":"grams"},{"1":"carrots","2":"King Midas","3":"7/27/20","4":"174","5":"grams"},{"1":"onions","2":"Long Keeping Rainbow","3":"7/27/20","4":"129","5":"grams"},{"1":"broccoli","2":"Yod Fah","3":"7/27/20","4":"372","5":"grams"},{"1":"carrots","2":"King Midas","3":"7/28/20","4":"160","5":"grams"},{"1":"tomatoes","2":"Old German","3":"7/28/20","4":"611","5":"grams"},{"1":"tomatoes","2":"Big Beef","3":"7/28/20","4":"203","5":"grams"},{"1":"tomatoes","2":"Better Boy","3":"7/28/20","4":"312","5":"grams"},{"1":"tomatoes","2":"Jet Star","3":"7/28/20","4":"315","5":"grams"},{"1":"tomatoes","2":"grape","3":"7/28/20","4":"131","5":"grams"},{"1":"lettuce","2":"Lettuce Mixture","3":"7/28/20","4":"91","5":"grams"},{"1":"cucumbers","2":"pickling","3":"7/28/20","4":"76","5":"grams"},{"1":"tomatoes","2":"Bonny Best","3":"7/29/20","4":"153","5":"grams"},{"1":"tomatoes","2":"Better Boy","3":"7/29/20","4":"442","5":"grams"},{"1":"tomatoes","2":"Cherokee Purple","3":"7/29/20","4":"240","5":"grams"},{"1":"tomatoes","2":"Amish Paste","3":"7/29/20","4":"209","5":"grams"},{"1":"lettuce","2":"Lettuce Mixture","3":"7/29/20","4":"73","5":"grams"},{"1":"tomatoes","2":"grape","3":"7/29/20","4":"40","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"7/29/20","4":"457","5":"grams"},{"1":"cucumbers","2":"pickling","3":"7/29/20","4":"514","5":"grams"},{"1":"beans","2":"Bush Bush Slender","3":"7/29/20","4":"305","5":"grams"},{"1":"kale","2":"Heirloom Lacinto","3":"7/29/20","4":"280","5":"grams"},{"1":"tomatoes","2":"grape","3":"7/30/20","4":"91","5":"grams"},{"1":"beets","2":"Sweet Merlin","3":"7/30/20","4":"101","5":"grams"},{"1":"onions","2":"Long Keeping Rainbow","3":"7/30/20","4":"19","5":"grams"},{"1":"lettuce","2":"Lettuce Mixture","3":"7/30/20","4":"94","5":"grams"},{"1":"carrots","2":"Bolero","3":"7/30/20","4":"116","5":"grams"},{"1":"carrots","2":"King Midas","3":"7/30/20","4":"107","5":"grams"},{"1":"cucumbers","2":"pickling","3":"7/30/20","4":"626","5":"grams"},{"1":"tomatoes","2":"Cherokee Purple","3":"7/31/20","4":"307","5":"grams"},{"1":"tomatoes","2":"Amish Paste","3":"7/31/20","4":"197","5":"grams"},{"1":"tomatoes","2":"Old German","3":"7/31/20","4":"633","5":"grams"},{"1":"tomatoes","2":"Better Boy","3":"7/31/20","4":"290","5":"grams"},{"1":"tomatoes","2":"grape","3":"7/31/20","4":"100","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"7/31/20","4":"1215","5":"grams"},{"1":"beans","2":"Bush Bush Slender","3":"7/31/20","4":"592","5":"grams"},{"1":"strawberries","2":"perrenial","3":"7/31/20","4":"23","5":"grams"},{"1":"spinach","2":"Catalina","3":"7/31/20","4":"31","5":"grams"},{"1":"lettuce","2":"Lettuce Mixture","3":"7/31/20","4":"107","5":"grams"},{"1":"cucumbers","2":"pickling","3":"7/31/20","4":"174","5":"grams"},{"1":"tomatoes","2":"Bonny Best","3":"8/1/20","4":"435","5":"grams"},{"1":"tomatoes","2":"Brandywine","3":"8/1/20","4":"320","5":"grams"},{"1":"tomatoes","2":"Cherokee Purple","3":"8/1/20","4":"619","5":"grams"},{"1":"tomatoes","2":"Amish Paste","3":"8/1/20","4":"97","5":"grams"},{"1":"tomatoes","2":"Black Krim","3":"8/1/20","4":"436","5":"grams"},{"1":"tomatoes","2":"grape","3":"8/1/20","4":"168","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"8/1/20","4":"164","5":"grams"},{"1":"cucumbers","2":"pickling","3":"8/1/20","4":"1130","5":"grams"},{"1":"basil","2":"Isle of Naxos","3":"8/1/20","4":"137","5":"grams"},{"1":"jalapeño","2":"giant","3":"8/1/20","4":"74","5":"grams"},{"1":"cilantro","2":"cilantro","3":"8/1/20","4":"17","5":"grams"},{"1":"onions","2":"Delicious Duo","3":"8/1/20","4":"182","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"8/2/20","4":"1175","5":"grams"},{"1":"tomatoes","2":"Amish Paste","3":"8/2/20","4":"509","5":"grams"},{"1":"tomatoes","2":"Black Krim","3":"8/2/20","4":"857","5":"grams"},{"1":"tomatoes","2":"Old German","3":"8/2/20","4":"336","5":"grams"},{"1":"tomatoes","2":"Bonny Best","3":"8/2/20","4":"156","5":"grams"},{"1":"tomatoes","2":"Better Boy","3":"8/2/20","4":"211","5":"grams"},{"1":"tomatoes","2":"grape","3":"8/2/20","4":"102","5":"grams"},{"1":"tomatoes","2":"Better Boy","3":"8/3/20","4":"308","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"8/3/20","4":"252","5":"grams"},{"1":"cucumbers","2":"pickling","3":"8/3/20","4":"1155","5":"grams"},{"1":"beans","2":"Bush Bush Slender","3":"8/3/20","4":"572","5":"grams"},{"1":"lettuce","2":"Lettuce Mixture","3":"8/3/20","4":"65","5":"grams"},{"1":"kale","2":"Heirloom Lacinto","3":"8/3/20","4":"383","5":"grams"},{"1":"tomatoes","2":"Bonny Best","3":"8/4/20","4":"387","5":"grams"},{"1":"tomatoes","2":"Brandywine","3":"8/4/20","4":"231","5":"grams"},{"1":"tomatoes","2":"volunteers","3":"8/4/20","4":"73","5":"grams"},{"1":"tomatoes","2":"Mortgage Lifter","3":"8/4/20","4":"339","5":"grams"},{"1":"tomatoes","2":"grape","3":"8/4/20","4":"118","5":"grams"},{"1":"peppers","2":"variety","3":"8/4/20","4":"270","5":"grams"},{"1":"jalapeño","2":"giant","3":"8/4/20","4":"162","5":"grams"},{"1":"lettuce","2":"Lettuce Mixture","3":"8/4/20","4":"56","5":"grams"},{"1":"peppers","2":"variety","3":"8/4/20","4":"192","5":"grams"},{"1":"onions","2":"Long Keeping Rainbow","3":"8/4/20","4":"195","5":"grams"},{"1":"peppers","2":"green","3":"8/4/20","4":"81","5":"grams"},{"1":"jalapeño","2":"giant","3":"8/4/20","4":"87","5":"grams"},{"1":"hot peppers","2":"thai","3":"8/4/20","4":"24","5":"grams"},{"1":"hot peppers","2":"variety","3":"8/4/20","4":"40","5":"grams"},{"1":"spinach","2":"Catalina","3":"8/4/20","4":"44","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"8/4/20","4":"427","5":"grams"},{"1":"tomatoes","2":"Bonny Best","3":"8/5/20","4":"563","5":"grams"},{"1":"tomatoes","2":"Brandywine","3":"8/5/20","4":"290","5":"grams"},{"1":"tomatoes","2":"Mortgage Lifter","3":"8/5/20","4":"781","5":"grams"},{"1":"tomatoes","2":"Big Beef","3":"8/5/20","4":"223","5":"grams"},{"1":"tomatoes","2":"Amish Paste","3":"8/5/20","4":"382","5":"grams"},{"1":"tomatoes","2":"grape","3":"8/5/20","4":"217","5":"grams"},{"1":"tomatoes","2":"volunteers","3":"8/5/20","4":"67","5":"grams"},{"1":"beans","2":"Classic Slenderette","3":"8/5/20","4":"41","5":"grams"},{"1":"beans","2":"Bush Bush Slender","3":"8/5/20","4":"234","5":"grams"},{"1":"tomatoes","2":"Black Krim","3":"8/6/20","4":"393","5":"grams"},{"1":"tomatoes","2":"Big Beef","3":"8/6/20","4":"307","5":"grams"},{"1":"tomatoes","2":"Amish Paste","3":"8/6/20","4":"175","5":"grams"},{"1":"tomatoes","2":"Cherokee Purple","3":"8/6/20","4":"303","5":"grams"},{"1":"cucumbers","2":"pickling","3":"8/6/20","4":"127","5":"grams"},{"1":"lettuce","2":"Lettuce Mixture","3":"8/6/20","4":"98","5":"grams"},{"1":"carrots","2":"Bolero","3":"8/6/20","4":"164","5":"grams"},{"1":"carrots","2":"Dragon","3":"8/6/20","4":"442","5":"grams"},{"1":"potatoes","2":"purple","3":"8/6/20","4":"317","5":"grams"},{"1":"potatoes","2":"yellow","3":"8/6/20","4":"439","5":"grams"},{"1":"tomatoes","2":"Bonny Best","3":"8/7/20","4":"359","5":"grams"},{"1":"tomatoes","2":"Brandywine","3":"8/7/20","4":"356","5":"grams"},{"1":"tomatoes","2":"Old German","3":"8/7/20","4":"233","5":"grams"},{"1":"tomatoes","2":"Mortgage Lifter","3":"8/7/20","4":"364","5":"grams"},{"1":"tomatoes","2":"Better Boy","3":"8/7/20","4":"1045","5":"grams"},{"1":"tomatoes","2":"Jet Star","3":"8/7/20","4":"562","5":"grams"},{"1":"tomatoes","2":"grape","3":"8/7/20","4":"292","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"8/7/20","4":"1219","5":"grams"},{"1":"cucumbers","2":"pickling","3":"8/7/20","4":"1327","5":"grams"},{"1":"carrots","2":"Bolero","3":"8/7/20","4":"255","5":"grams"},{"1":"lettuce","2":"Lettuce Mixture","3":"8/7/20","4":"19","5":"grams"},{"1":"tomatoes","2":"Big Beef","3":"8/8/20","4":"162","5":"grams"},{"1":"tomatoes","2":"grape","3":"8/8/20","4":"81","5":"grams"},{"1":"tomatoes","2":"Bonny Best","3":"8/8/20","4":"564","5":"grams"},{"1":"tomatoes","2":"Jet Star","3":"8/8/20","4":"184","5":"grams"},{"1":"beans","2":"Chinese Red Noodle","3":"8/8/20","4":"108","5":"grams"},{"1":"beans","2":"Classic Slenderette","3":"8/8/20","4":"122","5":"grams"},{"1":"cucumbers","2":"pickling","3":"8/8/20","4":"1697","5":"grams"},{"1":"beans","2":"Bush Bush Slender","3":"8/8/20","4":"545","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"8/8/20","4":"445","5":"grams"},{"1":"kale","2":"Heirloom Lacinto","3":"8/8/20","4":"305","5":"grams"},{"1":"tomatoes","2":"Bonny Best","3":"8/9/20","4":"179","5":"grams"},{"1":"tomatoes","2":"Jet Star","3":"8/9/20","4":"591","5":"grams"},{"1":"tomatoes","2":"Better Boy","3":"8/9/20","4":"1102","5":"grams"},{"1":"tomatoes","2":"Cherokee Purple","3":"8/9/20","4":"308","5":"grams"},{"1":"tomatoes","2":"volunteers","3":"8/9/20","4":"54","5":"grams"},{"1":"tomatoes","2":"grape","3":"8/9/20","4":"64","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"8/9/20","4":"443","5":"grams"},{"1":"onions","2":"Long Keeping Rainbow","3":"8/9/20","4":"118","5":"grams"},{"1":"Swiss chard","2":"Neon Glow","3":"8/9/20","4":"302","5":"grams"},{"1":"basil","2":"Isle of Naxos","3":"8/10/20","4":"13","5":"grams"},{"1":"potatoes","2":"yellow","3":"8/10/20","4":"272","5":"grams"},{"1":"potatoes","2":"purple","3":"8/10/20","4":"168","5":"grams"},{"1":"tomatoes","2":"Cherokee Purple","3":"8/10/20","4":"216","5":"grams"},{"1":"tomatoes","2":"Jet Star","3":"8/10/20","4":"241","5":"grams"},{"1":"Swiss chard","2":"Neon Glow","3":"8/10/20","4":"309","5":"grams"},{"1":"carrots","2":"Bolero","3":"8/10/20","4":"221","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"8/11/20","4":"731","5":"grams"},{"1":"tomatoes","2":"grape","3":"8/11/20","4":"302","5":"grams"},{"1":"tomatoes","2":"Bonny Best","3":"8/11/20","4":"307","5":"grams"},{"1":"tomatoes","2":"volunteers","3":"8/11/20","4":"160","5":"grams"},{"1":"beans","2":"Bush Bush Slender","3":"8/11/20","4":"755","5":"grams"},{"1":"cucumbers","2":"pickling","3":"8/11/20","4":"1029","5":"grams"},{"1":"beans","2":"Chinese Red Noodle","3":"8/11/20","4":"78","5":"grams"},{"1":"beans","2":"Classic Slenderette","3":"8/11/20","4":"245","5":"grams"},{"1":"tomatoes","2":"Brandywine","3":"8/11/20","4":"218","5":"grams"},{"1":"tomatoes","2":"Cherokee Purple","3":"8/11/20","4":"802","5":"grams"},{"1":"tomatoes","2":"Better Boy","3":"8/11/20","4":"354","5":"grams"},{"1":"tomatoes","2":"Black Krim","3":"8/11/20","4":"359","5":"grams"},{"1":"tomatoes","2":"Amish Paste","3":"8/11/20","4":"506","5":"grams"},{"1":"lettuce","2":"Lettuce Mixture","3":"8/11/20","4":"92","5":"grams"},{"1":"edamame","2":"edamame","3":"8/11/20","4":"109","5":"grams"},{"1":"corn","2":"Dorinny Sweet","3":"8/11/20","4":"330","5":"grams"},{"1":"lettuce","2":"Lettuce Mixture","3":"8/12/20","4":"73","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"8/13/20","4":"1774","5":"grams"},{"1":"beans","2":"Bush Bush Slender","3":"8/13/20","4":"468","5":"grams"},{"1":"beans","2":"Classic Slenderette","3":"8/13/20","4":"122","5":"grams"},{"1":"tomatoes","2":"grape","3":"8/13/20","4":"421","5":"grams"},{"1":"tomatoes","2":"Bonny Best","3":"8/13/20","4":"332","5":"grams"},{"1":"tomatoes","2":"Better Boy","3":"8/13/20","4":"727","5":"grams"},{"1":"tomatoes","2":"Amish Paste","3":"8/13/20","4":"642","5":"grams"},{"1":"tomatoes","2":"Big Beef","3":"8/13/20","4":"413","5":"grams"},{"1":"beans","2":"Chinese Red Noodle","3":"8/13/20","4":"65","5":"grams"},{"1":"cucumbers","2":"pickling","3":"8/13/20","4":"599","5":"grams"},{"1":"basil","2":"Isle of Naxos","3":"8/13/20","4":"12","5":"grams"},{"1":"beets","2":"Sweet Merlin","3":"8/13/20","4":"198","5":"grams"},{"1":"beets","2":"Gourmet Golden","3":"8/13/20","4":"308","5":"grams"},{"1":"Swiss chard","2":"Neon Glow","3":"8/13/20","4":"517","5":"grams"},{"1":"beets","2":"Sweet Merlin","3":"8/13/20","4":"2209","5":"grams"},{"1":"beets","2":"Gourmet Golden","3":"8/13/20","4":"2476","5":"grams"},{"1":"corn","2":"Dorinny Sweet","3":"8/14/20","4":"1564","5":"grams"},{"1":"lettuce","2":"Lettuce Mixture","3":"8/14/20","4":"80","5":"grams"},{"1":"tomatoes","2":"Bonny Best","3":"8/14/20","4":"711","5":"grams"},{"1":"tomatoes","2":"Old German","3":"8/14/20","4":"238","5":"grams"},{"1":"tomatoes","2":"Amish Paste","3":"8/14/20","4":"525","5":"grams"},{"1":"tomatoes","2":"Jet Star","3":"8/14/20","4":"181","5":"grams"},{"1":"tomatoes","2":"Big Beef","3":"8/14/20","4":"266","5":"grams"},{"1":"tomatoes","2":"volunteers","3":"8/14/20","4":"490","5":"grams"},{"1":"tomatoes","2":"grape","3":"8/14/20","4":"126","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"8/14/20","4":"371","5":"grams"},{"1":"corn","2":"Golden Bantam","3":"8/15/20","4":"383","5":"grams"},{"1":"cucumbers","2":"pickling","3":"8/15/20","4":"351","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"8/15/20","4":"859","5":"grams"},{"1":"basil","2":"Isle of Naxos","3":"8/15/20","4":"25","5":"grams"},{"1":"onions","2":"Long Keeping Rainbow","3":"8/15/20","4":"137","5":"grams"},{"1":"kale","2":"Heirloom Lacinto","3":"8/15/20","4":"71","5":"grams"},{"1":"lettuce","2":"Lettuce Mixture","3":"8/15/20","4":"56","5":"grams"},{"1":"tomatoes","2":"grape","3":"8/16/20","4":"477","5":"grams"},{"1":"tomatoes","2":"volunteers","3":"8/16/20","4":"328","5":"grams"},{"1":"lettuce","2":"Lettuce Mixture","3":"8/16/20","4":"45","5":"grams"},{"1":"tomatoes","2":"Bonny Best","3":"8/16/20","4":"543","5":"grams"},{"1":"tomatoes","2":"Old German","3":"8/16/20","4":"599","5":"grams"},{"1":"tomatoes","2":"Amish Paste","3":"8/16/20","4":"560","5":"grams"},{"1":"tomatoes","2":"Black Krim","3":"8/16/20","4":"291","5":"grams"},{"1":"tomatoes","2":"Better Boy","3":"8/16/20","4":"238","5":"grams"},{"1":"tomatoes","2":"Big Beef","3":"8/16/20","4":"397","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"8/16/20","4":"660","5":"grams"},{"1":"beans","2":"Bush Bush Slender","3":"8/16/20","4":"693","5":"grams"},{"1":"tomatoes","2":"Bonny Best","3":"8/17/20","4":"364","5":"grams"},{"1":"tomatoes","2":"Brandywine","3":"8/17/20","4":"305","5":"grams"},{"1":"tomatoes","2":"Amish Paste","3":"8/17/20","4":"588","5":"grams"},{"1":"tomatoes","2":"Better Boy","3":"8/17/20","4":"764","5":"grams"},{"1":"tomatoes","2":"grape","3":"8/17/20","4":"436","5":"grams"},{"1":"tomatoes","2":"volunteers","3":"8/17/20","4":"306","5":"grams"},{"1":"beans","2":"Classic Slenderette","3":"8/17/20","4":"350","5":"grams"},{"1":"beans","2":"Chinese Red Noodle","3":"8/17/20","4":"105","5":"grams"},{"1":"spinach","2":"Catalina","3":"8/17/20","4":"30","5":"grams"},{"1":"lettuce","2":"Lettuce Mixture","3":"8/17/20","4":"67","5":"grams"},{"1":"corn","2":"Golden Bantam","3":"8/17/20","4":"344","5":"grams"},{"1":"kale","2":"Heirloom Lacinto","3":"8/17/20","4":"173","5":"grams"},{"1":"basil","2":"Isle of Naxos","3":"8/18/20","4":"27","5":"grams"},{"1":"onions","2":"Long Keeping Rainbow","3":"8/18/20","4":"126","5":"grams"},{"1":"peppers","2":"variety","3":"8/18/20","4":"112","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"8/18/20","4":"1151","5":"grams"},{"1":"beans","2":"Bush Bush Slender","3":"8/18/20","4":"225","5":"grams"},{"1":"cucumbers","2":"pickling","3":"8/18/20","4":"2888","5":"grams"},{"1":"tomatoes","2":"Mortgage Lifter","3":"8/18/20","4":"608","5":"grams"},{"1":"tomatoes","2":"grape","3":"8/18/20","4":"136","5":"grams"},{"1":"tomatoes","2":"volunteers","3":"8/18/20","4":"148","5":"grams"},{"1":"tomatoes","2":"Black Krim","3":"8/18/20","4":"317","5":"grams"},{"1":"tomatoes","2":"Old German","3":"8/18/20","4":"105","5":"grams"},{"1":"tomatoes","2":"Bonny Best","3":"8/18/20","4":"271","5":"grams"},{"1":"spinach","2":"Catalina","3":"8/18/20","4":"39","5":"grams"},{"1":"lettuce","2":"Lettuce Mixture","3":"8/18/20","4":"87","5":"grams"},{"1":"cucumbers","2":"pickling","3":"8/18/20","4":"233","5":"grams"},{"1":"edamame","2":"edamame","3":"8/18/20","4":"527","5":"grams"},{"1":"potatoes","2":"purple","3":"8/19/20","4":"323","5":"grams"},{"1":"potatoes","2":"yellow","3":"8/19/20","4":"278","5":"grams"},{"1":"hot peppers","2":"thai","3":"8/19/20","4":"31","5":"grams"},{"1":"tomatoes","2":"Cherokee Purple","3":"8/19/20","4":"872","5":"grams"},{"1":"tomatoes","2":"Black Krim","3":"8/19/20","4":"579","5":"grams"},{"1":"tomatoes","2":"Better Boy","3":"8/19/20","4":"615","5":"grams"},{"1":"tomatoes","2":"Amish Paste","3":"8/19/20","4":"997","5":"grams"},{"1":"tomatoes","2":"Brandywine","3":"8/19/20","4":"335","5":"grams"},{"1":"tomatoes","2":"Big Beef","3":"8/19/20","4":"264","5":"grams"},{"1":"tomatoes","2":"grape","3":"8/19/20","4":"451","5":"grams"},{"1":"tomatoes","2":"volunteers","3":"8/19/20","4":"306","5":"grams"},{"1":"lettuce","2":"Lettuce Mixture","3":"8/20/20","4":"99","5":"grams"},{"1":"cucumbers","2":"pickling","3":"8/20/20","4":"70","5":"grams"},{"1":"tomatoes","2":"volunteers","3":"8/20/20","4":"333","5":"grams"},{"1":"tomatoes","2":"Brandywine","3":"8/20/20","4":"483","5":"grams"},{"1":"tomatoes","2":"Bonny Best","3":"8/20/20","4":"632","5":"grams"},{"1":"tomatoes","2":"Jet Star","3":"8/20/20","4":"360","5":"grams"},{"1":"tomatoes","2":"Better Boy","3":"8/20/20","4":"230","5":"grams"},{"1":"tomatoes","2":"Big Beef","3":"8/20/20","4":"344","5":"grams"},{"1":"tomatoes","2":"Amish Paste","3":"8/20/20","4":"1010","5":"grams"},{"1":"beans","2":"Classic Slenderette","3":"8/20/20","4":"328","5":"grams"},{"1":"beans","2":"Bush Bush Slender","3":"8/20/20","4":"287","5":"grams"},{"1":"lettuce","2":"Tatsoi","3":"8/20/20","4":"322","5":"grams"},{"1":"tomatoes","2":"grape","3":"8/20/20","4":"493","5":"grams"},{"1":"peppers","2":"green","3":"8/20/20","4":"252","5":"grams"},{"1":"peppers","2":"variety","3":"8/20/20","4":"70","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"8/20/20","4":"834","5":"grams"},{"1":"onions","2":"Long Keeping Rainbow","3":"8/20/20","4":"113","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"8/21/20","4":"1122","5":"grams"},{"1":"basil","2":"Isle of Naxos","3":"8/21/20","4":"34","5":"grams"},{"1":"jalapeño","2":"giant","3":"8/21/20","4":"509","5":"grams"},{"1":"tomatoes","2":"Cherokee Purple","3":"8/21/20","4":"1601","5":"grams"},{"1":"tomatoes","2":"Big Beef","3":"8/21/20","4":"842","5":"grams"},{"1":"tomatoes","2":"Black Krim","3":"8/21/20","4":"1538","5":"grams"},{"1":"tomatoes","2":"Amish Paste","3":"8/21/20","4":"428","5":"grams"},{"1":"tomatoes","2":"Old German","3":"8/21/20","4":"243","5":"grams"},{"1":"tomatoes","2":"Bonny Best","3":"8/21/20","4":"330","5":"grams"},{"1":"cucumbers","2":"pickling","3":"8/21/20","4":"997","5":"grams"},{"1":"tomatoes","2":"grape","3":"8/21/20","4":"265","5":"grams"},{"1":"tomatoes","2":"volunteers","3":"8/21/20","4":"562","5":"grams"},{"1":"carrots","2":"Dragon","3":"8/21/20","4":"457","5":"grams"},{"1":"tomatoes","2":"Amish Paste","3":"8/23/20","4":"1542","5":"grams"},{"1":"tomatoes","2":"Old German","3":"8/23/20","4":"801","5":"grams"},{"1":"tomatoes","2":"grape","3":"8/23/20","4":"436","5":"grams"},{"1":"cucumbers","2":"pickling","3":"8/23/20","4":"747","5":"grams"},{"1":"tomatoes","2":"Black Krim","3":"8/23/20","4":"1573","5":"grams"},{"1":"tomatoes","2":"Mortgage Lifter","3":"8/23/20","4":"704","5":"grams"},{"1":"tomatoes","2":"Brandywine","3":"8/23/20","4":"446","5":"grams"},{"1":"tomatoes","2":"Bonny Best","3":"8/23/20","4":"269","5":"grams"},{"1":"corn","2":"Dorinny Sweet","3":"8/23/20","4":"661","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"8/23/20","4":"2436","5":"grams"},{"1":"lettuce","2":"Lettuce Mixture","3":"8/23/20","4":"111","5":"grams"},{"1":"lettuce","2":"Lettuce Mixture","3":"8/24/20","4":"134","5":"grams"},{"1":"peppers","2":"green","3":"8/24/20","4":"115","5":"grams"},{"1":"tomatoes","2":"grape","3":"8/24/20","4":"75","5":"grams"},{"1":"kale","2":"Heirloom Lacinto","3":"8/24/20","4":"117","5":"grams"},{"1":"tomatoes","2":"Jet Star","3":"8/25/20","4":"578","5":"grams"},{"1":"tomatoes","2":"Brandywine","3":"8/25/20","4":"871","5":"grams"},{"1":"tomatoes","2":"Old German","3":"8/25/20","4":"115","5":"grams"},{"1":"tomatoes","2":"Bonny Best","3":"8/25/20","4":"629","5":"grams"},{"1":"beans","2":"Classic Slenderette","3":"8/25/20","4":"186","5":"grams"},{"1":"beans","2":"Bush Bush Slender","3":"8/25/20","4":"320","5":"grams"},{"1":"tomatoes","2":"volunteers","3":"8/25/20","4":"488","5":"grams"},{"1":"tomatoes","2":"grape","3":"8/25/20","4":"506","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"8/25/20","4":"920","5":"grams"},{"1":"cucumbers","2":"pickling","3":"8/25/20","4":"179","5":"grams"},{"1":"tomatoes","2":"Amish Paste","3":"8/25/20","4":"1400","5":"grams"},{"1":"tomatoes","2":"Big Beef","3":"8/25/20","4":"993","5":"grams"},{"1":"tomatoes","2":"Mortgage Lifter","3":"8/25/20","4":"1026","5":"grams"},{"1":"tomatoes","2":"Amish Paste","3":"8/26/20","4":"1886","5":"grams"},{"1":"tomatoes","2":"Old German","3":"8/26/20","4":"666","5":"grams"},{"1":"tomatoes","2":"Brandywine","3":"8/26/20","4":"1042","5":"grams"},{"1":"tomatoes","2":"Cherokee Purple","3":"8/26/20","4":"593","5":"grams"},{"1":"tomatoes","2":"Black Krim","3":"8/26/20","4":"216","5":"grams"},{"1":"tomatoes","2":"Better Boy","3":"8/26/20","4":"309","5":"grams"},{"1":"tomatoes","2":"Big Beef","3":"8/26/20","4":"497","5":"grams"},{"1":"tomatoes","2":"volunteers","3":"8/26/20","4":"261","5":"grams"},{"1":"tomatoes","2":"grape","3":"8/26/20","4":"819","5":"grams"},{"1":"corn","2":"Dorinny Sweet","3":"8/26/20","4":"1607","5":"grams"},{"1":"lettuce","2":"Lettuce Mixture","3":"8/27/20","4":"14","5":"grams"},{"1":"raspberries","2":"perrenial","3":"8/28/20","4":"29","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"8/28/20","4":"3244","5":"grams"},{"1":"lettuce","2":"Lettuce Mixture","3":"8/28/20","4":"85","5":"grams"},{"1":"basil","2":"Isle of Naxos","3":"8/29/20","4":"24","5":"grams"},{"1":"onions","2":"Long Keeping Rainbow","3":"8/29/20","4":"289","5":"grams"},{"1":"tomatoes","2":"grape","3":"8/29/20","4":"380","5":"grams"},{"1":"tomatoes","2":"volunteers","3":"8/29/20","4":"737","5":"grams"},{"1":"tomatoes","2":"Big Beef","3":"8/29/20","4":"1033","5":"grams"},{"1":"tomatoes","2":"Mortgage Lifter","3":"8/29/20","4":"1097","5":"grams"},{"1":"edamame","2":"edamame","3":"8/29/20","4":"483","5":"grams"},{"1":"peppers","2":"variety","3":"8/29/20","4":"627","5":"grams"},{"1":"jalapeño","2":"giant","3":"8/29/20","4":"352","5":"grams"},{"1":"potatoes","2":"purple","3":"8/29/20","4":"262","5":"grams"},{"1":"potatoes","2":"yellow","3":"8/29/20","4":"716","5":"grams"},{"1":"carrots","2":"Bolero","3":"8/29/20","4":"888","5":"grams"},{"1":"tomatoes","2":"volunteers","3":"8/29/20","4":"566","5":"grams"},{"1":"carrots","2":"greens","3":"8/29/20","4":"169","5":"grams"},{"1":"tomatoes","2":"Old German","3":"8/30/20","4":"861","5":"grams"},{"1":"tomatoes","2":"Brandywine","3":"8/30/20","4":"460","5":"grams"},{"1":"tomatoes","2":"Amish Paste","3":"8/30/20","4":"2934","5":"grams"},{"1":"tomatoes","2":"Cherokee Purple","3":"8/30/20","4":"599","5":"grams"},{"1":"tomatoes","2":"Bonny Best","3":"8/30/20","4":"155","5":"grams"},{"1":"tomatoes","2":"volunteers","3":"8/30/20","4":"822","5":"grams"},{"1":"tomatoes","2":"Mortgage Lifter","3":"8/30/20","4":"589","5":"grams"},{"1":"tomatoes","2":"Better Boy","3":"8/30/20","4":"393","5":"grams"},{"1":"tomatoes","2":"Jet Star","3":"8/30/20","4":"752","5":"grams"},{"1":"tomatoes","2":"grape","3":"8/30/20","4":"833","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"9/1/20","4":"2831","5":"grams"},{"1":"tomatoes","2":"volunteers","3":"9/1/20","4":"1953","5":"grams"},{"1":"beans","2":"Classic Slenderette","3":"9/1/20","4":"160","5":"grams"},{"1":"pumpkins","2":"saved","3":"9/1/20","4":"4758","5":"grams"},{"1":"pumpkins","2":"saved","3":"9/1/20","4":"2342","5":"grams"},{"1":"squash","2":"Blue (saved)","3":"9/1/20","4":"3227","5":"grams"},{"1":"squash","2":"Blue (saved)","3":"9/1/20","4":"5150","5":"grams"},{"1":"pumpkins","2":"Cinderella's Carraige","3":"9/1/20","4":"7350","5":"grams"},{"1":"tomatoes","2":"Old German","3":"9/1/20","4":"805","5":"grams"},{"1":"tomatoes","2":"Brandywine","3":"9/1/20","4":"178","5":"grams"},{"1":"tomatoes","2":"Cherokee Purple","3":"9/1/20","4":"201","5":"grams"},{"1":"tomatoes","2":"Amish Paste","3":"9/1/20","4":"1537","5":"grams"},{"1":"tomatoes","2":"Jet Star","3":"9/1/20","4":"773","5":"grams"},{"1":"tomatoes","2":"Mortgage Lifter","3":"9/1/20","4":"1202","5":"grams"},{"1":"corn","2":"Dorinny Sweet","3":"9/2/20","4":"798","5":"grams"},{"1":"peppers","2":"green","3":"9/2/20","4":"370","5":"grams"},{"1":"jalapeño","2":"giant","3":"9/2/20","4":"43","5":"grams"},{"1":"peppers","2":"variety","3":"9/2/20","4":"60","5":"grams"},{"1":"tomatoes","2":"grape","3":"9/3/20","4":"1131","5":"grams"},{"1":"tomatoes","2":"volunteers","3":"9/3/20","4":"610","5":"grams"},{"1":"tomatoes","2":"Big Beef","3":"9/3/20","4":"1265","5":"grams"},{"1":"jalapeño","2":"giant","3":"9/3/20","4":"102","5":"grams"},{"1":"tomatoes","2":"Amish Paste","3":"9/4/20","4":"2160","5":"grams"},{"1":"tomatoes","2":"Better Boy","3":"9/4/20","4":"2899","5":"grams"},{"1":"tomatoes","2":"grape","3":"9/4/20","4":"442","5":"grams"},{"1":"tomatoes","2":"volunteers","3":"9/4/20","4":"1234","5":"grams"},{"1":"tomatoes","2":"Jet Star","3":"9/4/20","4":"1178","5":"grams"},{"1":"tomatoes","2":"Mortgage Lifter","3":"9/4/20","4":"255","5":"grams"},{"1":"tomatoes","2":"Brandywine","3":"9/4/20","4":"430","5":"grams"},{"1":"onions","2":"Delicious Duo","3":"9/4/20","4":"33","5":"grams"},{"1":"Swiss chard","2":"Neon Glow","3":"9/4/20","4":"256","5":"grams"},{"1":"jalapeño","2":"giant","3":"9/4/20","4":"58","5":"grams"},{"1":"corn","2":"Dorinny Sweet","3":"9/5/20","4":"214","5":"grams"},{"1":"edamame","2":"edamame","3":"9/5/20","4":"1644","5":"grams"},{"1":"tomatoes","2":"volunteers","3":"9/6/20","4":"2377","5":"grams"},{"1":"tomatoes","2":"Bonny Best","3":"9/6/20","4":"710","5":"grams"},{"1":"tomatoes","2":"Amish Paste","3":"9/6/20","4":"1317","5":"grams"},{"1":"tomatoes","2":"Big Beef","3":"9/6/20","4":"1649","5":"grams"},{"1":"tomatoes","2":"grape","3":"9/6/20","4":"615","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"9/7/20","4":"3284","5":"grams"},{"1":"zucchini","2":"Romanesco","3":"9/8/20","4":"1300","5":"grams"},{"1":"potatoes","2":"yellow","3":"9/9/20","4":"843","5":"grams"},{"1":"broccoli","2":"Main Crop Bravado","3":"9/9/20","4":"102","5":"grams"},{"1":"Swiss chard","2":"Neon Glow","3":"9/9/20","4":"228","5":"grams"},{"1":"tomatoes","2":"Amish Paste","3":"9/10/20","4":"692","5":"grams"},{"1":"tomatoes","2":"Old German","3":"9/10/20","4":"674","5":"grams"},{"1":"tomatoes","2":"Better Boy","3":"9/10/20","4":"1392","5":"grams"},{"1":"tomatoes","2":"Mortgage Lifter","3":"9/10/20","4":"316","5":"grams"},{"1":"tomatoes","2":"Jet Star","3":"9/10/20","4":"754","5":"grams"},{"1":"tomatoes","2":"volunteers","3":"9/10/20","4":"413","5":"grams"},{"1":"tomatoes","2":"grape","3":"9/10/20","4":"509","5":"grams"},{"1":"kale","2":"Heirloom Lacinto","3":"9/12/20","4":"108","5":"grams"},{"1":"tomatoes","2":"grape","3":"9/15/20","4":"258","5":"grams"},{"1":"tomatoes","2":"volunteers","3":"9/15/20","4":"725","5":"grams"},{"1":"potatoes","2":"Russet","3":"9/16/20","4":"629","5":"grams"},{"1":"broccoli","2":"Main Crop Bravado","3":"9/16/20","4":"219","5":"grams"},{"1":"lettuce","2":"Lettuce Mixture","3":"9/16/20","4":"8","5":"grams"},{"1":"carrots","2":"King Midas","3":"9/17/20","4":"160","5":"grams"},{"1":"carrots","2":"Bolero","3":"9/17/20","4":"168","5":"grams"},{"1":"kohlrabi","2":"Crispy Colors Duo","3":"9/17/20","4":"191","5":"grams"},{"1":"tomatoes","2":"volunteers","3":"9/17/20","4":"212","5":"grams"},{"1":"tomatoes","2":"Brandywine","3":"9/18/20","4":"714","5":"grams"},{"1":"tomatoes","2":"Amish Paste","3":"9/18/20","4":"228","5":"grams"},{"1":"tomatoes","2":"Better Boy","3":"9/18/20","4":"670","5":"grams"},{"1":"tomatoes","2":"Bonny Best","3":"9/18/20","4":"1052","5":"grams"},{"1":"tomatoes","2":"Old German","3":"9/18/20","4":"1631","5":"grams"},{"1":"raspberries","2":"perrenial","3":"9/18/20","4":"137","5":"grams"},{"1":"tomatoes","2":"volunteers","3":"9/19/20","4":"2934","5":"grams"},{"1":"tomatoes","2":"Big Beef","3":"9/19/20","4":"304","5":"grams"},{"1":"tomatoes","2":"grape","3":"9/19/20","4":"1058","5":"grams"},{"1":"squash","2":"delicata","3":"9/19/20","4":"307","5":"grams"},{"1":"squash","2":"delicata","3":"9/19/20","4":"397","5":"grams"},{"1":"squash","2":"delicata","3":"9/19/20","4":"537","5":"grams"},{"1":"squash","2":"delicata","3":"9/19/20","4":"314","5":"grams"},{"1":"squash","2":"delicata","3":"9/19/20","4":"494","5":"grams"},{"1":"squash","2":"delicata","3":"9/19/20","4":"484","5":"grams"},{"1":"squash","2":"delicata","3":"9/19/20","4":"454","5":"grams"},{"1":"squash","2":"delicata","3":"9/19/20","4":"480","5":"grams"},{"1":"squash","2":"delicata","3":"9/19/20","4":"252","5":"grams"},{"1":"squash","2":"delicata","3":"9/19/20","4":"294","5":"grams"},{"1":"squash","2":"delicata","3":"9/19/20","4":"437","5":"grams"},{"1":"squash","2":"Waltham Butternut","3":"9/19/20","4":"1834","5":"grams"},{"1":"squash","2":"Waltham Butternut","3":"9/19/20","4":"1655","5":"grams"},{"1":"squash","2":"Waltham Butternut","3":"9/19/20","4":"1927","5":"grams"},{"1":"squash","2":"Waltham Butternut","3":"9/19/20","4":"1558","5":"grams"},{"1":"squash","2":"Waltham Butternut","3":"9/19/20","4":"1183","5":"grams"},{"1":"squash","2":"Red Kuri","3":"9/19/20","4":"1178","5":"grams"},{"1":"squash","2":"Red Kuri","3":"9/19/20","4":"706","5":"grams"},{"1":"squash","2":"Red Kuri","3":"9/19/20","4":"1686","5":"grams"},{"1":"squash","2":"Red Kuri","3":"9/19/20","4":"1785","5":"grams"},{"1":"squash","2":"Blue (saved)","3":"9/19/20","4":"1923","5":"grams"},{"1":"squash","2":"Blue (saved)","3":"9/19/20","4":"2120","5":"grams"},{"1":"squash","2":"Blue (saved)","3":"9/19/20","4":"2325","5":"grams"},{"1":"squash","2":"Blue (saved)","3":"9/19/20","4":"1172","5":"grams"},{"1":"pumpkins","2":"Cinderella's Carraige","3":"9/19/20","4":"1311","5":"grams"},{"1":"pumpkins","2":"Cinderella's Carraige","3":"9/19/20","4":"6250","5":"grams"},{"1":"pumpkins","2":"saved","3":"9/19/20","4":"1154","5":"grams"},{"1":"pumpkins","2":"saved","3":"9/19/20","4":"1208","5":"grams"},{"1":"pumpkins","2":"saved","3":"9/19/20","4":"2882","5":"grams"},{"1":"pumpkins","2":"saved","3":"9/19/20","4":"2689","5":"grams"},{"1":"pumpkins","2":"saved","3":"9/19/20","4":"3441","5":"grams"},{"1":"pumpkins","2":"saved","3":"9/19/20","4":"7050","5":"grams"},{"1":"pumpkins","2":"New England Sugar","3":"9/19/20","4":"1109","5":"grams"},{"1":"pumpkins","2":"New England Sugar","3":"9/19/20","4":"1028","5":"grams"},{"1":"pumpkins","2":"New England Sugar","3":"9/19/20","4":"1131","5":"grams"},{"1":"pumpkins","2":"New England Sugar","3":"9/19/20","4":"1302","5":"grams"},{"1":"pumpkins","2":"New England Sugar","3":"9/19/20","4":"1570","5":"grams"},{"1":"pumpkins","2":"New England Sugar","3":"9/19/20","4":"1359","5":"grams"},{"1":"pumpkins","2":"New England Sugar","3":"9/19/20","4":"1608","5":"grams"},{"1":"pumpkins","2":"New England Sugar","3":"9/19/20","4":"2277","5":"grams"},{"1":"pumpkins","2":"New England Sugar","3":"9/19/20","4":"1743","5":"grams"},{"1":"pumpkins","2":"New England Sugar","3":"9/19/20","4":"2931","5":"grams"},{"1":"kale","2":"Heirloom Lacinto","3":"9/20/20","4":"163","5":"grams"},{"1":"tomatoes","2":"Bonny Best","3":"9/21/20","4":"714","5":"grams"},{"1":"tomatoes","2":"volunteers","3":"9/21/20","4":"95","5":"grams"},{"1":"tomatoes","2":"Bonny Best","3":"9/25/20","4":"477","5":"grams"},{"1":"tomatoes","2":"Amish Paste","3":"9/25/20","4":"2738","5":"grams"},{"1":"tomatoes","2":"Black Krim","3":"9/25/20","4":"236","5":"grams"},{"1":"tomatoes","2":"Old German","3":"9/25/20","4":"1823","5":"grams"},{"1":"tomatoes","2":"grape","3":"9/25/20","4":"819","5":"grams"},{"1":"tomatoes","2":"Mortgage Lifter","3":"9/25/20","4":"2006","5":"grams"},{"1":"tomatoes","2":"Big Beef","3":"9/25/20","4":"659","5":"grams"},{"1":"tomatoes","2":"Better Boy","3":"9/25/20","4":"1239","5":"grams"},{"1":"tomatoes","2":"volunteers","3":"9/25/20","4":"1978","5":"grams"},{"1":"kale","2":"Heirloom Lacinto","3":"9/25/20","4":"28","5":"grams"},{"1":"Swiss chard","2":"Neon Glow","3":"9/25/20","4":"24","5":"grams"},{"1":"broccoli","2":"Main Crop Bravado","3":"9/25/20","4":"75","5":"grams"},{"1":"peppers","2":"variety","3":"9/25/20","4":"84","5":"grams"},{"1":"apple","2":"unknown","3":"9/26/20","4":"156","5":"grams"},{"1":"lettuce","2":"Lettuce Mixture","3":"9/26/20","4":"95","5":"grams"},{"1":"beans","2":"Bush Bush Slender","3":"9/27/20","4":"94","5":"grams"},{"1":"beans","2":"Classic Slenderette","3":"9/28/20","4":"81","5":"grams"},{"1":"lettuce","2":"Lettuce Mixture","3":"9/29/20","4":"139","5":"grams"},{"1":"broccoli","2":"Main Crop Bravado","3":"9/30/20","4":"134","5":"grams"},{"1":"carrots","2":"Dragon","3":"10/1/20","4":"883","5":"grams"},{"1":"carrots","2":"Bolero","3":"10/2/20","4":"449","5":"grams"},{"1":"Swiss chard","2":"Neon Glow","3":"10/3/20","4":"232","5":"grams"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>
  
  
  3. Read in this [data](https://www.kaggle.com/heeraldedhia/groceries-dataset) from the kaggle website. You will need to download the data first. Save it to your project/repo folder. Do some quick checks of the data to assure it has been read in appropriately.

  4. Write code to replicate the table shown below (open the .html file to see it) created from the `garden_harvest` data as best as you can. When you get to coloring the cells, I used the following line of code for the `colors` argument:
  

```r
colors = scales::col_numeric(
      palette = paletteer::paletteer_d(
        palette = "RColorBrewer::YlGn"
      ) %>% as.character()
```




  5. Create a table using `gt` with data from your project or from the `garden_harvest` data if your project data aren't ready.


```r
garden_harvest %>%
mutate(variety = str_to_title(variety),
       vegetable = str_to_title(vegetable)) %>%
group_by(variety, vegetable) %>%
summarise(`Mean Harvest` = mean(weight)) %>%
gt(rowname_col = "variety",
   groupname_col = "vegetable") %>%
  tab_header("Harvest Size") %>%
  tab_options(column_labels.background.color = "lightblue") %>%
  tab_footnote(footnote = "All values in grams (g)",
               locations = cells_column_labels("Mean Harvest"))
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#sywjmdqzhi .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#sywjmdqzhi .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#sywjmdqzhi .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#sywjmdqzhi .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#sywjmdqzhi .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#sywjmdqzhi .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#sywjmdqzhi .gt_col_heading {
  color: #333333;
  background-color: lightblue;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#sywjmdqzhi .gt_column_spanner_outer {
  color: #333333;
  background-color: lightblue;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#sywjmdqzhi .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#sywjmdqzhi .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#sywjmdqzhi .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#sywjmdqzhi .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#sywjmdqzhi .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#sywjmdqzhi .gt_from_md > :first-child {
  margin-top: 0;
}

#sywjmdqzhi .gt_from_md > :last-child {
  margin-bottom: 0;
}

#sywjmdqzhi .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#sywjmdqzhi .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#sywjmdqzhi .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#sywjmdqzhi .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#sywjmdqzhi .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#sywjmdqzhi .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#sywjmdqzhi .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#sywjmdqzhi .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#sywjmdqzhi .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#sywjmdqzhi .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#sywjmdqzhi .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#sywjmdqzhi .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#sywjmdqzhi .gt_left {
  text-align: left;
}

#sywjmdqzhi .gt_center {
  text-align: center;
}

#sywjmdqzhi .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#sywjmdqzhi .gt_font_normal {
  font-weight: normal;
}

#sywjmdqzhi .gt_font_bold {
  font-weight: bold;
}

#sywjmdqzhi .gt_font_italic {
  font-style: italic;
}

#sywjmdqzhi .gt_super {
  font-size: 65%;
}

#sywjmdqzhi .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="sywjmdqzhi" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="2" class="gt_heading gt_title gt_font_normal" style>Harvest Size</th>
    </tr>
    <tr>
      <th colspan="2" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1"></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">Mean Harvest<sup class="gt_footnote_marks">1</sup></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Tomatoes</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Amish Paste</td>
      <td class="gt_row gt_right">948.88000</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Better Boy</td>
      <td class="gt_row gt_right">688.00000</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Big Beef</td>
      <td class="gt_row gt_right">553.22222</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Black Krim</td>
      <td class="gt_row gt_right">617.72727</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Bonny Best</td>
      <td class="gt_row gt_right">419.96154</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Brandywine</td>
      <td class="gt_row gt_right">445.26667</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Cherokee Purple</td>
      <td class="gt_row gt_right">531.38462</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Grape</td>
      <td class="gt_row gt_right">341.59459</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Jet Star</td>
      <td class="gt_row gt_right">539.08333</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Mortgage Lifter</td>
      <td class="gt_row gt_right">776.00000</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Old German</td>
      <td class="gt_row gt_right">648.37500</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Volunteers</td>
      <td class="gt_row gt_right">701.23077</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Asparagus</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Asparagus</td>
      <td class="gt_row gt_right">20.00000</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Squash</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Blue (Saved)</td>
      <td class="gt_row gt_right">2652.83333</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Delicata</td>
      <td class="gt_row gt_right">404.54545</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Red Kuri</td>
      <td class="gt_row gt_right">1338.75000</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Waltham Butternut</td>
      <td class="gt_row gt_right">1631.40000</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Carrots</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Bolero</td>
      <td class="gt_row gt_right">323.00000</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Dragon</td>
      <td class="gt_row gt_right">465.50000</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Greens</td>
      <td class="gt_row gt_right">169.00000</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">King Midas</td>
      <td class="gt_row gt_right">139.16667</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Beans</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Bush Bush Slender</td>
      <td class="gt_row gt_right">401.52000</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Chinese Red Noodle</td>
      <td class="gt_row gt_right">89.00000</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Classic Slenderette</td>
      <td class="gt_row gt_right">181.66667</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Spinach</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Catalina</td>
      <td class="gt_row gt_right">41.95455</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Cilantro</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Cilantro</td>
      <td class="gt_row gt_right">17.33333</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Pumpkins</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Cinderella's Carraige</td>
      <td class="gt_row gt_right">4970.33333</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">New England Sugar</td>
      <td class="gt_row gt_right">1605.80000</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Saved</td>
      <td class="gt_row gt_right">3190.50000</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Kohlrabi</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Crispy Colors Duo</td>
      <td class="gt_row gt_right">191.00000</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Onions</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Delicious Duo</td>
      <td class="gt_row gt_right">88.33333</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Long Keeping Rainbow</td>
      <td class="gt_row gt_right">131.90000</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Corn</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Dorinny Sweet</td>
      <td class="gt_row gt_right">862.33333</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Golden Bantam</td>
      <td class="gt_row gt_right">363.50000</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Edamame</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Edamame</td>
      <td class="gt_row gt_right">690.75000</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Lettuce</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Farmer's Market Blend</td>
      <td class="gt_row gt_right">63.88889</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Lettuce Mixture</td>
      <td class="gt_row gt_right">76.32143</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Mustard Greens</td>
      <td class="gt_row gt_right">23.00000</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Reseed</td>
      <td class="gt_row gt_right">15.00000</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Tatsoi</td>
      <td class="gt_row gt_right">145.88889</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Radish</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Garden Party Mix</td>
      <td class="gt_row gt_right">47.66667</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Jalapeño</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Giant</td>
      <td class="gt_row gt_right">160.40000</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Beets</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Gourmet Golden</td>
      <td class="gt_row gt_right">530.83333</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Leaves</td>
      <td class="gt_row gt_right">25.25000</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Sweet Merlin</td>
      <td class="gt_row gt_right">362.12500</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Peppers</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Green</td>
      <td class="gt_row gt_right">204.50000</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Variety</td>
      <td class="gt_row gt_right">185.37500</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Kale</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Heirloom Lacinto</td>
      <td class="gt_row gt_right">140.56250</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Basil</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Isle Of Naxos</td>
      <td class="gt_row gt_right">32.66667</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Peas</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Magnolia Blossom</td>
      <td class="gt_row gt_right">281.91667</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Super Sugar Snap</td>
      <td class="gt_row gt_right">289.33333</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Broccoli</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Main Crop Bravado</td>
      <td class="gt_row gt_right">132.50000</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Yod Fah</td>
      <td class="gt_row gt_right">372.00000</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Swiss Chard</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Neon Glow</td>
      <td class="gt_row gt_right">192.92857</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Chives</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Perrenial</td>
      <td class="gt_row gt_right">8.00000</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Raspberries</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Perrenial</td>
      <td class="gt_row gt_right">76.63636</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Strawberries</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Perrenial</td>
      <td class="gt_row gt_right">59.20000</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Cucumbers</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Pickling</td>
      <td class="gt_row gt_right">618.15625</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Potatoes</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Purple</td>
      <td class="gt_row gt_right">267.50000</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Russet</td>
      <td class="gt_row gt_right">629.00000</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Yellow</td>
      <td class="gt_row gt_right">509.60000</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Zucchini</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Romanesco</td>
      <td class="gt_row gt_right">944.91176</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Hot Peppers</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Thai</td>
      <td class="gt_row gt_right">22.33333</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Variety</td>
      <td class="gt_row gt_right">299.50000</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="2" class="gt_group_heading">Apple</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_stub">Unknown</td>
      <td class="gt_row gt_right">156.00000</td>
    </tr>
  </tbody>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="2">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          All values in grams (g)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->
  
  
  6. Use `patchwork` operators and functions to combine at least two graphs using your project data or `garden_harvest` data if your project data aren't ready.


```r
garden_harvest %>% 
  filter(vegetable%in%c("lettuce")) %>%
  group_by(date,variety) %>%
  ggplot(mapping = aes(x=variety,y=weight,fill=variety)) +
  geom_boxplot() +
  coord_flip() +
  scale_fill_brewer(palette = "Greens") +
  theme(axis.title.y = element_blank(),
        axis.title.x=element_blank(),
        axis.ticks.x=element_blank(),
        panel.background = element_rect(fill = "grey")) +
  labs(title = "Daily Harvest Size Distribution (g)",
       x= "Daily Weight of Harvest (g)",
       fill = "Variety") -> lettuce_graph

garden_harvest %>% 
  filter(vegetable%in%c("lettuce")) %>%
  rename(Date = date,
         Weight = weight,
         Variety = variety) %>%
  mutate(`Cumulative Harvest` = cumsum(Weight)) %>%
  ggplot() +
  geom_line(aes(x = Date,
             y = `Cumulative Harvest`)) +
  theme(panel.background = element_rect(fill = "grey"),
        axis.title.x = element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y = element_blank(),
        legend.position = "none") +
  scale_color_brewer(palette = "Greens") +
  labs(title = "Cumulative Harvest") -> lettuce_graph_2

garden_harvest %>%
  filter(vegetable%in%c("lettuce")) %>%
  group_by(variety) %>%
  summarise(tot_harvest = sum(weight)) %>%
  ggplot(aes(x = variety, y = tot_harvest)) +
  geom_col(aes(fill = variety)) +
  scale_fill_brewer(palette = "Greens") +
  theme(panel.background = element_rect(fill = "grey"),
        axis.title = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks = element_blank(),
        legend.position = "none") +
  labs(title = "Total Harvest Weight (g)") -> lettuce_graph_3

lettuce_graph / (lettuce_graph_2|lettuce_graph_3) +
 plot_annotation(title = "Lettuce Harvest ") 
```

![](06_exercises_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

  
  7. COMING SOON! Web scraping problem.

  
**DID YOU REMEMBER TO UNCOMMENT THE OPTIONS AT THE TOP?**
