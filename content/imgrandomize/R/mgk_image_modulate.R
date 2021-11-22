######################
# Modulate It (Magick)

# Image modulation random values
mgk_brightness <- sample(50:150, 1)          # Brightness. 100 is "current"
mgk_saturation <- sample(50:150, 1)          # Saturation. 100 is "current"
mgk_hue <- sample(0:200, 1)                  # Hue. 100 is "current"

# Output what is being done to the console and add it to the overall 
# description of the transformations
msg_settings <- paste("* Modulation (magick) -> Brightness:", mgk_brightness,
                      "| Saturation:", mgk_saturation,
                      "| Hue:", mgk_hue)
message(msg_settings)
trans_description <<- paste(trans_description, msg_settings, "\n")

# Perform the transformation
img_trans <<- image_read(img_trans) %>% 
  image_modulate(brightness = mgk_brightness,
                 saturation = mgk_saturation,
                 hue = mgk_hue) %>% 
  image_write(format = "jpg") %>% 
  readJPEG()

# Check to ensure image is not stored as grayscale and convert to color if so.
img_trans <<- check_for_color(img_trans)