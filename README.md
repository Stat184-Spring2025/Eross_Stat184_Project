# Baseball Savant's Run Value and MLB Awards

This repo is made to run exploratory data analysis on MLB stats and awards. Our group is honing in on batter Run Value, a stat created by MLB's Baseball Savant. We are using Run Value to examine its efficacy on a player's likelihood to win offensive awards.

## Overview

This repo digs into what powers the decision-making behind what batters win MLB awards. There has been a lot of discussion on if adavanced stats like Run Value matter when selecting hitters for awards. Additionally, this project helps derive what goes into run value calculations, and compares run value's importance in predicting awards. If readers are curious what players are likely to win offensive awards, this repo gives insight on what players are most likely to win given their advanced metrics.

### Interesting Insight

One interesting insight we discovered was that WAR (wins above replacement, from Baseball Reference) is actually a better predictor of who will win MVP (most valubale player) compared to run value. This was calculated by comparing the R squared values of run value vs votes and WAR vs votes, in which WAR was greater. This makese sense because WAR takes other aspects of the game into account (such as defense and baserunning) and better captures the best overall player, deemed most valuable by voters.  

## Repo Structure

Readers should pay most attention to the final pdf file for all of their information. This is best to look at introductions to EDA and narrative text that accompanies our code. If a reader wanted to only look code for certain tables or visuals, they should refer to the named R file for that visual. Additionally, our data sets are loaded in as csv files for examination.

## Data Sources and Acknowledgements

Our data sets come from Baseball Savant (MLB's Statcast data website) and Baseball Reference (highly trusted baseball data page). Descriptions about various statistics were drawn from MLB.com and basebavant.com. Most of our analysis was however internally drawn out, following the structure in the project guidelines. All data comes from the 2019 MLB regular season.

More information about the data sets and sources are included under the introduction and data provenance sections in the final qmd and pdf files. 

## Authors

This was a full group collaboration project, names and emails listed below:
Andrew Eross - aje5706@psu.edu
Owen Wassel - orw5074@psu.edu
Nick McConnell - nam6087@psu.edu
