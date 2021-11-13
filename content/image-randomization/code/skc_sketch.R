######################
# Sketch It  

# Pick random values for the sketch settings
sk_style <- sample(2, 1)        # Style for sketch; will be 1 or 2
sk_lineweight <- sample(6, 1)   # Lineweight for sketch; will be 1 through 6
sk_contrast <- sample(10:60, 1) # Contrast for sketch; will be 10 through 60
sk_shadow <- runif(1)           # Shadow for sketch; will be between 0 and 1
sk_gain <- runif(1)             # Gain for sketch; will be between 0 and 1

# Output what is being done to the console and add it to the overall 
# description of the transformations
msg_settings <- paste("Sketching (sketcher) -> Style:", sk_style,
                      "| Lineweight:", sk_lineweight,
                      "| Contrast:", sk_contrast,
                      "| Shadow:", sk_shadow,
                      "| Gain:", sk_gain)
message(msg_settings)
trans_description <<- paste(trans_description, msg_settings, "\n")

img_trans <<- sketch(im = img_trans,
                    style = sk_style,
                    lineweight = sk_lineweight,
                    contrast = sk_contrast,
                    shadow = sk_shadow,
                    gain = sk_gain,
                    max.size = max_img_width)

# Check to ensure image is not stored as grayscale and convert to color if so.
img_trans <<- check_for_color(img_trans)

