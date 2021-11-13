######################
# Median It (Magick)

# Image median random values
mgk_radius <- sample(15:50, 1)          # Radius for the median calcuation (pixels)

# Output what is being done to the console and add it to the overall 
# description of the transformations
msg_settings <- paste("Median (magick) -> Pixels:", mgk_radius)
message(msg_settings)
trans_description <<- paste(trans_description, msg_settings, "\n")

# Perform the transformation
img_trans <<- image_read(img_trans) %>% 
  image_median(radius = mgk_radius) %>% 
  image_write(format = "jpg") %>% 
  readJPEG()

# Check to ensure image is not stored as grayscale and convert to color if so.
img_trans <<- check_for_color(img_trans)
