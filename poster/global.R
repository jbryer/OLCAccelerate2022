# Packages for the shiny poster
library(shiny)
library(tidyverse)
library(shinyWidgets)
library(shinyjs)
library(shinydashboard)
library(gt)
library(gtsummary)
library(shinyfullscreen)

# Add other packages here
library(GGally)
library(likert)

source('R/utilities.R')
source('R/renderRmd.R')
source('R/word_cloud.R')

mass <- readRDS('data/mass.rds')
omp <- readRDS('data/omp.rds')

# Set the accuracy for ggplot2 labels
pct_format = scales::percent_format(accuracy = .1)

navbar_title <- div(a(img(src="CUNY_MSDS_Hex.png", height=35), # image must be in www/ folder
					  href= "http://catalog.sps.cuny.edu/preview_program.php?catoid=2&poid=607", target='_new'),
					a(img(src="DAACS.png", height=35), # image must be in www/ folder
					  href= "https://daacs.net", target='_new'),
					a(img(src="DATA606.png", height=35), # image must be in www/ folder
					  href= "https://data606.net", target='_new'),
					style = "position: relative; top: -5px;")

poster_title <- "Strategies for Supporting Students' Self-Regulated Learning within the Course"

poster_authors <- div(
	style = 'font-size: 16px;',
	'Jason Bryer, Ph.D.',
	superscript(a(icon('envelope'), href='mailto:jason.bryer@cuny.edu', target='_new')), ' ',
	superscript(a(icon('twitter'), href='https://twitter.com/jbryer', target='_new')), ' ',
	superscript(a(icon('github'), href='https://github.com/jbryer', target='_new')), ' ',
	superscript(a(icon('globe'), href='https://bryer.org', target='_new'))
)

background_color <- "ghostwhite"
box_background_color <- 'ghostwhite'

# These tabs will have a white background
tabs_with_white_background <- c('Paper')

# This will force running the app in the default web browser.
if(interactive()) {
   options(shiny.launch.browser = .rs.invokeShinyWindowExternal)
}

##### Load data  ###############################################################

data(mtcars)
mtcars$cyl <- as.factor(mtcars$cyl)

##### Setup data for demographics tab ##########################################
poster_data <- mtcars
primary_variables <- names(poster_data)
secondary_variables <- names(poster_data)

source('../shiny_formative/global.R', local = TRUE)
