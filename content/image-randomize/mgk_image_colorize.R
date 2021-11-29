######################
# Colorize It (Magick)

# Get a random color

# There are probably better ways to do this, but we'll just do a function
get_rand_hex <- function(){
    val <- sample(0:255, 1) %>% as.hexmode() %>% as.character()
    if(nchar(val) == 1){
      val <- paste0("0", val)
    }
    val
}

# Get a hex value for teach of the colors
val_r <- get_rand_hex()
val_g <- get_rand_hex()
val_b <- get_rand_hex()

mgk_color <- paste0("#", val_r, val_g, val_b)
mgk_opacity <- sample(25:60, 1)

rm(val_r, val_g, val_b)

# Output what is being done to the console and add it to the overall 
# description of the transformations
msg_settings <- paste("* Colorize (magick) -> Color:", mgk_color,
                      "| Opacity", percent(mgk_opacity/100))
message(msg_settings)
trans_description <<- paste(trans_description, msg_settings, "\n")

# Perform the transformation
img_trans <<- image_read(img_trans) %>% 
  image_colorize(opacity = mgk_opacity,
                 color = mgk_color) %>% 
  image_write(format = "jpg") %>% 
  readJPEG()

# Check to ensure image is not stored as grayscale and convert to color if so.
img_trans <<- check_for_color(img_trans)
