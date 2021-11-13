# Some of the operations at some times make img_trans grayscale. That then causes
# other operations to break. This function takes an image passed in as an array and,
# if it only has one color channel, turns it into a 3D array by adding color channels
# an w x h x 3 instead of w x h x 1.
check_for_color <- function(img){
  if(dim(img)[3] == 1 | is.na(dim(img)[3])){
    img_temp <- array(dim = c(dim(img_orig)[1],
                              dim(img_orig)[2],
                              3))
    img_temp[,,1:3] <- img  # Recycling will duplicate values across all channels
    return(img_temp)
  } else {
    if(dim(img)[3] == 3){
      return(img)
    } else {
      message("Checking for color depth returned unexpected result. It did not meet the expected conditions.",
              "The transformed image had neither 1, 3, or no color channels.")
      return(img)
    }
  }
}
