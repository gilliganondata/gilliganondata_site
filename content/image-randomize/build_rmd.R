# Script to actually build the .Rmd file that will be a new page for the specific
# image

# Create an image ID that can be used as a unique identifier
img_id <- gsub("(^.*images\\/)(.*)(_original.*$)", "\\2", img_out_path)

# Create the YAML header. We're including the URLs for the original and
# the transformed images so we can make images in the list page
yaml <- paste("---",
              "title: Random Manipulation of a Random SmugMug Image",
              "author: Tim Wilson",
              paste0("date: ", as.character(Sys.Date())),
              paste0("slug: random-image-", img_id),
              "categories:",
              "  - R",
              "tags:",
              "  - Github Actions",
              "  - SmugMug",
              "  - Twitter",
              "  - ImageMagick",
              "type: image-randomization",
              paste0("img_original: ", gsub(rel_path,"",img_out_path)),
              paste0("img_transformed: ", gsub(rel_path,"",img_trans_out_path)),
              "---\n\n",
              sep = "\n")


# Intro text
intro <- "For details on the nuts and bolts behind this project, see <a href=\"/projects/random-image-manipulation/\" target = \"_blank\">this post</a>.\n"

# Create a string for the original image. 
orig_loc <- paste0("Original image source: ", img_url_rmd, "\n\n")

# Show the original image. 
orig_img <- paste0("![](/image-randomize/",gsub(rel_path,"",img_out_path),"){width=100%}\n\n")

# List the transformations performed
trans_perf <- paste("Transformations performed:\n",
                    trans_description,
                    "\n",
                    "The resulting image:",
                    "\n",
                    sep = "\n")

# Show the final image
final_img <- paste0("![](/image-randomize/",gsub(rel_path,"",img_trans_out_path),"){width=100%}\n")

# Create the file path—one for where to put it in the repo and one
# that will be the final URL (used in the tweet)
file_write_path <- paste0(rel_path, "output/", Sys.Date(), "-", img_id, ".Rmd")
final_url <- paste0("https://gilliganondata.com/image-randomize/output/random-image-", img_id, "/")

# Create the output file
write(paste(yaml, 
            intro,
            orig_loc, 
            orig_img,
            trans_perf,
            final_img),
      file = paste0(rel_path, "output/", Sys.Date(), "-", img_id, ".Rmd"),
      append = FALSE)


# Create a simple list object that can be saved as an RDS object and then 
# referenced for the tweeting
tweet_details <- list(page_url = final_url,
                      orig_img_path = img_out_path, 
                      trans_img_path = img_trans_out_path)
saveRDS(tweet_details, paste0(rel_path, "output/tweet_details.rds"))
