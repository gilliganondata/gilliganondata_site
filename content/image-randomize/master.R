# Random Image Selector and Transformer

# This script to pulls a random photo from Smugmug via the API (documentation: 
# https://api.smugmug.com/api/v2/doc). It is intended to work with publicly 
# available photos only, so no need to do OAuth stuff, but an API token is 
# still needed, as I understand it, to make the API calls.

# The basic steps in this script:
# 1. Get a random image from a Smugmug account
# 2. Apply a random # of transformations in random order w/ random settings
# 3. Generate an HTML file with the before and after
# 4. (Not done) Publish that HTML file and generate a tweet about it

# Setup / Package Load
# if (!require("pacman")) install.packages("pacman")
# pacman::p_load(tidyverse,
#                httr,
#                knitr,
#                jpeg,
#                magick,
#                sketcher,
#                scales,
#                blogdown)
library(dplyr)     # We don't need the entire Tidyverse
library(purrr)
library(httr)
library(knitr)
library(jpeg)      # For reading and writing images
library(magick)    # For playing with the images
library(sketcher)  # Line art / sketching of the images
library(scales)    # Show some percentages cleanly
library(blogdown)  # Added so can run serve_site() at the end

# This is just for GitHub Actions
options(blogdown.files_filter = filter_newfile("/content/image-randomize/output"))

# Needed for Github actions run
install_hugo("0.88.1")

# The client ID and secret are stored in .Renviron
sm_key <- Sys.getenv("SMUGMUG_KEY")
sm_secret <- Sys.getenv("SMUGMUG_SECRET")

# Set the account of interest
sm_user <- "twilson"

# Set the max image width in pixels
max_img_width <- 4096

# Relative path to this content
rel_path <- "content/image-randomize/"

# Create images and output folders if one doesn't exist
dir.create(paste0(rel_path, "images"), showWarnings = FALSE)
dir.create(paste0(rel_path, "output"), showWarnings = FALSE)

# Make a data frame with all of the image manipulation code snippet locations.
# The script will randomly re-order the data frame and then pick a random
# of rows to execute and will then apply those transformations
trans_df <- tibble(source_loc = c("mgk_image_modulate.R",
                                  "mgk_image_median.R",
                                  "mgk_image_colorize.R",
                                  "mgk_image_quantize.R",
                                  "skc_sketch.R")) %>% 
  mutate(source_loc = paste0(rel_path, source_loc))

# Get the list of albums for the user.
albums <- GET(url ="http://www.smugmug.com",
              query = list(APIKey = sm_key),
              path = sprintf("/api/v2/user/%s!albums", sm_user),
              accept_json()) %>% 
  content()

# List (character vector) of the albums
albums_list <- albums$Response$Album %>% 
  map_chr(~ .x$AlbumKey)

# Get the list of images
source(paste0(rel_path,"init_get_list_of_images.R"))

# Choose on image at random
source(paste0(rel_path,"init_get_random_image.R"))

# Create function to check that image remains color (as stored) throughout
# the process.
source(paste0(rel_path,"check_for_color.R"))

# Start by setting the transformed image to be the original image
img_trans <- img_orig

# String that describes transformations
trans_description <- ""

# Shuffle the order of the transformations
trans_df <- sample(nrow(trans_df)) %>% 
  trans_df[.,]

# Choose how many transformations to apply (at least 1)
num_trans <- sample(nrow(trans_df), 1)

# To test just a single transformation
# num_trans <- 1

# Get a vector with the code sources to include
trans_code <- trans_df[1:num_trans,] %>% pull(source_loc)

# Function to run the source code
run_transformations <- function(source_loc){
  source(source_loc)
}

message("Original File: ", img_out_path)

temp <- map(trans_code, run_transformations)

writeJPEG(img_trans, img_trans_out_path)

if(nchar(trans_description) == 0){trans_description <- "None"}

# # Knit the output file
# rmarkdown::render(paste0(rel_path,"result_output.Rmd"),
#                   output_file = paste0("output/daily_image_", Sys.Date(), "_",
#                                        gsub("^.*\\/(.*)\\.jpg", "\\1", img_url),
#                                       ".html"))

# Create the output .Rmd
source(paste0(rel_path,"build_rmd.R"))

# # Serve the site to generate the HTML
# build_site(run_hugo = FALSE,
#            build_rmd = TRUE)