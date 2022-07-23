# Pick a random row
random_id <- sample(nrow(all_images), 1)

# We'll need to make one more API call to get the image URL
img_uri <- all_images$LargestImgUri[[random_id]]

# This gets us the image details that actually has the URL for the largest version of
# the image in it
img_details <- GET(url ="http://www.smugmug.com",
                   query = list(APIKey = sm_key),
                   path = img_uri,
                   accept_json()) %>% 
  content()

# Extract the actual web URL for the image
img_url <- img_details$Response$LargestImage$Url

# Get the image URL to use in the final web page. This will actually include
# the album name and make it so a user can get back to the overall SmugMug site
# more easily
img_url_rmd <- all_images$WebUri[[random_id]]

# Write the image URL details to the console (for troubleshooting)
cat("img_url:", img_url, "\n")
cat("img_url_rmd", img_url_rmd, "\n")

# Come up with the file name to save the image as. It's the filename +
# the current date + the file extension. One filename for the original and
# one filename for the transformed image
img_out_path <- paste0(rel_path, "images/",
                       gsub("(^.*)\\/(.*)(\\.jpg)", "\\2", img_url), "_original_",
                       as.character(Sys.Date()),
                       gsub("(^.*)\\/(.*)(\\.jpg)", "\\3", img_url))
img_trans_out_path <- gsub("original", "transformed", img_out_path)

# Download the image
img_orig <- tempfile()
download.file(img_url, img_orig, mode = "wb")

# Let's go ahead and work with "max size" of the image.
# If it's smaller than that already, fine. Otherwise, scale it down.
if(image_read(img_orig) %>% image_info() %>% .$width > max_img_width){
  img_orig <- image_read(img_orig) %>% image_scale(as.character(max_img_width))
  img_orig <- image_write(img_orig)
}

img_orig <- readJPEG(img_orig) 
writeJPEG(img_orig, img_out_path)