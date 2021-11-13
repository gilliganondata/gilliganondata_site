######################
# Quantize It (Magick)

# This reduces the number of unique colors in the image
mgk_max_colors <- sample(4:16, 1)

# Output what is being done to the console and add it to the overall 
# description of the transformations
msg_settings <- paste("Quantize (magick) -> Max Colors in Image:", mgk_max_colors)
message(msg_settings)
trans_description <<- paste(trans_description, msg_settings, "\n")

# Perform the transformation
img_trans <<- image_read(img_trans) %>% 
  image_quantize(max = mgk_max_colors) %>% 
  image_write(format = "jpg") %>% 
  readJPEG()

# Check to ensure image is not stored as grayscale and convert to color if so.
img_trans <<- check_for_color(img_trans)